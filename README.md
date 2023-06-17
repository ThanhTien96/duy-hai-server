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
