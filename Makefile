up:
	sudo mkdir -p /home/$(USER)/data
	sudo mkdir -p /home/$(USER)/data/wordpress
	sudo mkdir -p /home/$(USER)/data/db_data
	cd ./srcs && docker-compose up -d

down:
	cd ./srcs && docker-compose down

rebuild:
	cd ./srcs && docker-compose up -d --build

wp-shell:
	docker exec -it wp_container /bin/sh

db-shell:
	docker exec -it db_container /bin/sh

nginx-shell:
	docker exec -it nginx_container /bin/sh

restart:
	docker restart db_container
	docker restart nginx_container
	docker restart wp_container

reset-docker:
	docker stop $(docker ps -a -q) || true
	docker rm db_container
	docker rm nginx_container
	docker rm wp_container
	docker system prune -af --volumes
	docker rm $(docker ps -a -q) || true
	docker rmi $(docker images -q) || true
	docker volume prune --force
	docker volume rm srcs_db_data srcs_wordpress_data

full-reset:
	docker stop $(docker ps -a -q)
	docker rm $(docker ps -a -q)
	docker volume rm $(docker volume ls -q)
	docker network rm $(docker network ls -q)
	docker rmi $(docker images -q)
	docker system prune -a --volumes
