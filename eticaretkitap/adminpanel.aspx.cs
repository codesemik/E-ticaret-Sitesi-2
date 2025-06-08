using MySqlConnector;
using System;
using System.Data;

namespace eticaretkitap
{
    public partial class adminpanel : System.Web.UI.Page
    {
        string connectionString = "Server=localhost;Database=kitapticaret;Uid=root;Pwd=;";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Oturum kontrolü
            //if (Session["username"] == null)
            //{
            //    Response.Redirect("giris.aspx");
            //    return;
            //}

            //if (!IsPostBack)
            //{
            //    litKullaniciAdi.Text = Session["username"].ToString();
            SiparisleriGetir();
            //}
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("giris.aspx");
        }

        private void SiparisleriGetir()
        {
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                string query = @"SELECT s.SiparisID, u.username, s.SiparisTarihi, s.Durum, s.ToplamFiyat
                         FROM siparis s
                         LEFT JOIN users u ON s.userID = u.userID
                         ORDER BY s.SiparisTarihi DESC
                         LIMIT 10";

                MySqlDataAdapter da = new MySqlDataAdapter(query, conn);
                DataTable dt = new DataTable();

                try
                {
                    conn.Open();
                    da.Fill(dt);
                    dlSonSiparisler.DataSource = dt;
                    dlSonSiparisler.DataBind();
                }
                catch (Exception ex)
                {
                    Response.Write("Veri çekilirken hata oluştu: " + ex.Message);
                }
            }
        }

    }
}
