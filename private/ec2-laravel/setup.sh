#! /bin/bash

echo "1. *** INSTALL NODE 20.x"
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt update -y
sudo apt install -y nodejs

echo "2. *** INSTALL NGINX"
sudo apt update -y
sudo apt install nginx -y
sudo ufw app list
sudo ufw allow 'Nginx HTTP' -y
sudo ufw status

echo "3. *** INSTALL AND SETUP MYSQL"
sudo apt update -y
sudo apt install -y mysql-server
MYSQL_PASSWORD=$(tr -dc 'A-Za-z0-9!#$%&()*+,-./:;<=>?@[\]^_{|}~' </dev/urandom | head -c 13  ; echo)
echo "Please use the generated password below as a MySQL password !!!"
echo "********************                       ********************"
echo "********************     ${MYSQL_PASSWORD}     ********************"
echo "********************                       ********************"
echo "Please use the generated password above as a MySQL password !!!"

# No - (Would you like to setup nano VALIDATE PASSWORD component?)
# $MYSQL_PASSWORD
# $MYSQL_PASSWORD
# y - Remove anonymous users?
# No - Disallow root login remotely?
# No - Remove test database and access to it?
# y - Reload privilege tables now?

sudo mysql_secure_installation <<EOF
No
$MYSQL_PASSWORD
$MYSQL_PASSWORD
y
No
y
y
EOF

echo "4. *** WORKING WITH MYSQL"
cat > ~/mysql.sql  <<EOF
DROP USER IF EXISTS 'laravel'@'localhost';
FLUSH PRIVILEGES;
CREATE USER 'laravel'@'localhost' IDENTIFIED WITH mysql_native_password BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO 'laravel'@'localhost';
FLUSH PRIVILEGES;
EOF
sudo mysql < ~/mysql.sql
rm mysql.sql
mysql -u root -p$MYSQL_PASSWORD -Bse "CREATE DATABASE laravel"

echo "5. *** INSTALL PHP-8.2"
sudo apt update -y
sudo dpkg -l | grep php | tee packages.txt
sudo add-apt-repository ppa:ondrej/php -y # Press enter when prompted.
sudo apt update -y
sudo apt install php8.2 php8.2-cli php8.2-{bz2,curl,mbstring,intl} -y
sudo apt install php8.2-fpm php-mysql -y
#sudo systemctl status php8.2-fpm
# [ENTER]
sudo apt update -y
#sudo apt install -y php8.2-cli php8.2-json php8.2-common php8.2-mysql php8.2-zip php8.2-gd php8.2-mbstring php8.2-curl php8.2-xml php8.2-bcmath php8.2-soap
sudo apt install php-mbstring php-xml php-bcmath  -y
sudo apt install php-cli unzip php-curl -y
sudo systemctl restart php8.2-fpm

echo "6. *** INSTALL COMPOSER"
sudo apt update -y
curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
HASH=`curl -sS https://composer.github.io/installer.sig`
php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

echo "7. *** SETUP THE LARAVEL & NGINX"
sudo apt update -y
cd /var/www/
sudo chown -R $USER:$USER ./
yes | composer create-project --prefer-dist laravel/laravel web
sudo chown -R $USER:$USER web/
sudo chown -R www-data:www-data web/storage
sudo chown -R www-data:www-data web/bootstrap/cache

echo "8. *** CREATE NEW WEB FOR CURRENT PROJECT IN NGINX"
sudo rm /etc/nginx/sites-available/default
cat > /etc/nginx/sites-available/default  <<EOF
server {
    listen 80;
    listen [::]:80;
    root /var/www/web/public;

    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-Content-Type-Options "nosniff";

    index index.php;

    charset utf-8;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    error_page 404 /index.php;

    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php8.2-fpm.sock;
        fastcgi_param SCRIPT_FILENAME \$realpath_root\$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.(?!well-known).* {
        deny all;
    }
}
EOF

#sudo ln -s /etc/nginx/sites-available/web /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx

echo "9. *** INSTALL THE PROJECT DEPENDENCIES"
cd web/
sudo chown -R $USER:www-data .
sudo chmod -R 775 storage
sudo chmod -R 775 bootstrap/cache

yes | composer install
cp .env.example .env
#sed -i -e "s/DB_DATABASE=laravel/DB_DATABASE=root/g" .env
sed -i -e "s/DB_USERNAME=root/DB_USERNAME=laravel/g" .env
sed -i -e "s/DB_PASSWORD=/DB_PASSWORD=\"${MYSQL_PASSWORD}\"/g" .env
php artisan key:generate
php artisan storage:link
php artisan route:clear
php artisan config:cache
php artisan optimize
php artisan migrate
php artisan db:seed
