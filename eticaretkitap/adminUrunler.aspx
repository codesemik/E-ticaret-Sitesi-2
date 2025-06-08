<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="adminUrunler.aspx.cs" Inherits="eticaretkitap.adminUrunler" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8" />
    <title>Admin Paneli - Ürünler | KitapDükkanım</title>
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

        /* Ürün tablosu */
        .product-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
            color: #333;
        }
        .product-table thead tr {
            background-color: #f0e6d2;
        }
        .product-table th, .product-table td {
            padding: 10px 15px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }
        .product-table tbody tr:hover {
            background-color: #f9f5f0;
            cursor: pointer;
        }
        .product-table th {
            font-weight: 600;
            color: #8b4513;
        }
        .product-table td {
            vertical-align: middle;
        }

        /* Ekleme butonu */
        .btn-add-product {
            background-color: #8b4513;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 20px;
            cursor: pointer;
            font-weight: bold;
            margin-bottom: 20px;
            float: right;
            transition: background-color 0.3s ease;
        }
        .btn-add-product:hover {
            background-color: #6a340a;
        }
        /* Form bölümleri */
.form-section {
    background-color: #ffffff;
    padding: 25px;
    margin-top: 40px;
    border-radius: 10px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.08);
}

/* Form başlıkları */
.form-section h2 {
    color: #8b4513;
    margin-bottom: 20px;
}

/* Form grup yapısı */
.form-group {
    margin-bottom: 20px;
}

/* Form etiketleri */
.form-group label {
    display: block;
    font-weight: 600;
    margin-bottom: 6px;
    color: #333;
}

/* Form input alanları */
.form-control {
    width: 100%;
    padding: 10px 12px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 14px;
    transition: border-color 0.3s;
    box-sizing: border-box;
}

.form-control:focus {
    outline: none;
    border-color: #8b4513;
    box-shadow: 0 0 5px rgba(139, 69, 19, 0.3);
}

/* Buton stilleri */
.btn {
    padding: 10px 20px;
    border-radius: 20px;
    font-weight: bold;
    border: none;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

/* Birincil buton (mavi ton) */
.btn-primary {
    background-color: #007bff;
    color: white;
}
.btn-primary:hover {
    background-color: #0056b3;
}

/* İkincil buton (gri ton) */
.btn-secondary {
    background-color: #6c757d;
    color: white;
}
.btn-secondary:hover {
    background-color: #5a6268;
}

/* Sil ve düzenle link butonları */
.btn-edit, .btn-delete {
    color: #007bff;
    text-decoration: none;
    font-weight: bold;
    cursor: pointer;
}
.btn-delete {
    color: #dc3545;
}
.btn-edit:hover {
    text-decoration: underline;
}
.btn-delete:hover {
    text-decoration: underline;
}

    </style>
</head>
<body>
  <form id="form1" runat="server">

<header>
    <h1>Admin Paneli - Ürünler</h1>
</header>

<nav>
    <a href="adminpanel.aspx">Dashboard</a>
    <a href="adminUrunler.aspx" class="active-link">Ürünler</a>
    <a href="adminSiparisler.aspx">Siparişler</a>
    <a href="adminKullanicilar.aspx">Kullanıcılar</a>
    <a href="adminSiteBilgileri.aspx">Site Bilgileri</a>
    <a href="adminSikayet.aspx">Şikayet / Öneri</a>
</nav>

<main>
    <div class="welcome">
        Hoşgeldiniz, <asp:Literal ID="litKullaniciAdi" runat="server"></asp:Literal>!
    </div>

    <div class="section">
        <h3>Ürün Listesi</h3>

<asp:DataList ID="dlUrunler" runat="server"
              Width="100%"
              ItemStyle-CssClass="border-bottom border-gray-200"
              OnItemCommand="dlUrunler_ItemCommand">
            <HeaderTemplate>
                <table class="product-table">
                    <thead>
                        <tr>
                            <th>Ürün ID</th>
                            <th>Ürün Adı</th>
                            <th>Kategori</th>
                            <th>Fiyat (₺)</th>
                            <th>Stok</th>
                            <th>Durum</th>
                        </tr>
                    </thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td><%# Eval("kitapID") %></td>
                    <td><%# Eval("kitapAdi") %></td>
                    <td><%# Eval("kategori") %></td>
                    <td><%# Eval("fiyat") %></td>

                    <td><%# Eval("adet") %></td>
                    <td>
                        <asp:LinkButton ID="lnkSil" runat="server" CommandName="Sil" CommandArgument='<%# Eval("kitapID") %>' CssClass="btn-delete" Text="Sil" OnClientClick="return confirm('Bu ürünü silmek istediğinize emin misiniz?');"></asp:LinkButton>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                    </tbody>
                </table>
            </FooterTemplate>
        </asp:DataList>
    </div>

        <h2>Yeni Ürün Ekle</h2>
    <asp:Literal ID="litMesaj" runat="server" />
    
    <div class="form-group">
        <label for="txtUrunAdi">Ürün Adı</label>
        <asp:TextBox ID="txtUrunAdi" runat="server" CssClass="form-control" />
    </div>

    <div class="form-group">
        <label for="txtFiyat">Fiyat (₺)</label>
        <asp:TextBox ID="txtFiyat" runat="server" CssClass="form-control" />
    </div>

    <div class="form-group">
        <label for="fuResim">Ürün Resmi</label>
        <asp:FileUpload ID="fuResim" runat="server" CssClass="form-control" />
    </div>

    <div class="form-group">
        <label for="ddlKategori">Kategori</label>
        <asp:DropDownList ID="ddlKategori" runat="server" CssClass="form-control" >
            <asp:ListItem>Roman</asp:ListItem>
            <asp:ListItem>Masal</asp:ListItem>
            <asp:ListItem>Hikaye</asp:ListItem>
        </asp:DropDownList>
    </div>


    <div class="form-group">
        <label for="txtAdet">Stok Adedi</label>
        <asp:TextBox ID="txtAdet" runat="server" CssClass="form-control" />
    </div>

    <div class="form-group">
        <asp:Button ID="Button1" runat="server" Text="Ürünü Ekle" OnClick="btnUrunEkle_Click" CssClass="btn btn-primary" />
    </div>
</div>

    <!-- Kitap Detayları Ekleme Formu -->
<div class="form-section mt-8">
    <h2>Kitap Detayı Ekle</h2>
    <asp:Literal ID="litDetayMesaj" runat="server" />

    <div class="form-group">
        <label for="txtKitapAdi">Kitap Adı</label>
        <asp:TextBox ID="txtDetayKitapID" runat="server" CssClass="form-control" />
    </div>

    <div class="form-group">
        <label for="txtKitapAdi">Kitap Adı</label>
        <asp:TextBox ID="txtKitapAdi" runat="server" CssClass="form-control" />
    </div>

    <div class="form-group">
        <label for="txtYazar">Yazar</label>
        <asp:TextBox ID="txtYazar" runat="server" CssClass="form-control" />
    </div>

    <div class="form-group">
        <label for="txtYayinevi">Yayınevi</label>
        <asp:TextBox ID="txtYayinevi" runat="server" CssClass="form-control" />
    </div>

    <div class="form-group">
        <label for="txtISBN">ISBN</label>
        <asp:TextBox ID="txtISBN" runat="server" CssClass="form-control" />
    </div>

    <div class="form-group">
        <label for="txtBasimYili">Basım Yılı</label>
        <asp:TextBox ID="txtBasimYili" runat="server" CssClass="form-control" />
    </div>

    <div class="form-group">
        <label for="txtBaskiSayisi">Baskı Sayısı</label>
        <asp:TextBox ID="txtBaskiSayisi" runat="server" CssClass="form-control" />
    </div>

    <div class="form-group">
        <label for="txtSayfaSayisi">Sayfa Sayısı</label>
        <asp:TextBox ID="txtSayfaSayisi" runat="server" CssClass="form-control" />
    </div>

    <div class="form-group">
        <label for="txtDil">Dil</label>
        <asp:TextBox ID="txtDil" runat="server" CssClass="form-control" />
    </div>

    <div class="form-group">
        <asp:Button ID="btnDetayEkle" runat="server" Text="Detay Ekle" OnClick="btnDetayEkle_Click" CssClass="btn btn-primary" />
    </div>
</div>

<!-- Kitap Detayları Güncelleme Formu -->
<div class="form-section mt-8">
    <h2>Kitap Detayı Güncelle</h2>
    <asp:Literal ID="litDetayGuncelleMesaj" runat="server" />
    <asp:Literal ID="litDetayBulMesaj" runat="server" />

    <div class="form-group">
        <label for="txtGuncelleKitapID">Kitap ID</label>
        <asp:TextBox ID="txtGuncelleKitapID" runat="server" CssClass="form-control" />
    </div>

    <div class="form-group">
        <label for="txtYeniKitapAdi">Yeni Kitap Adı</label>
        <asp:TextBox ID="txtYeniKitapAdi" runat="server" CssClass="form-control" />
    </div>

    <div class="form-group">
        <label for="txtYeniYazar">Yeni Yazar</label>
        <asp:TextBox ID="txtYeniYazar" runat="server" CssClass="form-control" />
    </div>

    <div class="form-group">
        <label for="txtYeniYayinevi">Yeni Yayınevi</label>
        <asp:TextBox ID="txtYeniYayinevi" runat="server" CssClass="form-control" />
    </div>

    <div class="form-group">
        <label for="txtYeniISBN">Yeni ISBN</label>
        <asp:TextBox ID="txtYeniISBN" runat="server" CssClass="form-control" />
    </div>

    <div class="form-group">
        <label for="txtYeniBasimYili">Yeni Basım Yılı</label>
        <asp:TextBox ID="txtYeniBasimYili" runat="server" CssClass="form-control" />
    </div>

    <div class="form-group">
        <label for="txtYeniBaskiSayisi">Yeni Baskı Sayısı</label>
        <asp:TextBox ID="txtYeniBaskiSayisi" runat="server" CssClass="form-control" />
    </div>

    <div class="form-group">
        <label for="txtYeniSayfaSayisi">Yeni Sayfa Sayısı</label>
        <asp:TextBox ID="txtYeniSayfaSayisi" runat="server" CssClass="form-control" />
    </div>

    <div class="form-group">
        <label for="txtYeniDil">Yeni Dil</label>
        <asp:TextBox ID="txtYeniDil" runat="server" CssClass="form-control" />
    </div>

    <div class="form-group">
        <asp:Button ID="btnDetayGuncelle" runat="server" Text="Detayı Güncelle" OnClick="btnDetayGuncelle_Click" CssClass="btn btn-primary" />
        <asp:Button ID="btnDetayBul" runat="server" Text="Detay Bilgilerini Getir" OnClick="btnDetayBul_Click" CssClass="btn btn-secondary" />
    </div>
</div>

</div>
</main>
      </form>
</body>
</html>
