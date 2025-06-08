using System;
using System.Data;
using MySqlConnector;

namespace eticaretkitap
{
    public partial class adminKullanicilar : System.Web.UI.Page
    {
        string connStr = "Server=localhost;Database=kitapticaret;Uid=root;Pwd=;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindKullanicilar();
            }
        }

        private void BindKullanicilar()
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                string sql = "SELECT userID, name, surname, username, mail, yetki FROM users ORDER BY userID ASC";
                MySqlDataAdapter da = new MySqlDataAdapter(sql, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvKullanicilar.DataSource = dt;
                gvKullanicilar.DataBind();
            }
        }
    }
}
