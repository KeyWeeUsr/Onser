docker build \
    --tag onser:latest \
    --file Dockerfile \
    "$(pwd)"

if [ "$?" ]
then
    exit 1
fi
clear

docker volume create --name onser_volume
if [ "$?" ]
then
    exit 1
fi

docker run \
    --detach \
    --interactive \
    --tty \
    --volume onser_volume:/home/onser/www \
    onser:latest
