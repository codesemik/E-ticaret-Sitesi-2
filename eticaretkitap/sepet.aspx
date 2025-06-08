<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="sepet.aspx.cs" Inherits="eticaretkitap.sepet" %>

<!DOCTYPE html>
<html lang="tr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Sepetim | KitapDükkanım</title>
  <link rel="stylesheet" href="style.css" />
</head>
<body>
  <form id="form1" runat="server">
    <header>
      <h1>KitapDükkanım</h1>
      <nav>
        <a href="anasayfa.aspx">Anasayfa</a>
        <a href="urunler.aspx">Tüm Kitaplar</a>
        <a href="hakkimizda.aspx">Hakkımızda</a>
        <a href="iletisim.aspx">İletişim</a>

        <div class="dropdown">
  <button type="button" class="dropbtn" onclick="toggleDropdown()">
      👤
      <% if (Session["username"] != null) { %>
          <%= Session["username"].ToString() %>
      <% } else { %>
          Hesabım
      <% } %>
  </button>
  <div id="dropdownContent" class="dropdown-content">
      <% if (Session["username"] == null) { %>
          <a href="giris.aspx">Üye Giriş</a>
          <a href="kayit.aspx">Üye Ol</a>
      <% } else { %>
          <a href="kullaniciSiparisler.aspx">Profilim</a>
          <a href="cikis.aspx">Çıkış</a>
      <% } %>
  </div>
</div>
      </nav>
    </header>

    <section class="features">
      <h2>Sepetim</h2>
      
      <center>
<asp:GridView ID="SepetGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="UrunID" OnRowDeleting="SepetGridView_RowDeleting" CssClass="sepet-grid" OnRowCommand="SepetGridView_RowCommand">
    <Columns>
        <asp:TemplateField HeaderText="Ürün Resmi">
            <ItemTemplate>
                <asp:Image ID="imgUrun" runat="server"
                    ImageUrl='<%# VirtualPathUtility.ToAbsolute("~/images/" + Eval("ResimUrl")) %>'
                    CssClass="urun-resmi"
                    Height="80" Width="80"
                    AlternateText='<%# Eval("UrunAdi") %>' />
            </ItemTemplate>
            <ItemStyle CssClass="urun-resmi" />
        </asp:TemplateField>
        <asp:BoundField DataField="UrunAdi" HeaderText="Ürün Adı" />
        <asp:TemplateField HeaderText="Adet">
            <ItemTemplate>
                <asp:Button ID="btnAzalt" runat="server" Text="-" CommandName="Azalt" CommandArgument='<%# Container.DataItemIndex %>' CssClass="sil-butonu" />
                <asp:Label ID="lblAdet" runat="server" Text='<%# Eval("Adet") %>' CssClass="product-adet"></asp:Label>
                <asp:Button ID="btnArttir" runat="server" Text="+" CommandName="Arttir" CommandArgument='<%# Container.DataItemIndex %>' CssClass="satinal-butonu" />
            </ItemTemplate>
            <ItemStyle HorizontalAlign="Center" />
        </asp:TemplateField>
        <asp:BoundField DataField="Fiyat" HeaderText="Birim Fiyat" DataFormatString="{0:C}" />
        <asp:TemplateField>
            <ItemTemplate>
                <asp:Button ID="btnSil" runat="server" Text="Sil" CommandName="Delete" CssClass="sil-butonu" />
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
<br />
<br />
<br />
</center>

      <asp:Label ID="lblGenelToplam" runat="server" Text="" Font-Bold="true" Font-Size="Large" Style="margin-top:20px; display:block; color:#8b4513;"></asp:Label>

      <asp:Button ID="btnAlisverisiTamamla" runat="server" Text="Alışverişi Tamamla" CssClass="submit-button" Style="margin-top:30px;" OnClick="BtnSatınAl_Click" />
    </section>
  </form>

  <footer>
    <p>&copy; 2025 KitapDükkanım. Tüm hakları saklıdır.</p>
  </footer>

    <style>
    .form-control {
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 8px;
      font-size: 14px;
    }

    .submit-button {
      background-color: #8b4513;
      color: white;
      border: none;
      padding: 10px 20px;
      border-radius: 25px;
      cursor: pointer;
    }

    .submit-button:hover {
      background-color: #6e3510;
    }

    body {
  font-family: 'Segoe UI', sans-serif;
  background-color: #fdfcf9;
  color: #333;
}

header {
  background-color: #ffffff;
  padding: 20px 40px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
}

header h1 {
  color: #8b4513;
  font-size: 28px;
}

nav a {
  margin-left: 20px;
  color: #333;
  text-decoration: none;
  font-weight: 500;
}

nav a:hover {
  color: #8b4513;
}

.hero {
  background-color: #8b4513;
  color: #fff;
  text-align: center;
  padding: 80px 20px;
}

.hero a {
  background-color: #fff;
  color: #8b4513;
  padding: 12px 30px;
  border-radius: 30px;
  text-decoration: none;
  font-weight: bold;
}

.categories,
.products,
.features {
  padding: 60px 40px;
  text-align: center;
}

.category-grid,
.product-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
  gap: 20px;
  margin-top: 30px;
}

.category,
.product-card {
  background-color: #fff;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  transition: transform 0.3s;
}

.category:hover,
.product-card:hover {
  transform: translateY(-5px);
}

.product-card img {
  width: 100%;
  max-height: 250px;
  object-fit: cover;
  border-radius: 10px;
}

.product-card h4 {
  margin-top: 10px;
  font-size: 16px;
}

.product-card p {
  color: #8b4513;
  font-weight: bold;
  margin-top: 5px;
}

.product-card button {
  margin-top: 10px;
  background-color: #8b4513;
  color: #fff;
  border: none;
  padding: 10px 20px;
  border-radius: 25px;
  cursor: pointer;
}

.features .feature-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 30px;
  justify-content: center;
  margin-top: 30px;
}

footer {
  background-color: #fff;
  text-align: center;
  padding: 20px;
  color: #888;
  font-size: 14px;
}

/* Dropdown menü stili */
.dropdown {
  position: relative;
  display: inline-block;
}

.dropbtn {
  color: #8b4513;
  font-weight: bold;
  padding: 8px 16px;
  cursor: pointer;
  text-decoration: none;
}

.dropdown-content {
  display: none;
  position: absolute;
  right: 0;
  background-color: #fff;
  min-width: 150px;
  box-shadow: 0 8px 16px rgba(0,0,0,0.1);
  border-radius: 8px;
  z-index: 1;
}

.dropdown-content a {
  color: #333;
  padding: 10px 16px;
  text-decoration: none;
  display: block;
}

.dropdown-content a:hover {
  background-color: #f3f3f3;
}

.dropdown:hover .dropdown-content {
  display: block;
}
  </style>
</body>
</html>
