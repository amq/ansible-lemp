server {
        server_name site.com www.site.com;
        root /home/www/site.com/htdocs;

        set $php_ver php56;

        location ^~ /app/                { deny all; }
        location ^~ /includes/           { deny all; }
        location ^~ /lib/                { deny all; }
        location ^~ /media/downloadable/ { deny all; }
        location ^~ /pkginfo/            { deny all; }
        location ^~ /report/config.xml   { deny all; }
        location ^~ /var/                { deny all; }

        include common.conf;
        include try.conf;
        include php-fpm.conf;
}
