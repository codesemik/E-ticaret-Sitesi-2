using System;
using System.Data;
using System.Configuration;
using System.Web.UI.WebControls;
using MySqlConnector;

namespace eticaretkitap
{
    public partial class adminSiparisler : System.Web.UI.Page
    {
        string connStr = "Server=localhost;Database=kitapticaret;Uid=root;Pwd=;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindSiparisler();
            }
        }

        private void BindSiparisler()
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                // Kullanıcı adını da göstermek isterseniz userID ile join yapabilirsiniz.
                string sql = @"
                    SELECT 
                        s.SiparisID, 
                        s.userID, 
                        s.SiparisTarihi, 
                        s.ToplamFiyat, 
                        s.Durum
                    FROM siparis s
                    ORDER BY s.SiparisTarihi DESC";

                MySqlDataAdapter da = new MySqlDataAdapter(sql, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvSiparisler.DataSource = dt;
                gvSiparisler.DataBind();
            }
        }

        protected void gvSiparisler_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvSiparisler.EditIndex = e.NewEditIndex;
            BindSiparisler();
        }

        protected void gvSiparisler_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvSiparisler.EditIndex = -1;
            BindSiparisler();
        }

        protected void gvSiparisler_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int siparisID = Convert.ToInt32(gvSiparisler.DataKeys[e.RowIndex].Value);
            DropDownList ddlDurum = (DropDownList)gvSiparisler.Rows[e.RowIndex].FindControl("ddlDurum");

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                string sql = "UPDATE siparis SET Durum = @durum WHERE SiparisID = @siparisID";
                MySqlCommand cmd = new MySqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@durum", ddlDurum.SelectedValue);
                cmd.Parameters.AddWithValue("@siparisID", siparisID);
                conn.Open();
                int rows = cmd.ExecuteNonQuery();
                conn.Close();

                if (rows > 0)
                {
                    litMesaj.Text = "<span style='color:green;'>Sipariş durumu güncellendi.</span>";
                }
                else
                {
                    litMesaj.Text = "<span style='color:red;'>Güncelleme başarısız oldu.</span>";
                }
            }
            gvSiparisler.EditIndex = -1;
            BindSiparisler();
        }
    }
}
