server {
        server_name site.com www.site.com;
        root /home/www/site.com/htdocs;

        set $php_ver php56;

        include common.conf;
        include try.conf;
        include magento.conf;
        include php-fpm.conf;

#       expires $expires;
}
