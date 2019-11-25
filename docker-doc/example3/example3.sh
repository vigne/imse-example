RED='\033[0;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color


# connect to imse1
eval $(docker-machine env imse1)
IP=`docker-machine ip imse1`

echo -e "${GREEN} ==> Deploy stack using docker stack ${NC}"
echo -e "${RED} ==> Press key to show docker-compose.yaml <==${NC}"
read
cat docker-compose.yaml
echo -e "${RED} ==> Press key to deploy <==${NC}"
read
CMD='docker stack deploy -c docker-compose.yaml example'
echo -e "${BLUE} ==> CMD: ${CMD}${NC}"
$CMD
echo -e "${GREEN} ==> Create another docker machine instance called imse2 and join swarm${NC}"
CMD='docker-machine create -d virtualbox imse2'
echo -e "${BLUE} ==> CMD: ${CMD}${NC}"
$CMD

# activating imse2
TOKEN=$(docker swarm join-token worker | grep docker)
eval $(docker-machine env imse2)
echo -e "${GREEN} ==> Build image on imse2${NC}"
CMD='docker build -t imse-example .'
echo -e "${BLUE} ==> CMD: ${CMD}${NC}"
echo -e "${RED} ==> Press key to start <==${NC}"
read
$CMD
echo ''
echo -e "${RED} ==> Press key to continue <==${NC}"
read
echo ''

echo -e "${RED} ==> Join swarm <==${NC}"
echo ${TOKEN}
echo -e "${BLUE} ==> CMD: ${TOKEN} ${NC}"
$TOKEN
echo -e "${GREEN} ==> Scale your app in Portainer ${NC}"
echo -e "${RED} ==> Press key to continue <==${NC}"
read
echo ''
echo -e "${RED} ==> imse2 leaves swarm <==${NC}"
CMD='docker swarm leave'
echo -e "${BLUE} ==> CMD: ${CMD}${NC}"
$CMD

# swicth back to imse1
eval $(docker-machine env imse1)
read
echo ''
echo -e "${RED} ==> imse2 to be removed from swarm completely <==${NC}"
CMD='docker node rm imse2'
echo -e "${BLUE} ==> CMD: ${CMD}${NC}"
$CMD
echo ''
echo -e "${RED} ==> Watch container being migrated <==${NC}"
read
echo ''
echo -e "${RED} ==> Press key to remove deloyment <==${NC}"
read
CMD='docker stack rm example'
echo -e "${BLUE} ==> CMD: ${CMD}${NC}"
$CMD
echo ''
echo -e "${RED} ==> Press key to continue <==${NC}"
read
echo ''
