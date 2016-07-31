## Requirements

- Ansible >= 2.1
- CentOS/RHEL >= 7.0

### To Run

	ansible-playbook -i hosts site.yml

### To generate a certificate

	certbot certonly --webroot -w /var/www/certbot -d site.com -d www.site.com"

Then add in /etc/nginx/conf.d/site.com

	listen 443 ssl;
	ssl_certificate <cert location>
	ssl_certificate_key <key location>;

### To add an FTP user

	pure-pw useradd <ftp username> -u <system user> -g <system group> -d <directory>
	pure-pw mkdb
	systemctl reload pure-ftpd