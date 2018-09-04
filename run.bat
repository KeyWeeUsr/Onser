docker build ^
    --tag keyweeusr/onser:latest ^
    --file Dockerfile ^
    --build-arg www_folder=www ^
    --build-arg nginx_conf=nginx.conf ^
    "%cd%"

if %errorlevel% neq 0 (exit /b 1)
cls

docker volume create --name onser_volume
if %errorlevel% neq 0 (exit /b 1)

docker run ^
    --detach ^
    --interactive ^
    --tty ^
    --volume onser_volume:/home/onser/www ^
    keyweeusr/onser:latest
