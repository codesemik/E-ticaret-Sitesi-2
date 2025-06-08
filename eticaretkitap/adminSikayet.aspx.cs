using System;
using System.Data;
using MySqlConnector;

namespace eticaretkitap
{
    public partial class adminSikayet : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                VerileriGetir();
            }
        }

        private void VerileriGetir()
        {
            string connStr = "Server=localhost;Database=kitapticaret;Uid=root;Pwd=;";

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                string sql = "SELECT id, ad, eposta, mesaj, tarih FROM iletisimmesajlari ORDER BY tarih DESC";
                using (MySqlCommand cmd = new MySqlCommand(sql, conn))
                {
                    conn.Open();
                    DataTable dt = new DataTable();
                    using (MySqlDataAdapter da = new MySqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                    gvSikayetler.DataSource = dt;
                    gvSikayetler.DataBind();
                }
            }
        }
    }
}
