# Use the official Debian Bullseye image as the base image where MariaDB will 
# be installed on.
FROM		debian:bullseye

# Describe which port the container will be listening on. This is informational 
# and does not actually publish the port.
EXPOSE		3306

# Update the package list and install MariaDB. 
# Then, clean up the package list and remove the cache.
RUN			apt-get update \
			&& apt-get install -y mariadb-server \
			&& apt-get clean \
			&& rm -rf /var/lib/apt/lists/*

# Change the default configuration file to the one we made. 
# This is needed to allow remote connections to the database.
COPY		conf/50-server.cnf /etc/mysql/mariadb.conf.d/

# Copy the script that will be executed to the appropriate directory in the 
# container, then make it executable.
COPY		tools/setup.sh /usr/local/bin/
RUN			chmod +x /usr/local/bin/setup.sh

# After the container starts, run the setup script which in turn starts the
# MariaDB server (with mysqld) as a new process, replacing the script with msqld
# (using exec $@). 
# This ensures that mysqld becomes the PID 1 process (main process) of the
# container, allowing the container to be stopped correctly.
CMD			["/usr/local/bin/setup.sh", "mysqld"]
