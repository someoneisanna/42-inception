FROM		debian:bullseye

EXPOSE		3306

RUN			apt-get update \
			&& apt-get install -y mariadb-server \
			&& apt-get clean \
			&& rm -rf /var/lib/apt/lists/*

COPY		conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY		tools/setup.sh /usr/local/bin/
RUN			chmod +x /usr/local/bin/setup.sh

CMD			["/usr/local/bin/setup.sh", "mysqld"]
