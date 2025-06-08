<!DOCTYPE html>
<html lang="tr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>KitapDükkanım | Anasayfa</title>
  <link rel="stylesheet" href="style.css" />
    <style>
        /* Aynı CSS, kitap temasına uygun renklendirme içeriyor */
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
</head>
<body>

      <!-- Navbar -->
              <header>
      <h1>KitapDükkanım</h1>
      <nav>
        <a href="anasayfa.aspx">Anasayfa</a>
        <a href="urunler.aspx">Tüm Kitaplar</a>
        <a href="hakkimizda.aspx">Hakkımızda</a>
        <a href="iletisim.aspx">İletişim</a>

        <button type="button" class="dropbtn" onclick="toggleDropdown()">
    👤
    <% If Session("username") IsNot Nothing Then %>
        <%= Session("username").ToString() %>
    <% Else %>
        Hesabım
    <% End If %>
</button>

<div id="dropdownContent" class="dropdown-content">
    <% If Session("username") Is Nothing Then %>
        <a href="giris.aspx">Üye Giriş</a>
        <a href="kayit.aspx">Üye Ol</a>
    <% Else %>
        <a href="kullaniciSiparisler.aspx">Profilim</a>
        <a href="cikis.aspx">Çıkış</a>
    <% End If %>
</div>

    </nav>
  </header>



  <!-- Hero -->
  <section class="hero">
    <h2>Yeni Çıkan Romanlarla Hayal Gücünü Keşfet!</h2>
    <p>En sevilen yazarların en yeni kitapları burada seni bekliyor.</p>
    <a href="#">Hemen İncele</a>
  </section>

  <!-- Kategoriler -->
  <section class="categories">
    <h3>Kategoriler</h3>
    <div class="category-grid">
      <div class="category">
        <img src="https://via.placeholder.com/80" alt="Roman" />
        <h4>Roman</h4>
      </div>
      <div class="category">
        <img src="https://via.placeholder.com/80" alt="Eğitim" />
        <h4>Eğitim</h4>
      </div>
      <div class="category">
        <img src="https://via.placeholder.com/80" alt="Çocuk" />
        <h4>Çocuk Kitapları</h4>
      </div>
      <div class="category">
        <img src="https://via.placeholder.com/80" alt="Bilim" />
        <h4>Bilim & Teknoloji</h4>
      </div>
    </div>
  </section>

  <!-- Avantajlar -->
  <section class="features">
    <h3>Neden KitapDükkanım?</h3>
    <div class="feature-grid">
      <div class="feature">
        <h4>Ücretsiz Kargo</h4>
        <p>150₺ üzeri alışverişlerde ücretsiz gönderim</p>
      </div>
      <div class="feature">
        <h4>Geniş Kategori</h4>
        <p>10.000+ kitap, 50+ kategori</p>
      </div>
      <div class="feature">
        <h4>Güvenli Ödeme</h4>
        <p>3D Secure ile korunan ödeme altyapısı</p>
      </div>
    </div>
  </section>

  <!-- Footer -->
  <footer>
    <p>&copy; 2025 KitapDükkanım. Tüm hakları saklıdır.</p>
  </footer>

</body>
</html>
