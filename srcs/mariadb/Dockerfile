FROM		debian:bullseye

EXPOSE		3306

RUN			apt-get update \
			&& apt-get install -y mariadb-server \
			&& apt-get clean \
			&& rm -rf /var/lib/apt/lists/*

COPY		files/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY		files/setup.sh /usr/local/bin/
RUN			chmod +x /usr/local/bin/setup.sh

ENTRYPOINT	["/usr/local/bin/setup.sh"]
