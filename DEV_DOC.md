Inception Developer Documentation
1. Prerequisites (Docker, Make, OS)
Before starting, ensure your environment meets the following requirements:

OS: macOS or Linux (Virtual Machine recommended for 42 projects).
Docker: Docker Engine and Docker CLI installed.
Docker Compose: Ensure docker compose (V2) or docker-compose (V1) is available.
Make: GNU Make is required to run the automation commands.
Host file: You need to map mknoll.42.fr (or your LOGIN.42.fr) to 127.0.0.1 in /etc/hosts.
2. Project Structure Explanation
inception/
├── Makefile            # Automation commands
├── srcs/
│   ├── docker-compose.yml
│   ├── .env            # Environment configuration (Create this)
│   ├── requirements/
│   │   ├── nginx/      # NGINX Dockerfile & configs
│   │   ├── mariadb/    # MariaDB Dockerfile & scripts
│   │   ├── wordpress/  # WordPress Dockerfile & scripts
│   └── tools/
└── secrets/            # Secret files (Create this folder)
3. How to create .env
Create a .env file in the srcs/ directory.

Example content:

DOMAIN_NAME=mknoll.42.fr
SQL_DATABASE=wordpress
SQL_USER=wp_user
SQL_PASSWORD=wp_pass
SQL_ROOT_PASSWORD=root_pass
WP_ADMIN_USER=admin
WP_ADMIN_PASSWORD=admin_pass
WP_ADMIN_EMAIL=admin@student.42.fr
4. How to create /secrets
Instead of manually creating secret files and folders, use the provided developer tool setup.sh

Steps to bootstrap the environment:

1. Run the Script

./setup.sh
2. What this command does:

Creates the secrets directory if missing.
Generates secure, random passwords for MariaDB and WordPress (using OpenSSL).
Creates a default .env file if it doesn't exist
Sets file permissions (chmod 600) to secure the credentials.
5. How to build & run the project
Use the Makefile at the root of the project.

Build & Start:

make
# OR
make up
This creates the data volumes folders (e.g., /home/mknoll/data/wordpress, /home/mknoll/data/mariadb), builds the images, and starts the containers.

Stop services:

make down
Clean everything (Volumes & Images):

make fclean
6. How to debug services
Check container status
docker ps
View logs
docker logs nginx
docker logs wordpress
docker logs mariadb
Access a running container
To open a shell inside a container:

docker exec -it wordpress /bin/bash
# OR
docker exec -it nginx /bin/sh
Verify TLS (NGINX)
Check if TLS 1.2 or 1.3 is effectively running:

docker exec -it nginx openssl s_client -connect localhost:443 -tls1_3
Database persistence check
Log into MariaDB: docker exec -it mariadb mariadb -u root -p
Create a table.
Restart containers (make down && make up).
Check if table still exists.
7. (Optional) Troubleshooting
Error: Bind for 0.0.0.0:443 failed: port is already allocated
Check if another web server (like local nginx or apache) is running on your host machine.
502 Bad Gateway:
Usually means NGINX cannot talk to WordPress. Check if WordPress container is running: docker logs wordpress. Often PHP-FPM failed to start.