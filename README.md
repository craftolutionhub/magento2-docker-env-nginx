# NGINX Docker Environment for Magento 2.1.x

### Image Summary:

 - PHP 7.0 & NGINX
 - Ubuntu 16.04
 - MySQL
 - Redis
 - Nano editor and Midnight Commander for fast debugging
 - Optimized for Magento2
 - Easy to configure

### Usage

 1. Copy the files of this repo to your project root directory.
 2. Fill in the docker/auth.json file with yout authentication data. For more information please visit https://devdocs.magento.com/guides/v2.2/install-gde/prereq/connect-auth.html
 3. Build your image based on this one. Run the following command from project root:  `docker compose up -d`
 4. (Optional) Edit your hosts file. Add: `127.0.0.1    magento2.lh`
 5. If docker compose command is finished then you can reach your site at: http://127.0.0.1:8080 or http://magento.lh:8080.

 ### Redis Configuration 
 
 Add the following code to your app/etc/env.php:
 
 ```
 'session' =>
array (
  'save' => 'redis',
  'redis' =>
  array (
    'host' => '171.28.1.4',
    'port' => '6379',
    'password' => '',
    'timeout' => '2.5',
    'persistent_identifier' => '',
    'database' => '2',
    'compression_threshold' => '2048',
    'compression_library' => 'gzip',
    'log_level' => '1',
    'max_concurrency' => '6',
    'break_after_frontend' => '5',
    'break_after_adminhtml' => '30',
    'first_lifetime' => '600',
    'bot_first_lifetime' => '60',
    'bot_lifetime' => '7200',
    'disable_locking' => '0',
    'min_lifetime' => '60',
    'max_lifetime' => '2592000'
  )
),
 ```
 
 ### MySQL Configuration:
 
 MySQL base configuration is located at docker/env file.
 
 ```
MYSQL_HOST=171.28.1.2
MYSQL_ROOT_PASSWORD=root
MYSQL_USER=magento
MYSQL_PASSWORD=magento
MYSQL_DATABASE=magento
 ```
 
 #### Custom MySQL configuration
 
 You can apply your own MySQL configuration with docker/my.cnf file:
 For example you want to add these settins, put the settings into my.cnf and restart you mysql container.
 
 ```
 [mysqld]
innodb_data_file_path = ibdata1:10M:autoextend:max:512M
tmp_table_size=256M 
max_heap_table_size=256M
 ```
 
 ### Container Terminal
 
 As root:
 
 ```
 docker exec -it  {container name or id} bash
 ```
 
 As www-data:
 
 ```
 docker exec -it --user www-data {container name or id} bash
 ```
 
 Recommended to use container terminal as www-data. Just use root user to change permissions of the files.
 
 
 ### Docker Compose YML file
 
 You can set the attached volumes in this file or you can add more container, for example:
  - Varnish
  - Elasctic Search
  - etc.
 
If you want to run more than one Magento project, then set different Ip addresses in this file and re-run the compose command.
