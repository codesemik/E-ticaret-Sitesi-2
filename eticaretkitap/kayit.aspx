<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="kayit.aspx.cs" Inherits="eticaretkitap.kayit" %>

<!DOCTYPE html>
<html lang="tr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Kayıt Ol | KitapDükkanım</title>

  <style>
    .form-control {
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 8px;
      font-size: 14px;
      width: 100%;
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
</head>
<body>
      <form id="form1" runat="server">

  <!-- Navbar -->
  <header>
  <h1>KitapDükkanım</h1>
  <nav>
    <a href="anasayfa.aspx">Anasayfa</a>
    <a href="urunler.aspx">Tüm Kitaplar</a>
    <a href="hakkimizda.aspx">Hakkımızda</a>
    <a href="iletisim.aspx">İletişim</a>

    <div class="dropdown">
      <a href="#" class="dropbtn">Hesabım ▾</a>
      <div class="dropdown-content">
        <a href="giris.aspx">Giriş Yap</a>
        <a href="kayit.aspx">Kayıt Ol</a>
      </div>
    </div>
  </nav>
</header>

  <!-- Kayıt Formu -->
  <section class="features" style="max-width: 400px; margin: 50px auto;">
      <h2>Kayıt Ol</h2>

      <asp:Label ID="lblMessage" runat="server" ForeColor="Red" />

      <asp:Panel ID="pnlKayit" runat="server">

        <asp:TextBox ID="txtKullaniciAdi" CssClass="form-control" Placeholder="Kullanıcı Adı" runat="server" />
        <br /><br />

         <asp:TextBox ID="txtIsim" CssClass="form-control" Placeholder="İsim" runat="server" />
        <br /><br />

        <asp:TextBox ID="txtSoyisim" CssClass="form-control" Placeholder="Soyisim" runat="server" />
        <br /><br />


        <asp:TextBox ID="txtEmail" CssClass="form-control" Placeholder="E-posta" runat="server" TextMode="Email" />
        <br /><br />

        <asp:TextBox ID="txtSifre" TextMode="Password" CssClass="form-control" Placeholder="Şifre" runat="server" />
        <br /><br />

        <asp:TextBox ID="txtSifreTekrar" TextMode="Password" CssClass="form-control" Placeholder="Şifre Tekrar" runat="server" />
        <br /><br />

        <asp:Button ID="btnKayit" runat="server" Text="Kayıt Ol" CssClass="submit-button" OnClick="btnKayit_Click" />

      </asp:Panel>
    </section>

  <!-- Footer -->
  <footer>
    <p>&copy; 2025 KitapDükkanım. Tüm hakları saklıdır.</p>
  </footer>

            </form>

</body>
</html>
