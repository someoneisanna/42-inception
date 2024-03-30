FROM		debian:bullseye

EXPOSE		9000

RUN			apt-get update \
			&& apt-get install -y \
				php-fpm \
				php-mysql \
				mariadb-client \
				wget \
				tar \
			&& apt-get clean \
			&& rm -rf /var/lib/apt/lists/*

RUN			mkdir -p /var/www/

RUN			wget -O /tmp/latest.tar.gz https://wordpress.org/latest.tar.gz \
			&& tar -xvf /tmp/latest.tar.gz -C /var/www/ \
			&& rm /tmp/latest.tar.gz

COPY		conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY		conf/wp-config.php /var/www/wordpress/wp-config.php

COPY		tools/setup.sh /tmp/
RUN			chmod +x /tmp/setup.sh

ENTRYPOINT ["/tmp/setup.sh", "php-fpm7.4", "-F", "-R"]
