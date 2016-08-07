server {
        server_name site.com www.site.com;
        root /home/www/site.com/htdocs;

        set $php_engine php{{ php_ver_global | replace('.', '') }};

        include common.conf;
        include try.conf;
        include magento.conf;
        include php-fpm.conf;

#       expires $expires;
}
