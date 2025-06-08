<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="adminSiparisler.aspx.cs" Inherits="eticaretkitap.adminSiparisler" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8" />
    <title>Admin Paneli - Siparişler | KitapDükkanım</title>
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

        /* Güncelle butonu */
        .btn-update {
            background-color: #8b4513;
            color: white;
            border: none;
            padding: 6px 14px;
            border-radius: 20px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }
        .btn-update:hover {
            background-color: #6a340a;
        }

        /* Dropdown (Sipariş Durumu) */
        .ddl-status {
            padding: 6px 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 14px;
            width: 140px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <header>
            <h1>Admin Paneli - Siparişler</h1>
        </header>

        <nav>
            <a href="adminpanel.aspx">Dashboard</a>
            <a href="adminUrunler.aspx">Ürünler</a>
            <a href="adminSiparisler.aspx" class="active-link">Siparişler</a>
            <a href="adminKullanicilar.aspx">Kullanıcılar</a>
            <a href="adminSiteBilgileri.aspx">Site Bilgileri</a>
            <a href="adminSikayet.aspx">Şikayet / Öneri</a>
        </nav>

        <main>
            <div class="welcome">
                Hoşgeldiniz, <asp:Literal ID="litKullaniciAdi" runat="server" />
            </div>

            <div class="section">
                <h3>Sipariş Listesi</h3>
                <asp:GridView ID="gvSiparisler" runat="server" AutoGenerateColumns="False" CssClass="gridview"
                    OnRowEditing="gvSiparisler_RowEditing"
                    OnRowUpdating="gvSiparisler_RowUpdating"
                    OnRowCancelingEdit="gvSiparisler_RowCancelingEdit"
                    DataKeyNames="siparisID">
                    <Columns>
                        <asp:BoundField DataField="SiparisID" HeaderText="Sipariş ID" ReadOnly="True" />
                        <asp:BoundField DataField="userID" HeaderText="Kullanıcı" ReadOnly="True" />
                        <asp:BoundField DataField="SiparisTarihi" HeaderText="Sipariş Tarihi" DataFormatString="{0:dd.MM.yyyy}" ReadOnly="True" />
                        <asp:BoundField DataField="toplamFiyat" HeaderText="Toplam Tutar (₺)" DataFormatString="{0:N2}" ReadOnly="True" />
                        <asp:TemplateField HeaderText="Sipariş Durumu">
                            <ItemTemplate>
                                <asp:Label ID="lblDurum" runat="server" Text='<%# Eval("Durum") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlDurum" runat="server" CssClass="ddl-status">
                                    <asp:ListItem Text="Bekleniyor" Value="Bekleniyor" />
                                    <asp:ListItem Text="Kargoya Verildi" Value="Kargoya Verildi" />
                                    <asp:ListItem Text="Teslim Edildi" Value="Teslim Edildi" />
                                    <asp:ListItem Text="İptal Edildi" Value="İptal Edildi" />
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ShowEditButton="True" ButtonType="Button" EditText="Düzenle" UpdateText="Güncelle" CancelText="İptal" />
                    </Columns>
                </asp:GridView>
                <asp:Literal ID="litMesaj" runat="server" />
            </div>
        </main>
    </form>
</body>
</html>
