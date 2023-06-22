# We will be using docker-compose commands instead of docker commands.
# They apply to every container defined in the YAML file.

VOLUME 	   =   /home/lrandria/data
COMPOSE	   =   docker compose
YAML_FILE  =   srcs/docker-compose.yml 

all:     build up

# build or rebuilds Docker images defined in the YAML file
build:
	     mkdir -p $(VOLUME)/wordpress
	     mkdir -p $(VOLUME)/mariadb
	     $(COMPOSE) -f $(YAML_FILE) build

# start containers in detached mode (-d), meaning it doesn't attach the logs to the console
up:
	     $(COMPOSE) -f $(YAML_FILE) up -d

# stops and removes containers, networks and volumes defined in YAML file
down:
	     $(COMPOSE) -f $(YAML_FILE) down

# start existing containers. Won't rebuild or recreate them.
start:
	     $(COMPOSE) -f $(YAML_FILE) start

# stops running containers without removing them. You use "start" to make them run again.
stop:
	     $(COMPOSE) -f $(YAML_FILE) stop

# to be used on previously stopped containers
restart:
	     stop start

# displays logs
logs:
	     $(COMPOSE) -f $(YAML_FILE) logs

# displays containers statuses
ps:
	     $(COMPOSE) -f $(YAML_FILE) ps

clean:
	     docker system prune -af

fclean:  stop clean
	     sudo rm -rf ${VOLUME}

re:      fclean all

.PHONY:  all build up down logs ps restart stop clean fclean re