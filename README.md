### DEPLOY APP EC2 AWS DOC ###
# 1. update your vps
`$ sudo apt update`

# 2. upgrade your vps
`$ sudo apt upgrade` 

## create data base my SQL
# 1 install mysql in your vps
`$ sudo apt-get install mysql-server`

# 2 step 1 complete you run it
`sudo service mysql start`

# 3 Config MY-SQL you can pass it
`$ sudo mysql`
`$ ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '12345678';`

# 3 login mysql
`$ mysql -u root -p`

# 4 show your data base
`SHOW DATABASES;`

# 5 create your data base
`CREATE DATABASE <your_data_base_name>;`

# 6 check your mysql status
`sudo systemctl status mysql`

# 7 try it 
`USE restaurant_server;`
`SELECT * FROM table_name;`

# 8 import your backup 
`#6969DA` user name can be root user file.sql is your file import
`mysql -u username -p database_name < file.sql`

## git clone your sever code

# 1 setup your nvm 
`curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash`

# 2 restart your terminal to config nvm
`source ~/.bashrc`

# 3 intall node js
`nvm install v18`

# 4 use node
`nvm install v18`

# 5 install npm 
`#6964DA` if npm notfound you need to install it
`sudo npm install`

# 6 clone your server git
`git clone <https://git....>`


## install pm2 to running it
# 1 install
`npm install pm2@latest -g`

# 2 run it
`pm2 start index.js --name demo`

# 3 pm2 more
`#6964DA` stop pm2
`sudo pm2 stop all`
`#6964DA` Can Reload app using
`sudo pm2 reload all`
`#6964DA` Can Reload app using


## setup SSL 
# 1 setup Certbot
`sudo apt update`
`sudo apt install certbot`

# 2 setup firewall
`sudo ufw allow 80`

# 3 get ssl CA from Encrypt
`sudo certbot certonly --standalone --preferred-challenges http -d your_ip_address`



