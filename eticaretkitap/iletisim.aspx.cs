using MySqlConnector;
using System;

namespace eticaretkitap
{
    public partial class iletisim : System.Web.UI.Page
    {
        string connStr = "Server=localhost;Port=3306;Database=kitapticaret;Uid=root;";

        protected void Page_Load(object sender, EventArgs e)
        {
            string script = (Session["name"] != null)
                ? "var kullaniciGirisYapmis = true;"
                : "var kullaniciGirisYapmis = false;";
            ClientScript.RegisterStartupScript(this.GetType(), "KullaniciGirisDurumu", script, true);

            if (!IsPostBack)
            {
            }
        }

        protected void btnGonder_Click(object sender, EventArgs e)
        {
            string ad = txtAd.Text.Trim();
            string eposta = txtEmail.Text.Trim();
            string mesaj = txtMesaj.Text.Trim();

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                string query = "INSERT INTO iletisimmesajlari (ad, eposta, mesaj) VALUES (@ad, @eposta, @mesaj)";
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@ad", ad);
                    cmd.Parameters.AddWithValue("@eposta", eposta);
                    cmd.Parameters.AddWithValue("@mesaj", mesaj);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }

            // Temizle ve kullanıcıyı bilgilendir
            txtAd.Text = "";
            txtEmail.Text = "";
            txtMesaj.Text = "";

            ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('Mesajınız başarıyla gönderildi.');", true);
        }
    }
}
