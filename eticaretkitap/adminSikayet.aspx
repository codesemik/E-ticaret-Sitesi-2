<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="adminSikayet.aspx.cs" Inherits="eticaretkitap.adminSikayet" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8" />
    <title>Admin Paneli - Şikayet / Öneri | KitapDükkanım</title>
    <style>
        /* adminpanel.css ile aynı stilde */
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
        button.logout {
            background-color: #c1440e;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 20px;
            cursor: pointer;
            font-weight: bold;
        }
        button.logout:hover {
            background-color: #a22e06;
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
            vertical-align: top;
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
            <h1>Admin Paneli - Şikayet / Öneri</h1>
        </header>

        <nav>
            <a href="adminpanel.aspx">Dashboard</a>
            <a href="adminUrunler.aspx">Ürünler</a>
            <a href="adminSiparisler.aspx">Siparişler</a>
            <a href="adminKullanicilar.aspx">Kullanıcılar</a>
            <a href="adminSiteBilgileri.aspx">Site Bilgileri</a>
            <a href="adminSikayet.aspx" class="active-link">Şikayet / Öneri</a>
        </nav>

        <main>
            <div class="welcome">
                Hoşgeldiniz, <asp:Literal ID="litKullaniciAdi" runat="server" />
            </div>

            <div class="section">
                <h3>Şikayet / Öneri Mesajları</h3>
                <asp:GridView ID="gvSikayetler" runat="server" AutoGenerateColumns="False" CssClass="gridview"
                    DataKeyNames="id">
                    <Columns>
                        <asp:BoundField DataField="id" HeaderText="ID" ReadOnly="True" />
                        <asp:BoundField DataField="ad" HeaderText="Ad" ReadOnly="True" />
                        <asp:BoundField DataField="eposta" HeaderText="E-posta" ReadOnly="True" />
                        <asp:BoundField DataField="mesaj" HeaderText="Mesaj" ReadOnly="True" />
                        <asp:BoundField DataField="tarih" HeaderText="Tarih" DataFormatString="{0:dd.MM.yyyy HH:mm}" ReadOnly="True" />
                    </Columns>
                </asp:GridView>
                <asp:Literal ID="litMesaj" runat="server" />
            </div>
        </main>
    </form>
</body>
</html>
