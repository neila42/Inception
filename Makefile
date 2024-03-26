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
	docker exec -it wordpress /bin/sh

db-shell:
	docker exec -it mariadb /bin/sh

nginx-shell:
	docker exec -it nginx /bin/sh

restart:
	docker restart mariadb
	docker restart nginx
	docker restart wordpress

reset-docker:
	docker stop $(shell docker ps -a -q) || true
	docker rm mariadb nginx wordpress || true
	docker system prune -af --volumes

everything-reset:
	docker stop $(shell docker ps -a -q) || true
	docker rm $(shell docker ps -a -q) || true
	docker volume rm $(shell docker volume ls -q) || true
	docker network rm $(shell docker network ls -q) || true
	docker rmi $(shell docker images -q) || true
	docker system prune -a --volumes || true
