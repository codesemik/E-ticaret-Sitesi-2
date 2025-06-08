using MySqlConnector;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using System.Web.UI;
using System;

namespace eticaretkitap
{
    public partial class urunler : System.Web.UI.Page
    {
        string connStr = "Server=localhost;Port=3306;Database=kitapticaret;Uid=root;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UrunleriGetir(null); // Tüm ürünleri getir
            }
        }

        protected void rblKategoriler_SelectedIndexChanged(object sender, EventArgs e)
        {
            string secilenKategori = rblKategoriler.SelectedValue;
            if (string.IsNullOrEmpty(secilenKategori))
                UrunleriGetir(null);
            else
                UrunleriGetir(secilenKategori);
        }

        private void UrunleriGetir(string kategori)
        {
            string query;

            if (!string.IsNullOrEmpty(kategori))
            {
                query = "SELECT * FROM urunler WHERE kategori = @kategori AND detayvaryok = 1";
            }
            else
            {
                query = "SELECT * FROM urunler WHERE detayvaryok = 1";
            }

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                MySqlCommand cmd = new MySqlCommand(query, conn);
                if (!string.IsNullOrEmpty(kategori))
                    cmd.Parameters.AddWithValue("@kategori", kategori);

                try
                {
                    conn.Open();
                    using (MySqlDataReader dr = cmd.ExecuteReader())
                    {
                        dlUrunler.DataSource = dr;
                        dlUrunler.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("Veri çekme hatası: " + ex.Message);
                }
            }
        }

        protected void dlUrunler_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "SepeteEkle")
            {
                int urunId = Convert.ToInt32(e.CommandArgument);
                TextBox txtAdet = (TextBox)e.Item.FindControl("txtAdet");
                int istenenAdet = 1; // Varsayılan 1

                if (txtAdet != null && int.TryParse(txtAdet.Text, out int adet))
                {
                    istenenAdet = adet;
                }

                using (MySqlConnection conn = new MySqlConnection(connStr))
                {
                    conn.Open();
                    string stokQuery = "SELECT adet, kitapAdi, fiyat, foto FROM urunler WHERE kitapID = @urunId";
                    MySqlCommand stokCmd = new MySqlCommand(stokQuery, conn);
                    stokCmd.Parameters.AddWithValue("@urunId", urunId);

                    using (MySqlDataReader stokReader = stokCmd.ExecuteReader())
                    {
                        if (stokReader.Read())
                        {
                            int mevcutStok = Convert.ToInt32(stokReader["adet"]);
                            string urunAdi = stokReader["kitapAdi"].ToString();
                            decimal fiyat = Convert.ToDecimal(stokReader["fiyat"]);
                            string resimUrl = stokReader["foto"].ToString();

                            if (istenenAdet > mevcutStok)
                            {
                                string script = $"alert('{urunAdi} için stok yetersiz. Mevcut stok: {mevcutStok}');";
                                ScriptManager.RegisterStartupScript(this, GetType(), "stokUyarisi", script, true);
                                return;
                            }

                            List<SepetItem> sepet = Session["Sepet"] as List<SepetItem> ?? new List<SepetItem>();

                            SepetItem existingItem = sepet.Find(item => item.UrunID == urunId);
                            if (existingItem != null)
                            {
                                if (existingItem.Adet + istenenAdet > mevcutStok)
                                {
                                    string script = $"alert('{urunAdi} için sepetteki miktarla toplam istek stoğu aşıyor. Mevcut stok: {mevcutStok}');";
                                    ScriptManager.RegisterStartupScript(this, GetType(), "stokAsimiUyarisi", script, true);
                                    return;
                                }
                                existingItem.Adet += istenenAdet;
                                existingItem.toplamFiyat = existingItem.Adet * existingItem.Fiyat;
                            }
                            else
                            {
                                SepetItem yeniUrun = new SepetItem
                                {
                                    UrunID = urunId,
                                    UrunAdi = urunAdi,
                                    Fiyat = fiyat,
                                    ResimUrl = resimUrl,
                                    Adet = istenenAdet,
                                    toplamFiyat = fiyat * istenenAdet
                                };
                                sepet.Add(yeniUrun);
                            }

                            Session["Sepet"] = sepet;
                        }
                    }
                }
            }
        }

    }

    public class SepetItem
    {
        public int UrunID { get; set; }
        public string UrunAdi { get; set; }
        public decimal Fiyat { get; set; }
        public string ResimUrl { get; set; }
        public int Adet { get; set; }
        public decimal toplamFiyat { get; set; }
    }

public class kullanicilar
    {
        public int name { get; set; }
        public string surname { get; set; }
        public decimal username { get; set; }
        public string mail { get; set; }
        public int password { get; set; }
    }
}
