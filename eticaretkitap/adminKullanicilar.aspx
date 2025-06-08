<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="adminKullanicilar.aspx.cs" Inherits="eticaretkitap.adminKullanicilar" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8" />
    <title>Admin Paneli - Kullanıcılar | KitapDükkanım</title>
    <style>
        /* adminSiparisler.aspx ile aynı CSS kodları burada */
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f5f5f5;
            margin: 0; padding: 0;
        }
        header {
            background-color: #8b4513;
            color: white;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        nav {
            background-color: #fff;
            padding: 15px 40px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            display: flex;
            gap: 20px;
        }
        nav a {
            color: #8b4513;
            text-decoration: none;
            font-weight: 600;
        }
        nav a:hover, nav a.active-link {
            text-decoration: underline;
        }
        main {
            padding: 40px;
        }
        .welcome {
            font-size: 18px;
            margin-bottom: 30px;
        }
        .section {
            background-color: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            margin-bottom: 30px;
        }
        /* GridView stil */
        .gridview {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
            color: #333;
        }
        .gridview th, .gridview td {
            padding: 10px 15px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }
        .gridview thead tr {
            background-color: #f0e6d2;
            color: #8b4513;
            font-weight: 600;
        }
        .gridview tbody tr:hover {
            background-color: #f9f5f0;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <header>
            <h1>Admin Paneli - Kullanıcılar</h1>
        </header>

        <nav>
            <a href="adminpanel.aspx">Dashboard</a>
            <a href="adminUrunler.aspx">Ürünler</a>
            <a href="adminSiparisler.aspx">Siparişler</a>
            <a href="adminKullanicilar.aspx" class="active-link">Kullanıcılar</a>
            <a href="adminSiteBilgileri.aspx">Site Bilgileri</a>
            <a href="adminSikayet.aspx">Şikayet / Öneri</a>
        </nav>

        <main>
            <div class="welcome">
                Hoşgeldiniz, <asp:Literal ID="litKullaniciAdi" runat="server" />
            </div>

            <div class="section">
                <h3>Kullanıcı Listesi</h3>
                <asp:GridView ID="gvKullanicilar" runat="server" AutoGenerateColumns="False" CssClass="gridview" DataKeyNames="userID">
                    <Columns>
                        <asp:BoundField DataField="userID" HeaderText="User ID" ReadOnly="True" />
                        <asp:BoundField DataField="name" HeaderText="İsim" ReadOnly="True" />
                        <asp:BoundField DataField="surname" HeaderText="Soyisim" ReadOnly="True" />
                        <asp:BoundField DataField="username" HeaderText="Kullanıcı Adı" ReadOnly="True" />
                        <asp:BoundField DataField="mail" HeaderText="E-posta" ReadOnly="True" />
                        <asp:BoundField DataField="yetki" HeaderText="Yetki" ReadOnly="True" />
                    </Columns>
                </asp:GridView>
            </div>
        </main>
    </form>
</body>
</html>
