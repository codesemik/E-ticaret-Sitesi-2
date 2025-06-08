using MySqlConnector;
using System;

namespace eticaretkitap
{
    public partial class kayit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMessage.Text = "";
            }
        }

        protected void btnKayit_Click(object sender, EventArgs e)
        {
            string kullaniciAdi = txtKullaniciAdi.Text.Trim();
            string email = txtEmail.Text.Trim();
            string sifre = txtSifre.Text.Trim();
            string sifreTekrar = txtSifreTekrar.Text.Trim();
            string isim = txtIsim.Text.Trim();
            string soyisim = txtSoyisim.Text.Trim();


            if (string.IsNullOrEmpty(kullaniciAdi) || string.IsNullOrEmpty(email) ||
                string.IsNullOrEmpty(sifre) || string.IsNullOrEmpty(sifreTekrar) ||
                string.IsNullOrEmpty(isim) || string.IsNullOrEmpty(soyisim))
            {
                lblMessage.Text = "Lütfen tüm alanları doldurun!";
                return;
            }


            if (sifre != sifreTekrar)
            {
                lblMessage.Text = "Şifreler uyuşmuyor!";
                return;
            }

            string connectionString = "Server=localhost;Port=3306;Database=kitapticaret;Uid=root;";

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    string kontrolQuery = "SELECT COUNT(*) FROM users WHERE mail = @Email OR username = @Username";
                    using (MySqlCommand cmdKontrol = new MySqlCommand(kontrolQuery, conn))
                    {
                        cmdKontrol.Parameters.AddWithValue("@Email", email);
                        cmdKontrol.Parameters.AddWithValue("@Username", kullaniciAdi);

                        long count = (long)cmdKontrol.ExecuteScalar();
                        if (count > 0)
                        {
                            lblMessage.Text = "Bu kullanıcı adı veya e-posta zaten kayıtlı!";
                            return;
                        }
                    }

                    string insertQuery = "INSERT INTO users (username, mail, password, name, surname, yetki) VALUES (@Username, @Email, @Password, @Isim, @Soyisim, 'user')";
                    using (MySqlCommand cmd = new MySqlCommand(insertQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@Username", kullaniciAdi);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Password", sifre);
                        cmd.Parameters.AddWithValue("@Isim", isim);
                        cmd.Parameters.AddWithValue("@Soyisim", soyisim);

                        cmd.ExecuteNonQuery();
                        Response.Redirect("giris.aspx");
                    }

                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Hata oluştu: " + ex.Message;
                }
            }
        }
    }
}
