## Requirements

- Ansible >= 2.1
- CentOS/RHEL >= 7.0

### How to run

	ansible-playbook -i hosts site.yml

### Variables location:

	group_vars/all

### Adding a site

Copy an example virtual host:

	cd /etc/nginx/conf.d
	cp example.com site.com

Change `server_name` and `root`:

	nano site.com

Reload Nginx:

    systemctl reload nginx

### Setting HTTP auth for a site

    cd /home/<user>/<site>/htdocs
    printf "dev:$(openssl passwd -crypt letmein)\n" >> .htpasswd

### Generating an HTTPS certificate

	certbot certonly --webroot -w /var/www/certbot -d site.com -d www.site.com

Add in /etc/nginx/conf.d/site.com

    listen 80;
	listen 443 ssl;

	ssl_certificate <cert location>;
	ssl_certificate_key <key location>;

Reload Nginx:

    systemctl reload nginx

### Adding an FTP user

	pure-pw useradd <ftp username> -u <system user> -g <system group> -d <directory>
	pure-pw mkdb
	systemctl restart pure-ftpd

### phpmyadmin

	<ip>:8001
