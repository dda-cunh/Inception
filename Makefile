.SILENT:
DOCKER_COMPOSE		=	docker compose

COMPOSE_FILE_PATH	=	./srcs/docker-compose.yml

COMPOSE				=	${DOCKER_COMPOSE} -f ${COMPOSE_FILE_PATH}

up:
		${COMPOSE} up -d --build

down:
		${COMPOSE} down

clean:
		${COMPOSE} down --rmi all

fclean:
		${COMPOSE} down --rmi all --volumes
