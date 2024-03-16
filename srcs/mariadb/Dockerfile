FROM		debian:bullseye

EXPOSE		3306

RUN			apt-get update \
			&& apt-get install -y mariadb-server \
			&& rm -rf /var/lib/apt/lists/*

COPY		setup.sh /usr/local/bin/
RUN			chmod +x /usr/local/bin/setup.sh

ENTRYPOINT	["/usr/local/bin/setup.sh"]
