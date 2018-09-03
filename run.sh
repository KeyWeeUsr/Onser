docker build \
    --tag onser:latest \
    --file Dockerfile \
    "$(pwd)"

if [ "$?" ]
then
    exit 1
fi
clear

docker run \
    --detach \
    --interactive \
    --tty \
    onser:latest
