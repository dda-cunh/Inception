.SILENT:
DOCKER_COMPOSE		=	docker compose

COMPOSE_FILE_PATH	=	./srcs/docker-compose.yml

COMPOSE				=	${DOCKER_COMPOSE} -f ${COMPOSE_FILE_PATH}

PERSIST_DIR			=	${HOME}/data

up:			set_perist
			${COMPOSE} up -d --build
			make logs

force_re:	set_perist
			${COMPOSE} up -d --build --force-recreate
			make logs

set_perist:
			if [ ! -d ${PERSIST_DIR} ]; then \
				mkdir -p ${PERSIST_DIR}; \
			fi
			if [ ! -d ${PERSIST_DIR}/mariadb ]; then \
				mkdir -p ${PERSIST_DIR}/mariadb; \
			fi
			if [ ! -d ${PERSIST_DIR}/wordpress ]; then \
				mkdir -p ${PERSIST_DIR}/wordpress; \
			fi

bash_into:
			CONTAINERS=$$(docker ps --format '{{.Names}}'); \
			if [ -z "$$CONTAINERS" ]; then \
				echo "No containers running!"; \
				exit 0; \
			fi; \
			echo "----------- Containers -----------"; \
			echo "$$CONTAINERS" | nl -w2 -s'. '; \
			echo "----------------------------------"; \
			read -p "Container number: " NUM; \
			CONTAINER=$$(echo "$$CONTAINERS" | sed -n "$${NUM}p"); \
			if [ -z "$$CONTAINER" ]; then \
				echo "Invalid selection!"; \
			else \
				docker exec -it $$CONTAINER bash; \
			fi

logs:
			${COMPOSE} logs -t --since 1m

down:
			${COMPOSE} down

re:			fclean up

clean:
			${COMPOSE} down --rmi all

fclean:
			${COMPOSE} down --rmi all --volumes --remove-orphans
			${COMPOSE} rm -f -s -v
			docker system prune -fa
			sudo rm -rf ${PERSIST_DIR}
