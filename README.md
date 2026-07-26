# Inception  
Project in school 42 Common Core - multi‑container Docker application built that requires docker-compose usage. 

---

## 📌 Overview  
Inception introduces **Docker** and **Docker Compose** by building a small, production‑style infrastructure consisting of:

- **Nginx** — HTTPS reverse proxy  
- **WordPress** — CMS running via PHP‑FPM  
- **MariaDB** — relational database  

All services run inside containers, connected through a dedicated Docker network, with persistent storage handled via Docker volumes.

---

### 🏗️ Architecture  

### **Service Flow**
- Nginx listens on **443 (HTTPS)**  
- Nginx forwards requests to WordPress via **FastCGI (port 9000)**  
- WordPress communicates with MariaDB on **3306**  

### **Volumes**
- `wordpress_data` → persistent WordPress files  
- `mariadb_data` → persistent MariaDB database  

These ensure data survives container rebuilds.

---

## 🐳 Docker Concepts Used  

### **Docker Containers**  
Lightweight, isolated processes sharing the host kernel.

### **Docker Compose**  
Defines and orchestrates multi‑container setups.

### **Docker Networks**  
Provides container‑to‑container communication and isolation.

### **Docker Volumes**  
Ensures persistent storage independent of container lifecycle.

---

## 🔐 Configuration & Security  

### **Environment Variables (`.env`)**  
Used for non‑sensitive configuration:



DB_USER=oklimov | 
DB_PASSWORD=goodpass-0

Docker Secrets
Used for sensitive data (passwords, keys).
Mounted securely under /run/secrets/<name>.

Use .env for: ports, usernames, non‑secret config
Use secrets for: passwords, tokens, certificates

## 🖥️ Virtual Machine vs Docker
### Virtual Machine
Full guest OS

Heavy resource usage

Slow startup

### Docker
OS‑level virtualization

Lightweight

Starts in seconds

## 📂 Project Structure (recommended)
```
── DEV_DOC.md
├── Makefile
├── README.md
├── secrets
├── srcs
│   ├── docker-compose.yml
│   └── requirements
│       ├── mariadb
│       │   ├── conf
│       │   │   └── 50-server.cnf
│       │   ├── Dockerfile
│       │   └── tools
│       │       └── mariadb-init.sh
│       ├── nginx
│       │   ├── conf
│       │   │   └── nginx.conf
│       │   └── Dockerfile
│       └── wordpress
│           ├── conf
│           │   └── www.conf
│           ├── Dockerfile
│           └── tools
│               └── wp-setup.sh
└── USER_DOC.md
```  


## 🚀 Usage

`make up` -  Start the project

`make down` - Stop the project

`make fclean` - Clean everything

To access the site open:  -  https://oklimov.42.fr

## 🧪 Verification Checklist

- Nginx serves HTTPS only

- WordPress is reachable and persistent

- MariaDB stores data in /home/oklimov/data/mariadb

- Containers restart automatically

- No official Docker images used (all custom-built)


## 📚 Resources
- https://docs.docker.com/build/building/best-practices/
- https://hub.docker.com/_/mariadb
- https://github.com/MariaDB/mariadb-docker/blob/master/docker-entrypoint.sh
- https://github.com/docker/awesome-compose
- https://docs.nginx.com/tls

## 🤖 AI Usage

AI tools were used for:

Debugging container logs

Explaining Docker concepts

Improving shell scripts and entrypoints
