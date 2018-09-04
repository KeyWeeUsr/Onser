docker build \
    --tag keyweeusr/onser:latest \
    --file Dockerfile \
    --build-arg www_folder=www \
    --build-arg nginx_conf=nginx.conf \
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
    keyweeusr/onser:latest
