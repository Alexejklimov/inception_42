Inception
A multi‑container Docker application built as part of the 42 curriculum.

📌 Overview
Inception introduces Docker and Docker Compose by building a small, production‑style infrastructure consisting of:

Nginx — HTTPS reverse proxy

WordPress — CMS application running via PHP‑FPM

MariaDB — relational database

All services run inside containers, connected through a dedicated Docker network, with persistent storage handled via Docker volumes.

🏗️ Architecture
Service Flow
Nginx listens on 443 (HTTPS)

It forwards requests to WordPress via FastCGI (port 9000)

WordPress communicates with MariaDB on 3306

Volumes
wordpress_data → persistent WordPress files

mariadb_data → persistent MariaDB database

These ensure data survives container rebuilds.

🐳 Docker Concepts Used
Docker Containers
Lightweight, isolated processes sharing the host kernel.

Docker Compose
Defines and orchestrates multi‑container setups.

**Docker Networks****
Provides container‑to‑container communication and isolation.

Docker Volumes
Ensures persistent storage independent of container lifecycle.

🔐 Configuration & Security
Environment Variables (.env)
Used for non‑sensitive configuration:

Code
DB_USER=admin
DB_PASSWORD=supersecret
Docker Secrets
Used for sensitive data (passwords, keys).
Mounted securely under /run/secrets/<name>.

Use .env for: ports, usernames, non‑secret config
Use secrets for: passwords, tokens, certificates

🖥️ Virtual Machine vs Docker
Virtual Machine
Full guest OS

Heavy resource usage

Slow startup

Docker
OS‑level virtualization

Lightweight

Starts in seconds

📂 Project Structure (recommended)
Code
Inception/
├── Makefile
├── srcs/
│   ├── docker-compose.yml
│   ├── requirements/
│   │   ├── nginx/
│   │   ├── wordpress/
│   │   └── mariadb/
│   └── .env
└── data/
    ├── mariadb/
    └── wordpress/
🚀 Usage
Start the project
Code
make
Stop the project
Code
make down
Clean everything
Code
make fclean
Access the site
Open:

Code
https://<your-login>.42.fr
🧪 Verification Checklist
Nginx serves HTTPS only

WordPress is reachable and persistent

MariaDB stores data in /home/<login>/data/mariadb

Containers restart automatically

No official Docker images used (all custom-built)

📚 Resources
Docker Best Practices

MariaDB Docker Docs

Nginx TLS Guide

Docker Volumes Explained

🤖 AI Usage
AI tools were used for:

Debugging container logs

Explaining Docker concepts

Improving shell scripts and entrypoints