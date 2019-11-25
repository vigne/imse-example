RED='\033[0;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color


# connect to imse1
eval $(docker-machine env imse1)
IP=`docker-machine ip imse1`


echo -e "${GREEN} ==> Build image ${NC}"
CMD='docker build -t imse-example .'
echo -e "${BLUE} ==> CMD: ${CMD}${NC}"
echo -e "${RED} ==> Press key to start <==${NC}"
read
$CMD
echo ''
echo -e "${RED} ==> Press key to continue <==${NC}"
read
echo ''

echo -e "${GREEN} ==> Run the new image: http://${IP}:8081 ${NC}"
CMD='docker run --rm --detach --name example -p 8081:8081 imse-example'
echo -e "${BLUE} ==> CMD: ${CMD}${NC}"
$CMD
echo ''
echo -e "${RED} ==> Press key to continue <==${NC}"
read
CMD='docker stop example'
$CMD


echo -e "${GREEN} ==> Run Redis detached ${NC}"
CMD='docker run --rm --detach --name redis redis'
echo -e "${BLUE} ==> CMD: ${CMD}${NC}"
$CMD
echo -e "${GREEN} ==> Run the image again: http://${IP}:8081 ${NC}"
CMD='docker run --link=redis --rm --detach --name example -p 8081:8081 imse-example'
echo -e "${BLUE} ==> CMD: ${CMD}${NC}"
$CMD
echo ''
echo -e "${RED} ==> Press key to continue <==${NC}"
read
echo ''

echo -e "${GREEN} ==> Cleanup ${NC}"
CMD='docker stop redis example'
echo -e "${BLUE} ==> CMD: ${CMD}${NC}"
$CMD
echo ''
echo -e "${RED} ==> Press key to continue <==${NC}"
read
echo ''


echo -e "${GREEN} ==> Run complete stack using docker stack ${NC}"
echo -e "${RED} ==> Press key to show docker-compose.yaml <==${NC}"
read
cat docker-compose.yaml
echo -e "${RED} ==> Press key to deploy <==${NC}"
read
CMD='docker stack deploy -c docker-compose.yaml example'
echo -e "${BLUE} ==> CMD: ${CMD}${NC}"
$CMD
echo -e "${RED} ==> Press key to continue <==${NC}"
read

echo -e "${GREEN} ==> Cleanup ${NC}"
CMD='docker stack rm example'
echo -e "${BLUE} ==> CMD: ${CMD}${NC}"
$CMD
echo ''
echo -e "${RED} ==> Press key to continue <==${NC}"
read
echo ''
