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
  <title>✓ Installation Successful | Nginx + Handshake</title>
  <meta name="description" content="Your Handshake website has been successfully deployed with Nginx. Static HTML/CSS/JS site is now live.">
  <meta name="robots" content="index, follow">
  
  <!-- Minimal font: only Inter for clean look -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,400;14..32,500;14..32,600;14..32,700;14..32,800&display=swap" rel="stylesheet">
  
  <style>
    /* ----- RESET & GLOBAL ----- */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      background: #00091B;
      color: #eef2ff;
      font-family: 'Inter', system-ui, -apple-system, sans-serif;
      line-height: 1.5;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
      position: relative;
    }

    /* animated gradient background (lightweight, elegant) */
    body::before {
      content: '';
      position: fixed;
      inset: 0;
      background: radial-gradient(circle at 30% 20%, rgba(0, 60, 110, 0.3), rgba(0, 5, 20, 0.98));
      z-index: -2;
      pointer-events: none;
    }

    body::after {
      content: '';
      position: fixed;
      inset: 0;
      background: radial-gradient(circle at 80% 70%, rgba(30, 80, 140, 0.15), transparent 70%);
      z-index: -1;
      pointer-events: none;
    }

    /* main container - centered, clean */
    .success-container {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      min-height: 100vh;
      padding: 2rem 1.5rem;
      text-align: center;
    }

    /* main title - big, bold, success-focused */
    .success-title {
      font-size: clamp(2.8rem, 10vw, 5.5rem);
      font-weight: 800;
      letter-spacing: -0.02em;
      background: linear-gradient(135deg, #ffffff, #a0d0ff, #7bc5ff);
      -webkit-background-clip: text;
      background-clip: text;
      color: transparent;
      margin-bottom: 2rem;
      animation: fadeSlideUp 0.7s cubic-bezier(0.2, 0.9, 0.4, 1.1) forwards;
      line-height: 1.2;
    }

    /* ----- CLEAN INFO GRID (only essential items) ----- */
    .info-grid {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 1.25rem;
      max-width: 800px;
      margin: 0 auto 2rem;
      animation: fadeSlideUp 0.7s 0.1s forwards;
      opacity: 0;
      transform: translateY(20px);
    }

    .info-card {
      background: rgba(12, 18, 28, 0.7);
      backdrop-filter: blur(8px);
      border-radius: 1.5rem;
      padding: 0.9rem 1.8rem;
      border: 1px solid rgba(79, 109, 139, 0.4);
      transition: all 0.25s ease;
      display: flex;
      align-items: center;
      gap: 0.75rem;
      font-size: 0.9rem;
      font-weight: 500;
      color: #d6e5ff;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
    }

    .info-card:hover {
      transform: translateY(-3px);
      border-color: #8bb4e6;
      background: rgba(25, 40, 60, 0.8);
      box-shadow: 0 12px 24px -12px rgba(0, 0, 0, 0.5);
    }

    .info-card i {
      font-size: 1.3rem;
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

    /* subtle separator line (optional, keeps design balanced) */
    .separator-line {
      width: 60px;
      height: 2px;
      background: linear-gradient(90deg, transparent, #dafe55, #7bc5ff, transparent);
      margin: 0.8rem auto 0;
      border-radius: 2px;
    }

    /* footer - minimal, no extra links */
    footer {
      text-align: center;
      padding: 1.5rem;
      font-size: 0.75rem;
      color: #5f7a9e;
      border-top: 1px solid rgba(50, 70, 100, 0.3);
      margin-top: auto;
      background: rgba(0, 0, 0, 0.2);
    }

    /* animations */
    @keyframes fadeSlideUp {
      0% {
        opacity: 0;
        transform: translateY(24px);
      }
      100% {
        opacity: 1;
        transform: translateY(0);
      }
    }

    /* responsive adjustments */
    @media (max-width: 680px) {
      .info-grid {
        gap: 0.9rem;
      }
      .info-card {
        padding: 0.6rem 1.2rem;
        font-size: 0.75rem;
      }
      .info-card i {
        font-size: 1rem;
      }
    }

    @media (max-width: 480px) {
      .success-container {
        padding: 1.5rem;
      }
      .info-card {
        padding: 0.5rem 1rem;
        gap: 0.5rem;
      }
      .success-title {
        margin-bottom: 1.5rem;
      }
    }
  </style>
  <!-- Font Awesome 6 (lightweight icons) -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>

<div class="success-container">
  <!-- main title: successful install -->
  <h1 class="success-title">✓ Installation<br>Successful</h1>

  <!-- clean info-grid: only Nginx + SSL, HTML/CSS/JS (removed DANE, TLSA, HTTPS self-signed, etc) -->
  <div class="info-grid">
    <div class="info-card">
      <i class="fas fa-server"></i>
      <span><strong>Nginx + SSL</strong> · Ready</span>
    </div>
    <div class="info-card">
      <i class="fas fa-code"></i>
      <span><strong>HTML / CSS / JS</strong> · Static site</span>
    </div>
  </div>
  
  <div class="separator-line"></div>
</div>

<footer>
  <span>© 2025 — SETUP.HNS.ONL</span>
</footer>

<!-- No complex JS, no variables, no extra badges — perfectly clean -->
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
