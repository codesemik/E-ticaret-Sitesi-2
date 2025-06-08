using System;
using System.Data;
using System.Configuration;
using MySqlConnector;
using System.IO;
using System.Transactions;

namespace eticaretkitap
{
    public partial class adminUrunler : System.Web.UI.Page
    {
        string connString = "Server=localhost;Database=kitapticaret;Uid=root;Pwd=;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                litKullaniciAdi.Text = Session["adminKullaniciAdi"] != null ? Session["adminKullaniciAdi"].ToString() : "Admin";
                UrunleriListele();
            }
        }

        private void UrunleriListele()
        {
            using (MySqlConnection conn = new MySqlConnection(connString))
            {
                string sql = @"
                    SELECT 
                        kitapID, kitapAdi, kategori, fiyat, adet, foto 
                    FROM 
                        urunler
                    ORDER BY 
                        kitapID DESC";

                MySqlDataAdapter da = new MySqlDataAdapter(sql, conn);
                DataTable dt = new DataTable();

                try
                {
                    conn.Open();
                    da.Fill(dt);
                    dlUrunler.DataSource = dt;
                    dlUrunler.DataBind();
                }
                catch (Exception ex)
                {
                    // lblHata.Text = "Veri çekme hatası: " + ex.Message;
                }
            }
        }

        protected void dlUrunler_ItemCommand(object source, System.Web.UI.WebControls.DataListCommandEventArgs e)
        {
            if (e.CommandName == "Sil")
            {
                if (int.TryParse(e.CommandArgument.ToString(), out int kitapId))
                {
                    UrunSil(kitapId);
                }
            }
            else if (e.CommandName == "Duzenle")
            {
                if (int.TryParse(e.CommandArgument.ToString(), out int kitapId))
                {
                    Response.Redirect($"adminUrunDuzenle.aspx?kitapID={kitapId}");
                }
            }
        }

        private void UrunSil(int kitapId)
        {
            using (MySqlConnection conn = new MySqlConnection(connString))
            {
                string sql = "DELETE FROM urunler WHERE kitapID = @kitapID";

                using (MySqlCommand cmd = new MySqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@kitapID", kitapId);

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        UrunleriListele();
                    }
                    catch (Exception ex)
                    {
                        // lblHata.Text = "Silme hatası: " + ex.Message;
                    }
                }
            }
        }

        protected void btnUrunEkle_Click(object sender, EventArgs e)
        {
            string urunAdi = txtUrunAdi.Text.Trim();
            int fiyat = int.Parse(txtFiyat.Text.Trim());
            int adet = int.Parse(txtAdet.Text.Trim());
            string kategoriAdi = ddlKategori.SelectedItem.Text;

            string dosyaAdi = "";
            if (fuResim.HasFile)
            {
                string klasorYolu = Server.MapPath("~/images/");
                string uzanti = Path.GetExtension(fuResim.FileName).ToLower();
                int sayac = 0;

                do
                {
                    dosyaAdi = sayac == 0 ? "kitap" + uzanti : $"kitap{sayac}{uzanti}";
                    sayac++;
                }
                while (File.Exists(Path.Combine(klasorYolu, dosyaAdi)));

                fuResim.SaveAs(Path.Combine(klasorYolu, dosyaAdi));
            }
            else
            {
                litMesaj.Text = "<span style='color:red;'>Lütfen bir resim seçin.</span>";
                return;
            }

            // Veritabanına kayıt
            using (MySqlConnection conn = new MySqlConnection(connString))
            {
                string query = "INSERT INTO urunler (kitapAdi, fiyat, foto, adet, kategori) VALUES (@adi, @fiyat, @resim, @adet, @kategori)";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@adi", urunAdi);
                cmd.Parameters.AddWithValue("@fiyat", fiyat);
                cmd.Parameters.AddWithValue("@resim", dosyaAdi);
                cmd.Parameters.AddWithValue("@adet", adet);
                cmd.Parameters.AddWithValue("@kategori", kategoriAdi);

                conn.Open();
                int sonuc = cmd.ExecuteNonQuery();
                if (sonuc > 0)
                {
                    litMesaj.Text = "<span style='color:green;'>Ürün başarıyla eklendi.</span>";
                }
                else
                {
                    litMesaj.Text = "<span style='color:red;'>Ürün eklenemedi.</span>";
                }
            }
        }

        protected void btnDetayEkle_Click(object sender, EventArgs e)
        {
            if (!int.TryParse(txtDetayKitapID.Text.Trim(), out int kitapID))
            {
                litDetayMesaj.Text = "Geçerli bir Kitap ID giriniz.";
                return;
            }

            string kitapAdi = txtKitapAdi.Text.Trim();
            string yazar = txtYazar.Text.Trim();
            string yayinevi = txtYayinevi.Text.Trim();
            string isbn = txtISBN.Text.Trim();

            int? basimYili = null;
            if (int.TryParse(txtBasimYili.Text.Trim(), out int by))
                basimYili = by;

            int? baskiSayisi = null;
            if (int.TryParse(txtBaskiSayisi.Text.Trim(), out int bs))
                baskiSayisi = bs;

            int? sayfaSayisi = null;
            if (int.TryParse(txtSayfaSayisi.Text.Trim(), out int ss))
                sayfaSayisi = ss;

            string dil = txtDil.Text.Trim();

            using (MySqlConnection conn = new MySqlConnection(connString))
            {
                string sql = @"INSERT INTO kitapdetay (kitapID, kitapAdi, yazar, yayinevi, isbn, basimYili, baskiSayisi, sayfaSayisi, dil)
                       VALUES (@kitapID, @kitapAdi, @yazar, @yayinevi, @isbn, @basimYili, @baskiSayisi, @sayfaSayisi, @dil)";

                using (MySqlCommand cmd = new MySqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@kitapID", kitapID);
                    cmd.Parameters.AddWithValue("@kitapAdi", kitapAdi);
                    cmd.Parameters.AddWithValue("@yazar", yazar);
                    cmd.Parameters.AddWithValue("@yayinevi", string.IsNullOrEmpty(yayinevi) ? (object)DBNull.Value : yayinevi);
                    cmd.Parameters.AddWithValue("@isbn", string.IsNullOrEmpty(isbn) ? (object)DBNull.Value : isbn);
                    cmd.Parameters.AddWithValue("@basimYili", basimYili.HasValue ? (object)basimYili.Value : DBNull.Value);
                    cmd.Parameters.AddWithValue("@baskiSayisi", baskiSayisi.HasValue ? (object)baskiSayisi.Value : DBNull.Value);
                    cmd.Parameters.AddWithValue("@sayfaSayisi", sayfaSayisi.HasValue ? (object)sayfaSayisi.Value : DBNull.Value);
                    cmd.Parameters.AddWithValue("@dil", string.IsNullOrEmpty(dil) ? (object)DBNull.Value : dil);

                    try
                    {
                        conn.Open();
                        int eklenen = cmd.ExecuteNonQuery();
                        if (eklenen > 0)
                        {
                            string sqlUpdateUrun = "UPDATE urunler SET detayvaryok = 1 WHERE kitapID = @kitapID";

                            using (MySqlCommand cmdUpdateUrun = new MySqlCommand(sqlUpdateUrun, conn))
                            {
                                cmdUpdateUrun.Parameters.AddWithValue("@kitapID", kitapID);
                                int affectedRows = cmdUpdateUrun.ExecuteNonQuery();
                            }

                            litDetayMesaj.Text = "Kitap detayı başarıyla eklendi ve ürün güncellendi.";

                            // Form temizleme
                            txtDetayKitapID.Text = "";
                            txtKitapAdi.Text = "";
                            txtYazar.Text = "";
                            txtYayinevi.Text = "";
                            txtISBN.Text = "";
                            txtBasimYili.Text = "";
                            txtBaskiSayisi.Text = "";
                            txtSayfaSayisi.Text = "";
                            txtDil.Text = "";
                        }
                        else
                        {
                            litDetayMesaj.Text = "Kitap detayı eklenemedi.";
                        }
                    }
                    catch (Exception ex)
                    {
                        litDetayMesaj.Text = "Hata: " + ex.Message;
                    }
                }
            }
        }

        protected void btnDetayGuncelle_Click(object sender, EventArgs e)
        {
            int kitapID;
            if (!int.TryParse(txtGuncelleKitapID.Text, out kitapID))
            {
                litDetayGuncelleMesaj.Text = "<span style='color: red;'>Geçersiz Kitap ID.</span>";
                return;
            }

            using (MySqlConnection conn = new MySqlConnection(connString))
            {
                try
                {
                    conn.Open();

                    string query = @"
                UPDATE kitapdetay 
                SET kitapAdi = @kitapAdi,
                    yazar = @yazar,
                    yayinevi = @yayinevi,
                    isbn = @isbn,
                    basimYili = @basimYili,
                    baskiSayisi = @baskiSayisi,
                    sayfaSayisi = @sayfaSayisi,
                    dil = @dil
                WHERE kitapID = @kitapID";

                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@kitapAdi", txtYeniKitapAdi.Text.Trim());
                        cmd.Parameters.AddWithValue("@yazar", txtYeniYazar.Text.Trim());
                        cmd.Parameters.AddWithValue("@yayinevi", string.IsNullOrEmpty(txtYeniYayinevi.Text) ? (object)DBNull.Value : txtYeniYayinevi.Text.Trim());
                        cmd.Parameters.AddWithValue("@isbn", string.IsNullOrEmpty(txtYeniISBN.Text) ? (object)DBNull.Value : txtYeniISBN.Text.Trim());

                        int basimYili;
                        cmd.Parameters.AddWithValue("@basimYili", int.TryParse(txtYeniBasimYili.Text, out basimYili) ? (object)basimYili : DBNull.Value);

                        int baskiSayisi;
                        cmd.Parameters.AddWithValue("@baskiSayisi", int.TryParse(txtYeniBaskiSayisi.Text, out baskiSayisi) ? (object)baskiSayisi : DBNull.Value);

                        int sayfaSayisi;
                        cmd.Parameters.AddWithValue("@sayfaSayisi", int.TryParse(txtYeniSayfaSayisi.Text, out sayfaSayisi) ? (object)sayfaSayisi : DBNull.Value);

                        cmd.Parameters.AddWithValue("@dil", string.IsNullOrEmpty(txtYeniDil.Text) ? (object)DBNull.Value : txtYeniDil.Text.Trim());

                        cmd.Parameters.AddWithValue("@kitapID", kitapID);

                        int result = cmd.ExecuteNonQuery();

                        if (result > 0)
                        {
                            litDetayGuncelleMesaj.Text = "<span style='color: green;'>Kitap detayları başarıyla güncellendi.</span>";
                        }
                        else
                        {
                            litDetayGuncelleMesaj.Text = "<span style='color: red;'>Güncelleme işlemi başarısız oldu.</span>";
                        }
                    }
                }
                catch (Exception ex)
                {
                    litDetayGuncelleMesaj.Text = "<span style='color: red;'>Hata: " + Server.HtmlEncode(ex.Message) + "</span>";
                }
            }
        }


        protected void btnDetayBul_Click(object sender, EventArgs e)
        {
            if (!int.TryParse(txtGuncelleKitapID.Text.Trim(), out int kitapID))
            {
                litDetayBulMesaj.Text = "Geçerli bir Kitap ID giriniz.";
                return;
            }

            using (MySqlConnection conn = new MySqlConnection(connString))
            {
                string sql = "SELECT * FROM kitapdetay WHERE kitapID = @kitapID";
                using (MySqlCommand cmd = new MySqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@kitapID", kitapID);

                    try
                    {
                        conn.Open();
                        using (var reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                txtYeniKitapAdi.Text = reader["kitapAdi"].ToString();
                                txtYeniYazar.Text = reader["yazar"].ToString();
                                txtYeniYayinevi.Text = reader["yayinevi"].ToString();
                                txtYeniISBN.Text = reader["isbn"].ToString();
                                txtYeniBasimYili.Text = reader["basimYili"] != DBNull.Value ? reader["basimYili"].ToString() : "";
                                txtYeniBaskiSayisi.Text = reader["baskiSayisi"] != DBNull.Value ? reader["baskiSayisi"].ToString() : "";
                                txtYeniSayfaSayisi.Text = reader["sayfaSayisi"] != DBNull.Value ? reader["sayfaSayisi"].ToString() : "";
                                txtYeniDil.Text = reader["dil"].ToString();

                                litDetayBulMesaj.Text = "Kitap detayı yüklendi.";
                            }
                            else
                            {
                                litDetayBulMesaj.Text = "Bu ID ile detay bulunamadı.";
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        litDetayBulMesaj.Text = "Hata: " + ex.Message;
                    }
                }
            }
        }
    }
}
