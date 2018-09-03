docker build ^
    --tag onser:latest ^
    --file Dockerfile ^
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
    onser:latest
