@echo off
setlocal

echo ===============================================
echo  Iniciando o ambiente do projeto...
echo ===============================================

:: -----------------------------------------------------------
:: 1. Node 18.20.8 -> necessario para o banco de dados (db:init)
:: -----------------------------------------------------------
echo.
echo [1/3] Selecionando Node 18.20.8 (banco de dados)...
call nvm use 18.20.8
if errorlevel 1 (
    echo ERRO: nao foi possivel mudar para o Node 18.20.8.
    echo Verifique se essa versao esta instalada: nvm list
    pause
    exit /b 1
)
node -v

echo.
echo [2/3] Inicializando banco de dados...
cd /d "%~dp0apps\api"
call npm run db:init
if errorlevel 1 (
    echo ERRO: falha ao rodar db:init.
    pause
    exit /b 1
)

:: -----------------------------------------------------------
:: 2. Node 24.19.0 -> necessario para rodar API/Web (Playwright)
:: -----------------------------------------------------------
echo.
echo [3/3] Selecionando Node 24.19.0 (API e Web / Playwright)...
call nvm use 24.19.0
if errorlevel 1 (
    echo ERRO: nao foi possivel mudar para o Node 24.19.0.
    echo Verifique se essa versao esta instalada: nvm list
    pause
    exit /b 1
)
node -v

:: A partir daqui, o symlink global do NVM ja aponta pro Node 24.19.0,
:: entao as novas janelas abertas abaixo ja nascem usando essa versao.

echo.
echo Iniciando a API (Porta 3333)...
start "API Backend (Porta 3333)" cmd /k "cd /d "%~dp0apps\api" && npm run dev"

echo Iniciando o Web Server (Porta 8080)...
start "Web Frontend (Porta 8080)" cmd /k "cd /d "%~dp0apps\web" && npx ws"

echo.
echo ===============================================
echo  Tudo pronto! Acesse: http://localhost:8080
echo ===============================================

endlocal