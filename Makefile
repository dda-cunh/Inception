.SILENT:
DOCKER_COMPOSE		=	docker compose

COMPOSE_FILE_PATH	=	./srcs/docker-compose.yml

COMPOSE				=	${DOCKER_COMPOSE} -f ${COMPOSE_FILE_PATH}

up:	
			${COMPOSE} up -d --build

no_cache:	fclean
			${COMPOSE} build --no-cache

logs:
			${COMPOSE} logs

down:
			${COMPOSE} down

re:			fclean up

clean:
			${COMPOSE} down --rmi all

fclean:
			${COMPOSE} down --rmi all  --volumes
