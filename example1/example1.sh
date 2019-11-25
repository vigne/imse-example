RED='\033[0;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color


echo -e "${GREEN} ==> Create a docker machine instance called imse1 ${NC}"
CMD='docker-machine create -d virtualbox imse1'
echo -e "${BLUE} ==> CMD: ${CMD}${NC}"
$CMD
echo ''
echo -e "${RED} ==> Press key to continue <==${NC}"
read
echo ''

echo -e "${GREEN} ==> List docker machine instances and their status ${NC}"
CMD='docker-machine ls'
echo -e "${BLUE} ==> CMD: ${CMD}${NC}"
$CMD
echo ''
echo -e "${RED} ==> Press key to continue <==${NC}"
read
echo ''


echo -e "${GREEN} ==> Connect local docker daemon on imse1 ${NC}"
CMD='docker ps'
echo -e "${BLUE} ==> CMD: ${CMD}${NC}"
$CMD
read

CMD='docker-machine env imse1'
echo -e "${BLUE} ==> CMD: ${CMD}${NC}"
$CMD
eval $(docker-machine env imse1)
echo -e "${RED} ==> Note: use eval \$(docker-machine env imse1)${NC}"
read

CMD='docker ps'
echo -e "${BLUE} ==> CMD: ${CMD}${NC}"
$CMD
echo ''
echo -e "${RED} ==> Press key to continue <==${NC}"
read
echo ''


IP=`docker-machine ip imse1`
echo -e "${GREEN} ==> Make node swarm master ${NC}"
CMD="docker swarm init --advertise-addr ${IP}"
echo -e "${BLUE} ==> CMD: ${CMD}${NC}"
$CMD
echo -e "${RED} ==> Press key to continue <==${NC}"
read
echo ''


echo -e "${GREEN} ==> Deploy Portainer on imse1 ${NC}"
echo -e "${GREEN} ==> see https://portainer.readthedocs.io for details${NC}"
CMD='curl -L https://downloads.portainer.io/portainer-agent-stack.yml -o portainer-agent-stack.yml'
echo -e "${BLUE} ==> CMD: ${CMD}${NC}"
$CMD
CMD='docker stack deploy --compose-file=portainer-agent-stack.yml portainer'
echo -e "${BLUE} ==> CMD: ${CMD}${NC}"
$CMD
CMD='docker ps'
echo -e "${BLUE} ==> CMD: ${CMD}${NC}"
$CMD
echo -e "${GREEN} ==> see http://${IP}:9000 to finish Portainer setup ${NC}"
echo ''
echo -e "${RED} ==> Press key to continue <==${NC}"
read
echo ''
