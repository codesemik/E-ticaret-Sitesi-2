using eticaretkitap;
using MySqlConnector;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;

namespace eticaretkitap
{
    public partial class sepet : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SepetiYukle();
                ToplamFiyatiGuncelle();
            }
        }

        private void SepetiYukle()
        {
            List<SepetItem> sepet = (List<SepetItem>)Session["Sepet"];
            decimal toplamSepetFiyati = 0;

            if (sepet != null && sepet.Count > 0)
            {
                foreach (var item in sepet)
                {
                    item.toplamFiyat = item.Adet * item.Fiyat;
                    toplamSepetFiyati += item.toplamFiyat; // Toplamı hesapla
                }

                SepetGridView.DataSource = sepet;
                SepetGridView.DataBind();

                // Toplam fiyatı Literal kontrolüne yazdır
                lblGenelToplam.Text = toplamSepetFiyati.ToString("C");
            }
            else
            {
                // Sepet boşsa
                SepetGridView.DataSource = null;
                SepetGridView.DataBind();
                lblGenelToplam.Text = "0.00 TL"; // veya uygun bir mesaj
            }
        }

        protected void SepetGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Silinecek ürünün ID'sini DataKeys koleksiyonundan alıyoruz.
            int urunId = Convert.ToInt32(SepetGridView.DataKeys[e.RowIndex].Value);

            // Session'dan sepet listesini alıyoruz.
            List<SepetItem> sepet = (List<SepetItem>)Session["Sepet"];

            if (sepet != null)
            {
                // Silinecek ürünü listeden buluyoruz.
                SepetItem silinecekItem = sepet.FirstOrDefault(item => item.UrunID == urunId);

                if (silinecekItem != null)
                {
                    if (silinecekItem.Adet > 1)
                    {
                        // Adet 1'den fazlaysa sadece 1 azalt
                        silinecekItem.Adet--;
                        silinecekItem.toplamFiyat = silinecekItem.Adet * silinecekItem.Fiyat;
                    }
                    else
                    {
                        // Adet 1 ise ürünü tamamen sil
                        sepet.Remove(silinecekItem);
                    }

                    // Güncellenmiş sepet listesini Session'a geri kaydediyoruz.
                    Session["Sepet"] = sepet;

                    // GridView'i yeniden yüklüyoruz ki değişiklikler görünsün.
                    SepetiYukle();
                }
            }
        }

        protected void BtnSatınAl_Click(object sender, EventArgs e)
        {
            string kullaniciEmail = Session["mail"] as string;
            if (string.IsNullOrEmpty(kullaniciEmail))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "<script>alert('Lütfen giriş yapın!');</script>");
                return;
            }

            int userID = 0;
            string connectionString = "Server=localhost;Port=3306;Database=kitapticaret;Uid=root;";

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string userIdQuery = "SELECT userID FROM users WHERE mail = @mail";
                MySqlCommand cmdUser = new MySqlCommand(userIdQuery, conn);
                cmdUser.Parameters.AddWithValue("@mail", kullaniciEmail);
                object result = cmdUser.ExecuteScalar();

                if (result == null)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "<script>alert('Kullanıcı bulunamadı!');</script>");
                    return;
                }
                userID = Convert.ToInt32(result);
            }

            List<SepetItem> sepet = (List<SepetItem>)Session["Sepet"];
            if (sepet == null || sepet.Count == 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "<script>alert('Sepetinizde ürün bulunmamaktadır!');</script>");
                return;
            }

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                using (MySqlTransaction transaction = conn.BeginTransaction())
                {
                    try
                    {
                        decimal toplamSiparisFiyati = sepet.Sum(item => item.Adet * item.Fiyat);

                        // Sipariş satırlarını tek tek insert edeceğiz
                        foreach (var item in sepet)
                        {
                            string insertQuery = @"
                        INSERT INTO siparis (userID, SiparisTarihi, Durum, ToplamFiyat, urunID, adet, fiyat)
                        VALUES (@userID, @SiparisTarihi, @Durum, @ToplamFiyat, @urunID, @adet, @fiyat)";

                            MySqlCommand cmdInsert = new MySqlCommand(insertQuery, conn, transaction);
                            cmdInsert.Parameters.AddWithValue("@userID", userID);
                            cmdInsert.Parameters.AddWithValue("@SiparisTarihi", DateTime.Now);
                            cmdInsert.Parameters.AddWithValue("@Durum", "Beklemede");
                            cmdInsert.Parameters.AddWithValue("@ToplamFiyat", toplamSiparisFiyati); // toplam sipariş fiyatı tüm satırlarda aynı tutuluyor
                            cmdInsert.Parameters.AddWithValue("@urunID", item.UrunID);
                            cmdInsert.Parameters.AddWithValue("@adet", item.Adet);
                            cmdInsert.Parameters.AddWithValue("@fiyat", item.Fiyat);

                            cmdInsert.ExecuteNonQuery();

                            // Stok güncelle
                            string stokGuncelleQuery = "UPDATE urunler SET adet = adet - @adet WHERE kitapID = @kitapID";
                            MySqlCommand stokCmd = new MySqlCommand(stokGuncelleQuery, conn, transaction);
                            stokCmd.Parameters.AddWithValue("@adet", item.Adet);
                            stokCmd.Parameters.AddWithValue("@kitapID", item.UrunID);
                            stokCmd.ExecuteNonQuery();
                        }

                        transaction.Commit();

                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "<script>alert('Siparişiniz başarıyla alınmıştır!');</script>");
                        Session.Remove("Sepet");
                        SepetiYukle();
                        ToplamFiyatiGuncelle();
                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
                        Response.Write("Hata: " + ex.Message);
                    }
                }
            }
        }

        protected void SepetGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Arttir")
            {
                // ... (Mevcut Arttir butonu kodunuz)
                int index = Convert.ToInt32(e.CommandArgument);
                int urunId = Convert.ToInt32(SepetGridView.DataKeys[index].Value);
                List<SepetItem> sepet = (List<SepetItem>)Session["Sepet"];

                if (sepet != null)
                {
                    SepetItem mevcutUrun = sepet.FirstOrDefault(item => item.UrunID == urunId);
                    if (mevcutUrun != null)
                    {
                        string connectionString = "Server=localhost;Port=3306;Database=kitapticaret;Uid=root;";
                        using (MySqlConnection conn = new MySqlConnection(connectionString))
                        {
                            conn.Open();
                            string stokQuery = "SELECT adet, kitapAdi FROM urunler WHERE kitapID = @kitapId";
                            MySqlCommand stokCmd = new MySqlCommand(stokQuery, conn);
                            stokCmd.Parameters.AddWithValue("@kitapId", urunId);

                            using (MySqlDataReader stokReader = stokCmd.ExecuteReader())
                            {
                                if (stokReader.Read())
                                {
                                    int mevcutStok = Convert.ToInt32(stokReader["adet"]);
                                    string urunAdi = stokReader["kitapAdi"].ToString();

                                    if (mevcutUrun.Adet + 1 > mevcutStok)
                                    {
                                        string script = $"<script type=\"text/javascript\">alert('{urunAdi} için stokta yeterli ürün bulunmamaktadır. Mevcut stok: {mevcutStok}, Sepetteki adet: {mevcutUrun.Adet}');</script>";
                                        ClientScript.RegisterStartupScript(this.GetType(), "adetArttirmaStokUyarisi", script);
                                        return;
                                    }

                                    mevcutUrun.Adet++;
                                    Session["Sepet"] = sepet;
                                    SepetiYukle();
                                    ToplamFiyatiGuncelle();
                                }
                            }
                        }
                    }
                }
            }
            else if (e.CommandName == "Azalt") // Yeni Azalt butonu işlevi
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int urunId = Convert.ToInt32(SepetGridView.DataKeys[index].Value);
                List<SepetItem> sepet = (List<SepetItem>)Session["Sepet"];

                if (sepet != null)
                {
                    SepetItem mevcutUrun = sepet.FirstOrDefault(item => item.UrunID == urunId);
                    if (mevcutUrun != null)
                    {
                        if (mevcutUrun.Adet > 1)
                        {
                            mevcutUrun.Adet--;
                            Session["Sepet"] = sepet;
                            SepetiYukle();
                            ToplamFiyatiGuncelle();
                        }
                        else
                        {
                            // Adet 1 ise ürünü sepetten çıkar
                            sepet.Remove(mevcutUrun);
                            Session["Sepet"] = sepet;
                            SepetiYukle();
                            ToplamFiyatiGuncelle();
                        }
                    }
                }
            }
        }

        // Sepet verilerini GridView'a bağlayan metot (eğer henüz yoksa)
        private void BindSepet()
        {
            if (Session["Sepet"] != null)
            {
                SepetGridView.DataSource = (List<SepetItem>)Session["Sepet"];
                SepetGridView.DataBind();
            }
            else
            {
                SepetGridView.DataSource = null;
                SepetGridView.DataBind();
            }
        }

        // Toplam fiyatı hesaplayıp Literal kontrolüne yazdıran metot (eğer henüz yoksa)
        private void ToplamFiyatiGuncelle()
        {
            if (Session["Sepet"] != null)
            {
                List<SepetItem> sepet = (List<SepetItem>)Session["Sepet"];
                decimal toplamFiyat = sepet.Sum(item => item.toplamFiyat); // Doğrudan toplamFiyat özelliğini kullan
                lblGenelToplam.Text = toplamFiyat.ToString("C");
            }
            else
            {
                lblGenelToplam.Text = "0.00 TL";
            }
        }
    }
}