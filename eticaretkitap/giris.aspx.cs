using System;
using System.Web.UI;
using MySqlConnector;

namespace eticaretkitap
{
    public partial class giris : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMessage.Text = "";
            }
        }

        protected void btnGiris_Click(object sender, EventArgs e)
        {
            string kullaniciAdi = txtKullaniciAdi.Text.Trim();
            string sifre = txtSifre.Text.Trim();

            if (string.IsNullOrEmpty(kullaniciAdi) || string.IsNullOrEmpty(sifre))
            {
                lblMessage.Text = "Lütfen kullanıcı adı ve şifreyi giriniz.";
                return;
            }

            string connectionString = "Server=localhost;Port=3306;Database=kitapticaret;Uid=root;";

            try
            {
                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    // Kullanıcı adı veya e-posta ile giriş yapılabilmesi için sorgu düzenlenebilir.
                    // Şimdilik sadece username ile kontrol.
                    string sorguquery = "SELECT * FROM users WHERE username = @username AND password = @sifre";

                    using (MySqlCommand cmd = new MySqlCommand(sorguquery, conn))
                    {
                        cmd.Parameters.AddWithValue("@username", kullaniciAdi);
                        cmd.Parameters.AddWithValue("@sifre", sifre);

                        using (MySqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                // Kullanıcı bilgilerini Session'da tut
                                Session["userID"] = reader["userID"].ToString();
                                Session["name"] = reader["name"].ToString();
                                Session["username"] = kullaniciAdi;
                                Session["surname"] = reader["surname"].ToString();
                                Session["mail"] = reader["mail"].ToString();
                                Session["yetki"] = reader["yetki"].ToString();

                                Response.Redirect("anasayfa.aspx");
                            }
                            else
                            {
                                lblMessage.Text = "Kullanıcı adı veya şifre hatalı!";
                            }
                        }
                    }
                }
            }
            catch (MySqlException ex)
            {
                lblMessage.Text = "Veritabanı hatası: " + ex.Message;
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Beklenmeyen hata: " + ex.Message;
            }
        }
    }
}
