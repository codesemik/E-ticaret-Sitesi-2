<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="urunler.aspx.cs" Inherits="eticaretkitap.urunler" %>

<!DOCTYPE html>
<html lang="tr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Ürünler | KitapDükkanım</title>
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
        <a href="sepet.aspx">Sepete Git</a>


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
    <h2>Ürünlerimiz</h2>

    <!-- Kategoriler RadioButtonList -->
      <center>
          <asp:RadioButtonList 
    ID="rblKategoriler" 
    runat="server" 
    AutoPostBack="true" 
    OnSelectedIndexChanged="rblKategoriler_SelectedIndexChanged" 
    RepeatDirection="Horizontal">
    <asp:ListItem Text="Roman" Value="Roman" />
    <asp:ListItem Text="Hikaye" Value="Hikaye" />
    <asp:ListItem Text="Masal" Value="Masal" />
</asp:RadioButtonList>

      </center>
      <center>
    <asp:DataList ID="dlUrunler" runat="server" RepeatColumns="3" CellPadding="10" GridLines="None" OnItemCommand="dlUrunler_ItemCommand">
      <ItemTemplate>
        <div class="product-card">
          <img src='<%# ResolveUrl("~/images/" + Eval("foto")) %>' alt='<%# Eval("kitapAdi") %>' />
          <h4><%# Eval("kitapAdi") %></h4>
          <p><%# Eval("fiyat", "{0:C0}") %> TL</p>
          <p>Stok: <%# Eval("adet") %></p>
          <asp:TextBox ID="txtAdet" runat="server" Text="1" CssClass="form-control" Width="50px" />
          <asp:Button ID="btnSepeteEkle" runat="server" Text="Sepete Ekle" CommandName="SepeteEkle" CommandArgument='<%# Eval("kitapID") %>' CssClass="submit-button" />
        </div>
      </ItemTemplate>
    </asp:DataList>
  </section>
          </center>
          </form>

  <footer>
    <p>&copy; 2025 KitapDükkanım. Tüm hakları saklıdır.</p>
  </footer>

  <style>
    /* Buraya mevcut CSS'inizi olduğu gibi yapıştırabilirsiniz, size verdiğiniz CSS'i ekledim */
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

    .features {
      padding: 60px 40px;
      text-align: center;
    }

    .product-card {
      background-color: #fff;
      border-radius: 12px;
      padding: 20px;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
      transition: transform 0.3s;
      margin: 10px;
    }

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

    .dropdown {
position: relative;
display: inline-block;
}

      .dropbtn {
  cursor: pointer;
  color: #333;
  text-decoration: none;
  font-weight: 500;
}

.dropdown-content {
  display: none;
  position: absolute;
  background-color: white;
  min-width: 160px;
  box-shadow: 0 8px 16px rgba(0,0,0,0.2);
  z-index: 1;
  right: 0;
  border-radius: 4px;
}

.dropdown-content a {
  padding: 12px 16px;
  display: block;
  color: #333;
  text-decoration: none;
}

.dropdown-content a:hover {
  background-color: #f4e6c1;
}

.dropdown:hover .dropdown-content {
  display: block;
}

footer {
  text-align: center;
  padding: 20px;
  background-color: #eee;
  margin-top: 40px;
  font-size: 14px;
  color: #777;
}
</style> </body> </html>