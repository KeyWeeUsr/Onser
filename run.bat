docker build ^
    --tag onser:latest ^
    --file Dockerfile ^
    "%cd%"

if %errorlevel% neq 0 (exit /b 1)
cls

docker run ^
    --detach ^
    --interactive ^
    --tty ^
    onser:latest
