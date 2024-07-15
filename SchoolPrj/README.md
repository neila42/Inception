## Introduction
This documentation provides an overview and instructions for setting up and managing your Docker-based project. The project includes NGINX, MariaDB, and WordPress services, all running in separate Docker containers.

## Project Structure
The project directory contains the following key files and folders:

```
project-root/
├── Makefile
├── data/
└── srcs/
    ├── docker-compose.yml
    └── stacks/
        ├── mariadb/
        │   ├── Dockerfile
        │   ├── conf/
        │   │   └── 50-server.cnf
        │   └── scripts/
        │       └── script.sh
        ├── nginx/
        │   ├── Dockerfile
        │   └── conf/
        │       └── nginx.conf
        └── wordpress/
            ├── Dockerfile
            ├── conf/
            │   └── www.conf
            └── scripts/
                └── script.sh


```

- Makefile: Contains commands for building, starting, stopping, and cleaning up the project.
- data/: A directory to store persistent data for services like MariaDB.
- srcs/: Source directory containing all the necessary configurations and scripts.
- docker-compose.yml: Defines the services, networks, and volumes for the multi-container Docker application.
- stacks/: Subdirectory containing service-specific configurations and scripts.
- mariadb/: Contains configurations and scripts for the MariaDB service.
- nginx/: Contains configurations and scripts for the NGINX service.
- wordpress/: Contains configurations and scripts for the WordPress service.

## Setup Instructions

### Start Project
To start all the services (NGINX, MariaDB, and WordPress):

```
make all
```

### Stop Project and Remove Containers, Images, Networks
To stop the running services:

```
make clean
```

### Clear Data Mount
To remove data/web and data/database:
```
make clearmounts
```

## Changes
You need to change following things to run the project successfully.
1. Change VOLUME_PATH on .env
2. Kindly change credentials and make it more secure.

## Tip
Make sure you create a dummy .env file (named .env.sample) and push it to GitHub. Also, add the actual .env file to the .gitignore file.

## If you need further assistance, feel free to reach out. (Discord or Email (itsprason@gmail.com))

