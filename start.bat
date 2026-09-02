@echo off
echo Iniciando o ambiente do projeto...

:: 1. Inicializa o banco de dados
echo Inicializando banco de dados...
cd /d "%~dp0apps\api"
call npm run db:init

:: 2. Sobe a API em uma nova janela de terminal
echo Iniciando a API (Porta 3333)...
start "API Backend (Porta 3333)" cmd /k "cd /d "%~dp0apps\api" && npm run dev"

:: 3. Sobe o Frontend/Web em outra janela de terminal
echo Iniciando o Web Server (Porta 8080)...
start "Web Frontend (Porta 8080)" cmd /k "cd /d "%~dp0apps\web" && npx ws"

echo Tudo pronto! A aplicação estará acessível em http://localhost:8080