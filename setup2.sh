#!/bin/bash

# install.sh
# Automated nginx HTML setup with SSL for HNS domains
# Usage: bash <(curl -s https://hns.onl/install/install.sh)

echo "=== nginx Domain Setup ==="

# Ask for domain
echo "Enter domain name:"
read domain

# Confirm before proceeding
echo "You entered: $domain"
echo "Is this correct? (type 'yes' and press Enter to continue)"
read confirmation

if [ "$confirmation" != "yes" ]; then
    echo "Aborted by user."
    exit 1
fi

echo "Starting installation for domain: $domain"

# Create directory and set permissions
sudo mkdir -p /var/www/$domain
cd /var/www/$domain

# Create index.html
sudo tee index.html > /dev/null <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
  <title>[DOMAIN] — Successfully installed | HNS Website Live</title>
  
  <!-- SEO Meta -->
  <meta name="description" content="This Handshake TLD website is successfully deployed and secured with DANE. Nginx + static site running on HNS blockchain domain.">
  <meta name="robots" content="index, follow">
  
  <!-- Fonts: Poppins for big title, Muli for footer, Inter for cards -->
  <link href="https://fonts.googleapis.com/css?family=Poppins:700" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css?family=Muli" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700&display=swap" rel="stylesheet">
  
  <style>
    /* HNS hidden elements removal (keep original style from request) */
    a[href="https://www.hns.to"],
    div[style*="background-color: rgb(241, 0, 19);"],
    div[style="margin: 0; padding: 0; height: 75px"] {
      display: none !important;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      background: #00091B;
      color: #fff;
      margin: 0;
      padding: 0;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
      font-family: 'Inter', 'Muli', sans-serif;
      position: relative;
    }

    /* subtle animated gradient orb (modern but not intrusive) */
    body::before {
      content: '';
      position: fixed;
      top: -50%;
      left: -50%;
      width: 200%;
      height: 200%;
      background: radial-gradient(circle at 30% 40%, rgba(0, 40, 80, 0.4), rgba(0, 5, 20, 0.95));
      z-index: -2;
      pointer-events: none;
    }

    /* original fadeIn animation from reference */
    @keyframes fadeIn {
      from { top: 20%; opacity: 0; }
      to { top: 100; opacity: 1; }
    }
    @-webkit-keyframes fadeIn {
      from { top: 20%; opacity: 0; }
      to { top: 100; opacity: 1; }
    }

    /* wrapper exactly as original but with responsive positioning */
    .wrapper {
      position: absolute;
      left: 50%;
      top: 33%;
      transform: translate(-50%, -50%);
      -webkit-transform: translate(-50%, -50%);
      animation: fadeIn 1000ms ease;
      -webkit-animation: fadeIn 1000ms ease;
      width: 100%;
      text-align: center;
    }

    h1 {
      font-size: 250px;
      font-family: 'Poppins', sans-serif;
      margin-bottom: 0;
      line-height: 1;
      font-weight: 700;
    }

    .dot {
      color: #dafe55;
    }

    .terminal-container {
      margin-top: 20px;
      text-align: center;
    }

    .terminal {
      display: inline-block;
      font-family: 'Courier New', monospace;
      font-size: 24px;
      color: #fff;
      overflow: hidden;
      white-space: nowrap;
      border-right: 2px solid #dafe55;
      animation: blink-caret 1s step-end infinite;
    }

    .waitlist-link {
      color: #fff;
      text-decoration: none;
      transition: color 0.3s ease;
    }

    .waitlist-link:hover {
      color: #fff;
      text-decoration: underline;
    }

    @keyframes blink-caret {
      from, to { border-color: transparent; }
      50% { border-color: #dafe55; }
    }

    /* footer styling — only copyright, no extra links */
    footer {
      text-align: center;
      padding: 20px;
      font-family: 'Muli', sans-serif;
      font-size: 14px;
      color: #aaa;
      width: 100%;
      box-sizing: border-box;
      position: fixed;
      bottom: 0;
      left: 0;
      background: transparent;
      z-index: 10;
    }

    .footer-content {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 20px;
      flex-wrap: wrap;
    }

    /* ---------- IMPROVED INFO-GRID (from the previous beautiful design) ---------- */
    .info-grid {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 1.2rem;
      margin-top: 0;
      margin-bottom: 0;
      position: absolute;
      bottom: 85px;
      left: 0;
      right: 0;
      padding: 0 1.5rem;
      z-index: 5;
    }

    .info-card {
      background: rgba(20, 26, 40, 0.75);
      backdrop-filter: blur(8px);
      border-radius: 1.5rem;
      padding: 0.85rem 1.8rem;
      border: 1px solid rgba(79, 109, 139, 0.4);
      transition: all 0.3s cubic-bezier(0.2, 0.9, 0.4, 1.1);
      display: flex;
      align-items: center;
      gap: 0.8rem;
      font-family: 'Inter', monospace;
      font-size: 0.85rem;
      font-weight: 500;
      color: #e2ecff;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
    }

    .info-card:hover {
      transform: translateY(-4px);
      border-color: #8bb4e6;
      background: rgba(30, 45, 70, 0.85);
      box-shadow: 0 12px 24px -12px rgba(0, 0, 0, 0.5);
    }

    .info-card i {
      font-size: 1.2rem;
      color: #dafe55;
      transition: transform 0.2s;
    }

    .info-card:hover i {
      transform: scale(1.05);
    }

    .info-card strong {
      color: white;
      font-weight: 700;
    }

    .info-card span {
      color: #c2d4f0;
    }

    /* success micro badge (top right) */
    .success-micro {
      position: absolute;
      top: 20px;
      right: 24px;
      background: rgba(10, 20, 30, 0.7);
      backdrop-filter: blur(8px);
      padding: 6px 14px;
      border-radius: 40px;
      font-size: 11px;
      font-family: 'Inter', monospace;
      font-weight: 600;
      color: #dafe55;
      border: 1px solid rgba(100, 180, 80, 0.5);
      letter-spacing: 0.3px;
      z-index: 20;
      pointer-events: none;
    }

    .success-micro i {
      margin-right: 6px;
      font-size: 10px;
    }

    /* responsive adjustments for perfect layout */
    @media (max-width: 1400px) {
      h1 { font-size: 180px; }
      .wrapper { top: 35%; }
      .info-grid { bottom: 75px; gap: 1rem; }
    }

    @media (max-width: 1000px) {
      h1 { font-size: 120px; }
      .terminal { font-size: 20px; }
      .wrapper { top: 38%; }
      .info-grid { bottom: 70px; gap: 0.9rem; }
      .info-card { padding: 0.65rem 1.4rem; font-size: 0.75rem; }
      .info-card i { font-size: 1rem; }
    }

    @media (max-width: 768px) {
      h1 { font-size: 80px; }
      .terminal { font-size: 16px; white-space: nowrap; }
      .wrapper { top: 40%; }
      .info-grid { bottom: 80px; gap: 0.75rem; flex-wrap: wrap; }
      .info-card { padding: 0.5rem 1.2rem; font-size: 0.7rem; }
      .success-micro { top: 12px; right: 12px; font-size: 9px; padding: 4px 10px; }
    }

    @media (max-width: 550px) {
      h1 { font-size: 58px; }
      .terminal { font-size: 12px; }
      .wrapper { top: 42%; }
      .info-grid { bottom: 70px; gap: 0.6rem; }
      .info-card { padding: 0.4rem 1rem; font-size: 0.65rem; gap: 0.5rem; }
      .info-card i { font-size: 0.85rem; }
    }

    /* extra tiny screens */
    @media (max-height: 700px) and (min-width: 600px) {
      .wrapper { top: 38%; }
      .info-grid { bottom: 60px; }
      .info-card { padding: 0.45rem 1rem; }
    }
  </style>
  <!-- Font Awesome (for card icons) -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>

<div class="success-micro">
  <i class="fas fa-shield-alt"></i> DANE SECURED · NGINX ACTIVE
</div>

<div class="wrapper">
  <h1>
    <span class="dot">.</span> <span id="displayDomain">[your.domain]</span>
  </h1>
  <div class="terminal-container">
    <div id="terminal" class="terminal"></div>
  </div>
</div>

<!-- BEAUTIFUL INFO GRID - redesigned with the previous modern card style -->
<div class="info-grid">
  <div class="info-card">
    <i class="fas fa-server"></i>
    <span><strong>Nginx + SSL</strong> · DANE ready</span>
  </div>
  <div class="info-card">
    <i class="fas fa-globe"></i>
    <span><strong>Handshake TLD:</strong> <span id="domainShort"></span></span>
  </div>
  <div class="info-card">
    <i class="fas fa-certificate"></i>
    <span><strong>TLSA 3 1 1</strong> · Active</span>
  </div>
  <div class="info-card">
    <i class="fas fa-code"></i>
    <span><strong>HTML/CSS/JS</strong> static site</span>
  </div>
</div>

<footer>
  <div class="footer-content">
    <span>© <span id="current-year"></span> — deployed via SETUP.HNS.ONL</span>
    <!-- no extra links, only copyright -->
  </div>
</footer>

<script>
  // ----- DOMAIN EXTRACTION (hostname, param, or fallback) -----
  let installedDomain = '';
  
  // 1) check URL parameter ?domain=
  const urlParams = new URLSearchParams(window.location.search);
  const paramDomain = urlParams.get('domain');
  
  if (paramDomain && paramDomain.trim().length > 0) {
    installedDomain = paramDomain.trim();
  } else {
    // 2) use actual browser hostname (the HNS domain)
    let host = window.location.hostname;
    if (host.startsWith('www.')) host = host.substring(4);
    if (host && host !== 'localhost' && !host.match(/^\d+\.\d+\.\d+\.\d+$/)) {
      installedDomain = host;
    } else {
      // fallback for local / demo
      installedDomain = 'example.hns';
    }
  }
  
  installedDomain = installedDomain.replace(/\/$/, '').toLowerCase();
  if (!installedDomain) installedDomain = 'handshake-tld';
  
  // update H1 display
  const domainSpan = document.getElementById('displayDomain');
  if (domainSpan) domainSpan.innerText = installedDomain;
  
  // update short domain in card
  const shortSpan = document.getElementById('domainShort');
  if (shortSpan) {
    let shortVal = installedDomain;
    if (shortVal.length > 28) shortVal = shortVal.substring(0, 25) + '…';
    shortSpan.innerText = shortVal;
  }
  
  // set page title
  document.title = `${installedDomain} — HNS Live | DANE Secured`;
  
  // set current year in footer
  document.getElementById('current-year').textContent = new Date().getFullYear();
  
  // ---------- ORIGINAL TYPING EFFECT (exactly matching reference: "Join the waitlist" style) ----------
  // We preserve the exact logic: type a message, then transform into a stylish element (not a real link to keep clean)
  // But using the same "waitlist-link" class for aesthetics, with no actual href.
  const terminal = document.getElementById('terminal');
  // custom success message that fits the installation context
  const typedMessage = `✨ ${installedDomain} is live ✨`;
  let index = 0;
  
  function typeText() {
    if (index < typedMessage.length) {
      terminal.textContent += typedMessage.charAt(index);
      index++;
      setTimeout(typeText, 100);
    } else {
      // After typing finishes, replace with a polished static element (same original transformation style)
      setTimeout(() => {
        const finalSpan = document.createElement('span');
        finalSpan.className = 'waitlist-link';
        finalSpan.style.cursor = 'default';
        finalSpan.style.textDecoration = 'none';
        finalSpan.style.fontWeight = '500';
        finalSpan.innerHTML = `⚡ ${installedDomain} · DANE secured ⚡`;
        terminal.innerHTML = '';
        terminal.appendChild(finalSpan);
        terminal.style.borderRight = '2px solid #dafe55';
        // small glow animation
        finalSpan.style.animation = 'glowPulse 1.5s ease';
      }, 500);
    }
  }
  
  // inject keyframes for glowPulse if not exists
  if (!document.querySelector('#glowKeyframes')) {
    const styleSheet = document.createElement("style");
    styleSheet.id = 'glowKeyframes';
    styleSheet.textContent = `@keyframes glowPulse { 0% { text-shadow: 0 0 0px #dafe55; } 100% { text-shadow: 0 0 6px #dafe55; } }`;
    document.head.appendChild(styleSheet);
  }
  
  // start typing after a delay like original (1000ms)
  setTimeout(typeText, 1000);
  
  // ensure terminal caret keeps blinking effect (original)
  if (terminal) {
    terminal.style.cursor = 'default';
  }
  
  // ----- Adjust wrapper position for better visibility of info cards (no overlap) -----
  function adjustWrapperPosition() {
    const wrapper = document.querySelector('.wrapper');
    const infoGrid = document.querySelector('.info-grid');
    if (window.innerHeight < 700 && wrapper && infoGrid) {
      if (window.innerHeight < 600) {
        wrapper.style.top = '30%';
      } else {
        wrapper.style.top = '33%';
      }
    } else {
      wrapper.style.top = '33%';
    }
    // also adjust bottom of info-grid if needed
    if (window.innerHeight < 650) {
      infoGrid.style.bottom = '60px';
    } else {
      infoGrid.style.bottom = '85px';
    }
  }
  window.addEventListener('resize', adjustWrapperPosition);
  adjustWrapperPosition();
  
  // ---- additional micro-interactions: info cards hover effects already in css, but we add minor extra
  const cards = document.querySelectorAll('.info-card');
  cards.forEach(card => {
    card.addEventListener('mouseenter', () => {
      const icon = card.querySelector('i');
      if (icon) icon.style.transform = 'scale(1.1)';
    });
    card.addEventListener('mouseleave', () => {
      const icon = card.querySelector('i');
      if (icon) icon.style.transform = 'scale(1)';
    });
  });
  
  // Optional: ensure no conflicts with any leftover hidden elements
  console.log(`%c✅ HNS Domain ${installedDomain} successfully installed via setup.hns.onl`, 'color: #dafe55; font-size: 12px; background: #00091B; padding: 2px 4px; border-radius: 6px;');
  
  // small fix for extremely narrow screens: terminal white-space
  function fixTerminalOverflow() {
    if (window.innerWidth < 500 && terminal) {
      const txt = terminal.innerText;
      if (txt && txt.length > 20) {
        terminal.style.whiteSpace = 'normal';
        terminal.style.wordBreak = 'break-word';
        terminal.style.maxWidth = '90vw';
      } else {
        terminal.style.whiteSpace = 'nowrap';
      }
    } else if (terminal) {
      terminal.style.whiteSpace = 'nowrap';
    }
  }
  window.addEventListener('resize', fixTerminalOverflow);
  fixTerminalOverflow();
</script>

<!-- ensure any stray hidden divs from template are completely gone (compatibility) -->
<div style="display: none;">Handshake installation — DANE secured website</div>
</body>
</html>
EOF

# Set proper permissions
sudo chown -R $USER:$USER /var/www/$domain
sudo chmod -R 755 /var/www/$domain

# Install nginx
sudo apt update
sudo apt install nginx -y

# Setup NGINX config
sudo tee /etc/nginx/sites-available/$domain > /dev/null <<EOF
server {
  listen 80;
  listen [::]:80;
  root /var/www/$domain;
  index index.html;
  server_name $domain *.$domain;

    location / {
        try_files \$uri \$uri/ @htmlext;
    }

    location ~ \.html$ {
        try_files \$uri =404;
    }

    location @htmlext {
        rewrite ^(.*)$ \$1.html last;
    }
    error_page 404 /404.html;
    location = /404.html {
            internal;
    }
    location = /.well-known/wallets/HNS {
        add_header Cache-Control 'must-revalidate';
        add_header Content-Type text/plain;
    }
    listen 443 ssl;
    ssl_certificate /etc/ssl/$domain.crt;
    ssl_certificate_key /etc/ssl/$domain.key;
}
EOF

# Enable site
sudo ln -sf /etc/nginx/sites-available/$domain /etc/nginx/sites-enabled/

# Remove default site if exists
sudo rm -f /etc/nginx/sites-enabled/default

# Generate SSL certificate
openssl req -x509 -newkey rsa:4096 -sha256 -days 365 -nodes \
  -keyout cert.key -out cert.crt -extensions ext -config \
  <(echo "[req]";
    echo distinguished_name=req;
    echo "[ext]";
    echo "keyUsage=critical,digitalSignature,keyEncipherment";
    echo "extendedKeyUsage=serverAuth";
    echo "basicConstraints=critical,CA:FALSE";
    echo "subjectAltName=DNS:$domain,DNS:*.$domain";
    ) -subj "/CN=*.$domain"

# Get TLSA data
tlsa_data=$(openssl x509 -in cert.crt -pubkey -noout | openssl pkey -pubin -outform der | openssl dgst -sha256 -binary | xxd -p -u -c 32)

# Determine NAME for A and AAAA records
if [[ $domain == *.* ]]; then
    # Domain has a dot, use part before the first dot
    dns_name=$(echo "$domain" | cut -d'.' -f1)
else
    # No dot detected, use @
    dns_name="@"
fi

# Get server IP addresses
ipv4=$(curl -s -4 ifconfig.me 2>/dev/null || echo "YOUR_IPv4_ADDRESS")
ipv6=$(curl -s -6 ifconfig.me 2>/dev/null || echo "YOUR_IPv6_ADDRESS")

# Print DNS records
echo "Add these Records to your DNS:"
echo "-------------"
echo "TYPE: A"
echo "NAME: $dns_name"
echo "VALUE/DATA: $ipv4"
echo "-------------"
echo "TYPE: AAAA"
echo "NAME: $dns_name"
echo "VALUE/DATA: $ipv6"
echo "-------------"
echo "TYPE: TLSA"
echo "NAME: _443._tcp"
echo "VALUE/DATA:"
echo "3 1 1 $tlsa_data"
echo "-------------"

# Add extra TLSA record if domain contains a dot
if [[ $domain == *.* ]]; then
    # Use part before the dot for the TLSA record name
    tlsa_name_part=$(echo "$domain" | cut -d'.' -f1)
    echo "TYPE: TLSA"
    echo "NAME: _443._tcp.$tlsa_name_part"
    echo "VALUE/DATA:"
    echo "3 1 1 $tlsa_data"
    echo "-------------"
fi

echo "TYPE: TLSA"
echo "NAME: *"
echo "VALUE/DATA:"
echo "3 1 1 $tlsa_data"
echo "-------------"

# Move certificates
sudo mv cert.key /etc/ssl/$domain.key
sudo mv cert.crt /etc/ssl/$domain.crt

# Set certificate permissions
sudo chmod 600 /etc/ssl/$domain.key
sudo chmod 644 /etc/ssl/$domain.crt

# Test nginx configuration
sudo nginx -t

# Restart to apply config file
sudo systemctl restart nginx

echo ""
echo "Installation completed for domain: $domain"
echo "Website directory: /var/www/$domain"
echo "Nginx config: /etc/nginx/sites-available/$domain"
