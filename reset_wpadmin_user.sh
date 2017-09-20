#!/bin/sh
#
# This script will create a wordpress admin user
#

source ./wordpress.conf


docker-compose run --rm wp-cli core install --url="$WORDPRESS_HOSTNAME" --title="$WORDPRESS_HOSTNAME" --admin_user="$WORDPRESS_ADMIN" --admin_password="$WORDPRESS_PASS" --admin_email="$WORDPRESS_ADMIN_MAIL"

#RESULT_VARIABLE="$(docker-compose exec wp-db env MYSQL_PWD=${DBPASS} mysql -u${DBUSER} -D ${DBNAME} -sse "SELECT EXISTS(SELECT 1 FROM wp_users WHERE user_login = '${WORDPRESS_ADMIN}')")" 
#
#TIME=$(date +'%F %T')
#
#if [ "$RESULT_VARIABLE"="1" ]; then
#  echo "Change Admin in DB"
#  docker-compose exec wp-db env MYSQL_PWD=${DBPASS} mysql -u${DBUSER} -D ${DBNAME} -se "UPDATE ${DBNAME}.wp_users SET ID = '1', user_login = '${WORDPRESS_ADMIN}', user_pass = MD5('${WORDPRESS_PASS}'), user_nicename = '${WORDPRESS_ADMIN}', user_email = '${WORDPRESS_ADMIN_MAIL}', user_url = 'https://${WORDPRESS_HOSTNAME}/', user_registered = '${TIME}', user_activation_key = '', user_status = '0', display_name = '${WORDPRESS_ADMIN}';"
#  echo USERMETA_1
#  #docker-compose exec wp-db env MYSQL_PWD=${DBPASS} mysql -u${DBUSER} -D ${DBNAME} -se "UPDATE ${DBNAME}.wp_usermeta SET meta_value = 'a:1:{s:13:"administrator";s:1:"1";}' WHERE user_id = '1' AND meta_key = 'wp_capabilities';"
#  docker-compose exec wp-db env MYSQL_PWD=${DBPASS} mysql -u${DBUSER} -D ${DBNAME} -se "UPDATE ${DBNAME}.wp_usermeta SET meta_value = 'a:1:{s:13:"administrator";b:1;}' WHERE user_id = '1' AND meta_key = 'wp_capabilities';"
#  echo USERMETA_2
#  docker-compose exec wp-db env MYSQL_PWD=${DBPASS} mysql -u${DBUSER} -D ${DBNAME} -se "UPDATE ${DBNAME}.wp_usermeta SET meta_value = '10' WHERE user_id = '1' AND meta_key = 'wp_user_level';"
#else
#  echo "Insert Admin to DB"
#  docker-compose exec wp-db env MYSQL_PWD=${DBPASS} mysql -u${DBUSER} -D ${DBNAME} -se "INSERT INTO ${DBNAME}.wp_users ('ID', 'user_login', 'user_pass', 'user_nicename', 'user_email', 'user_url', 'user_registered', 'user_activation_key', 'user_status', 'display_name') VALUES ('1', '${WORDPRESS_ADMIN}', MD5('${DBPASS}'), '${WORDPRESS_ADMIN}', '${WORDPRESS_ADMIN_MAIL}', 'https://${WORDPRESS_HOSTNAME}/', '${TIME}', '', '0', '${WORDPRESS_ADMIN}');"
#fi


#echo INSERT INTO `databasename`.`wp_users` (`ID`, `user_login`, `user_pass`, `user_nicename`, `user_email`, `user_url`, `user_registered`, `user_activation_key`, `user_status`, `display_name`) VALUES ('1', 'wordpressadmin', MD5('wordpressadmin'), 'wordpressadmin', 'mail@andacom.de', 'https://wp1.andacom.de/', '2017-09-02 00:00:00', '', '0', 'wordpressadmin');
#echo INSERT INTO `databasename`.`wp_usermeta` (`umeta_id`, `user_id`, `meta_key`, `meta_value`) VALUES (NULL, '4', 'wp_capabilities', 'a:1:{s:13:"administrator";s:1:"1";}');
#echo INSERT INTO `databasename`.`wp_usermeta` (`umeta_id`, `user_id`, `meta_key`, `meta_value`) VALUES (NULL, '4', 'wp_user_level', '10');


