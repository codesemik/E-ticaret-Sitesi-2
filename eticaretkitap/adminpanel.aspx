<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="adminpanel.aspx.cs" Inherits="eticaretkitap.adminpanel" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8" />
    <title>Admin Paneli | KitapDükkanım</title>
    <style>
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
        nav a:hover {
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
        .order-table {
    width: 100%;
    border-collapse: collapse;
    font-size: 14px;
    color: #333;
}

.order-table thead tr {
    background-color: #f0e6d2;
}

.order-table th, .order-table td {
    padding: 10px 15px;
    border-bottom: 1px solid #ddd;
    text-align: left;
}

.order-table tbody tr:hover {
    background-color: #f9f5f0;
    cursor: pointer;
}

.order-table th {
    font-weight: 600;
    color: #8b4513;
}

.order-table td {
    vertical-align: middle;
}

    </style>
</head>
<body>

<header>
    <h1>Admin Paneli</h1>
    <form id="logoutForm" runat="server" method="post">
        <asp:Button ID="btnLogout" runat="server" CssClass="logout" Text="Çıkış Yap" />
    </form>
</header>

<nav>
        <a href="adminpanel.aspx" class="active-link">Dashboard</a>
        <a href="adminUrunler.aspx">Ürünler</a>
        <a href="adminSiparisler.aspx" >Siparişler</a>
        <a href="adminKullanicilar.aspx">Kullanıcılar</a>
        <a href="adminSiteBilgileri.aspx">Site Bilgileri</a>
        <a href="adminSikayet.aspx">Şikayet / Öneri</a>
</nav>

<main>
    <div class="welcome">
        Hoşgeldiniz, <asp:Literal ID="litKullaniciAdi" runat="server"></asp:Literal>!
    </div>

    <div class="recent-orders">
    <h3>Son Siparişler</h3>
    <div class="bg-white rounded-md shadow-md p-4">
        <asp:DataList ID="dlSonSiparisler" runat="server" Width="100%" ItemStyle-CssClass="border-bottom border-gray-200">
            <HeaderTemplate>
                <table class="order-table">
                    <thead class="bg-gray-100">
                        <tr>
                            <th class="text-left py-2">Sipariş ID</th>
                            <th class="text-left py-2">Müşteri</th>
                            <th class="text-left py-2">Tarih</th>
                            <th class="text-left py-2">Durum</th>
                            <th class="text-left py-2">Toplam</th>
                        </tr>
                    </thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td class="py-2"><%# Eval("SiparisID") %></td>
                    <td class="py-2"><%# Eval("username") %></td>
                    <td class="py-2"><%# Eval("SiparisTarihi") %></td>
                    <td class="py-2"><%# Eval("Durum") %></td>
                    <td class="py-2">₺<%# Eval("ToplamFiyat") %></td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                    </tbody>
                </table>
            </FooterTemplate>
        </asp:DataList>
    </div>
</main>

</body>
</html>
