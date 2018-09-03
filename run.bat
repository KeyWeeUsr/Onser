docker build ^
    --tag onser:latest ^
    --file Dockerfile ^
    "%cd%"

if %errorlevel% neq 0 (exit /b 1)
cls

::    --detach
docker run ^
    --interactive ^
    --tty ^
    onser:latest
