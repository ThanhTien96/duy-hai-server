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
`$ sudo mysql_secure_installation`

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




