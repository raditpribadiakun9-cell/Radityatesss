<!DOCTYPE html>
<html lang="id">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Radith Store - Galaxy Edition</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Orbitron:wght@500&display=swap');

body {
  font-family: 'Orbitron', sans-serif;
  margin: 0;
  background: radial-gradient(circle at bottom, #06061a, #000);
  color: #fff;
  overflow-x: hidden;
}

/* Latar belakang bintang */
#stars, #stars2, #stars3 {
  position: fixed;
  width: 100%;
  height: 100%;
  background: transparent url('https://www.script-tutorials.com/demos/360/images/stars.png') repeat top center;
  z-index: 0;
}
#stars { animation: animStar 200s linear infinite; }
#stars2 { animation: animStar 400s linear infinite; opacity: 0.5; }
#stars3 { animation: animStar 600s linear infinite; opacity: 0.3; }
@keyframes animStar {
  from { background-position: 0 0; }
  to { background-position: 0 10000px; }
}

/* Header */
header {
  text-align: center;
  padding: 40px 0 20px;
  font-size: 2.8rem;
  color: #0ff;
  text-shadow: 0 0 10px #0ff, 0 0 30px #9b00ff;
}

/* Filter */
#filter-container {
  text-align: center;
  margin-bottom: 25px;
  position: relative;
  z-index: 10;
}
#filter-container button {
  background: linear-gradient(45deg, #00eaff, #9b00ff);
  border: none;
  color: #fff;
  padding: 10px 20px;
  border-radius: 8px;
  margin: 0 5px;
  cursor: pointer;
  transition: 0.3s;
  font-weight: bold;
}
#filter-container button:hover {
  transform: scale(1.1);
  box-shadow: 0 0 20px #00eaff;
}

/* Produk */
.container { max-width: 1200px; margin: 0 auto; padding: 20px; position: relative; z-index: 10; }
.products {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(230px, 1fr));
  gap: 25px;
}
.product {
  background: rgba(15, 15, 40, 0.85);
  border: 1px solid #0ff;
  border-radius: 15px;
  padding: 15px;
  text-align: center;
  box-shadow: 0 0 20px rgba(0,255,255,0.3);
  transition: 0.4s ease;
  position: relative;
  animation: floaty 6s ease-in-out infinite;
}
@keyframes floaty {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-8px); }
}
.product:hover {
  transform: scale(1.05);
  box-shadow: 0 0 30px #00eaff, 0 0 40px #9b00ff;
}
.product h3 { color: #0ff; margin: 10px 0; font-size: 1.1rem; }
.product p { margin-bottom: 10px; }
.product button {
  padding: 10px 20px;
  background: linear-gradient(45deg, #00eaff, #9b00ff);
  border: none;
  border-radius: 8px;
  color: #fff;
  cursor: pointer;
  font-weight: bold;
  transition: all 0.3s;
}
.product button:hover {
  transform: scale(1.05);
  box-shadow: 0 0 20px #9b00ff;
}

/* Keranjang */
#cart-toggle {
  position: fixed;
  top: 25px;
  right: 25px;
  width: 75px;
  height: 75px;
  border-radius: 50%;
  background: radial-gradient(circle at 30% 30%, #00eaff, #6b00ff);
  border: none;
  box-shadow: 0 0 30px #00eaff, inset 0 0 15px #9b00ff;
  cursor: pointer;
  z-index: 20;
  transition: 0.3s;
}
#cart-toggle:hover {
  transform: scale(1.2) rotate(10deg);
  box-shadow: 0 0 50px #9b00ff;
}
#cart-toggle img { width: 45px; height: 45px; }

#cart {
  position: fixed;
  top: 100px;
  right: -380px;
  width: 300px;
  background: rgba(10,10,25,0.95);
  border: 1px solid #8ef;
  border-radius: 12px;
  padding: 15px;
  transition: right 0.4s;
  box-shadow: 0 0 20px #00eaff;
  z-index: 20;
}
#cart.active { right: 20px; }
#cart h2 { text-align: center; color: #8ef; }
#cart-items { max-height: 200px; overflow-y: auto; list-style: none; padding: 0; margin: 10px 0; }
#checkout-btn { width: 100%; margin-top: 10px; }

#payment-popup {
  display: none;
  background: rgba(0,0,0,0.9);
  border: 1px solid #8ef;
  padding: 15px;
  border-radius: 10px;
  text-align: center;
}
#qris-container img {
  width: 200px;
  border-radius: 10px;
  box-shadow: 0 0 20px #8ef;
  margin-top: 10px;
}

/* Notifikasi */
#add-message {
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background: linear-gradient(45deg, #00eaff, #9b00ff);
  color: #fff;
  padding: 15px 25px;
  border-radius: 10px;
  box-shadow: 0 0 30px #00eaff;
  display: none;
  z-index: 999;
  animation: fadeMessage 2s ease-in-out;
}
@keyframes fadeMessage {
  0% { opacity: 0; transform: translate(-50%, -60%); }
  20% { opacity: 1; transform: translate(-50%, -50%); }
  80% { opacity: 1; }
  100% { opacity: 0; transform: translate(-50%, -40%); }
}

@media (max-width: 600px) {
  .products { grid-template-columns: repeat(2, 1fr); }
}
</style>
</head>
<body>

<div id="stars"></div>
<div id="stars2"></div>
<div id="stars3"></div>

<header>🌌 RADITH STORE 🌌</header>

<div id="filter-container">
  <button onclick="filterProducts('all')">Semua</button>
  <button onclick="filterProducts('Panel')">Panel</button>
  <button onclick="filterProducts('SC')">SC</button>
  <button onclick="filterProducts('APK')">APK</button>
</div>

<div class="container">
  <div class="products" id="products"></div>
</div>

<button id="cart-toggle">
  <img src="https://cdn-icons-png.flaticon.com/512/891/891462.png" alt="cart">
</button>

<div id="cart">
  <h2>Keranjang</h2>
  <ul id="cart-items"></ul>
  <p>Total: Rp <span id="total">0</span></p>
  <button id="checkout-btn">Bayar</button>

  <div id="payment-popup">
    <h3 style="color:#8ef;">Metode Pembayaran</h3>
    <p>1️⃣ DANA: <b>089603266259</b></p>
    <button onclick="showQRIS()">Bayar via QRIS</button>
    <div id="qris-container" style="display:none;">
      <img src="https://i.ibb.co/v4tG4tgG/qris.jpg" alt="QRIS">
      <p>Scan untuk membayar</p>
    </div>
    <button onclick="confirmPayment()">Selesai Transfer</button>
    <button onclick="closePayment()" style="background:#f00; color:#fff;">Tutup</button>
  </div>
</div>

<div id="add-message">✨ Produk masuk ke keranjang! 🛒</div>

<script>
let productsData = [
  {name:'💾 PANEL PTERODACTYL 1 GB', price:1000, category:'Panel'},
  {name:'💾 PANEL PTERODACTYL 2 GB', price:2500, category:'Panel'},
  {name:'💾 PANEL PTERODACTYL 4 GB', price:3500, category:'Panel'},
  {name:'💾 PANEL PTERODACTYL 5 GB', price:4000, category:'Panel'},
  {name:'💾 PANEL PTERODACTYL 8 GB', price:5500, category:'Panel'},
  {name:'💾 PANEL PTERODACTYL UNLIMITED', price:7000, category:'Panel'},
  {name:'🤖 SC BOT PUSH KONTAK', price:2000, category:'SC'},
  {name:'🤖 SC BOT ALL MENU', price:3500, category:'SC'},
  {name:'📱 APK BIOSKOP PREMIUM', price:5000, category:'APK'},
  {name:'📱 APK PIXELAB RED', price:2500, category:'APK'}
];

let cartItemsArr = [], totalPrice = 0;

function renderProducts(data){
  const container = document.getElementById('products');
  container.innerHTML = '';
  data.forEach((p,i)=>{
    const div=document.createElement('div');
    div.className='product';
    div.innerHTML=`<h3>${p.name}</h3><p>Rp ${p.price.toLocaleString()}</p>
    <button onclick="addToCart(event,${i})">Tambah</button>`;
    container.appendChild(div);
  });
}
renderProducts(productsData);

function filterProducts(cat){
  if(cat==='all') renderProducts(productsData);
  else renderProducts(productsData.filter(p=>p.category===cat));
}

document.getElementById('cart-toggle').onclick=()=>{
  document.getElementById('cart').classList.toggle('active');
};
document.getElementById('checkout-btn').onclick=()=>{
  document.getElementById('payment-popup').style.display='block';
};
function closePayment(){ document.getElementById('payment-popup').style.display='none'; }
function showQRIS(){ document.getElementById('qris-container').style.display='block'; }

function confirmPayment(){
  if(cartItemsArr.length===0){ alert('Keranjang kosong!'); return; }
  let produk=cartItemsArr.map(p=>p.name).join(', ');
  let wa='6289603266259';
  let msg=encodeURIComponent(`Hai Admin, ini bukti transfer saya untuk produk: ${produk}`);
  window.open(`https://wa.me/${wa}?text=${msg}`,'_blank');
  cartItemsArr=[]; totalPrice=0; updateCart(); closePayment();
}

function addToCart(e,i){
  const product=productsData[i];
  cartItemsArr.push(product);
  totalPrice+=product.price;
  updateCart();
  showAddMessage();
  animateFly(e);
}

function updateCart(){
  let ul=document.getElementById('cart-items');
  ul.innerHTML='';
  cartItemsArr.forEach(p=>{
    let li=document.createElement('li');
    li.textContent=`${p.name} - Rp ${p.price.toLocaleString()}`;
    ul.appendChild(li);
  });
  document.getElementById('total').textContent=totalPrice.toLocaleString();
}

function showAddMessage(){
  const msg=document.getElementById('add-message');
  msg.style.display='block';
  setTimeout(()=>msg.style.display='none',1800);
}

function animateFly(e){
  const cartIcon=document.getElementById('cart-toggle');
  const rect=e.target.getBoundingClientRect();
  const fly=document.createElement('div');
  fly.textContent='🪐';
  fly.style.position='fixed';
  fly.style.left=rect.left+'px';
  fly.style.top=rect.top+'px';
  fly.style.fontSize='2rem';
  fly.style.transition='all 1s ease';
  fly.style.zIndex='1000';
  document.body.appendChild(fly);
  setTimeout(()=>{
    fly.style.left=cartIcon.getBoundingClientRect().left+'px';
    fly.style.top=cartIcon.getBoundingClientRect().top+'px';
    fly.style.opacity='0';
  },100);
  setTimeout(()=>fly.remove(),1000);
}
</script>
</body>
</html>
