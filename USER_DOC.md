User Documentation
This document explains, in clear and simple terms, how an end user or administrator can interact with the Inception project stack.

1. Services Provided by the Stack
The Inception stack consists of three main services:

Nginx: Web server that serves the WordPress site (Entry Point, Port 443).
WordPress: Content Management System (CMS) for managing website content (PHP-FPM).
MariaDB: Database service that stores WordPress data.
Nginx acts as the secure entry point and forwards PHP requests to WordPress. WordPress communicates with MariaDB to store and retrieve data.

2. Prerequisites & Configuration
Before starting, map the project URL to your localhost. Open your hosts file (on Linux/Mac: /etc/hosts) and add the following line:

127.0.0.1 mknoll.42.fr
3. Starting the Project
To start the project:

Ensure Docker and Docker Compose are installed.
Official guides:

Docker Installation
Docker Compose Installation
Clone the Inception repository:

git clone https://github.com/moknoll/Inception.git
cd Inception
Verify that Docker is running:
docker --version
docker compose version
Use the provided setup script to generate credentials and environment files.
The setup script (setup.sh) does the following:

Creates configuration files to hold the required environment variables.
Generates random passwords for database and WordPress users.
4. How to Access the Website
Once the project is running (e.g., via make), you can access the WordPress site at:

https://mknoll.42.fr

(Note: You may need to bypass the security warning for the self-signed certificate in your browser.)

5. How to Log into the Database
To verify the database contents or troubleshoot, you can access the MariaDB service directly.

Find the container ID or name:

docker ps
# Look for the container named 'mariadb'
Access the container shell:

docker exec -it mariadb bash
Log into the SQL console: Use the database user and password defined in your configuration.

Typically:

User: wp_user (or check your .env file)
Password: The content of secrets/wp_db_password.txt
Run the following command inside the container:

mariadb -u wp_user -p
# Enter the password when prompted
Verify Database Content: Once logged in (MariaDB [(none)]>), you can run SQL commands:

SHOW DATABASES;
USE wordpress;
SHOW TABLES;
SELECT * FROM wp_users;
To exit, type exit.

6. Accessing the Website and Administration Panel
Website: Open your browser and navigate to: https://mknoll.42.fr

(Note: You might see a security warning because of the self-signed certificate. Accept it to proceed.)

WordPress Admin Panel: https://mknoll.42.fr/wp-admin

7. Locating and Managing Credentials
The setup script secures credentials and stores them in the secrets/ directory:

Roots: secrets/mysql_root_password.txt
Database: secrets/mysql_password.txt & secrets/wp_db_password.txt
Admin: secrets/wp_admin_password.txt
Environment variables are stored in srcs/.env. Note: These files are ignored by Git and protected via permissions (chmod 600).

8. Checking Service Status
To verify the services are running correctly:

List running containers:

docker ps
You should see nginx, wp-php (or wordpress), and mariadb running.

Check logs: If something isn't working, check the logs of the specific service:

docker logs nginx
docker logs wordpress
docker logs mariadb
