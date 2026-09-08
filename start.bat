@echo off
setlocal

echo ===============================================
echo  Iniciando o ambiente do projeto...
echo ===============================================

:: -----------------------------------------------------------
:: Node 18.20.8 -> necessario para banco de dados, API e Web
:: -----------------------------------------------------------
echo.
echo [1/4] Selecionando Node 18.20.8 (banco de dados, API e Web)...
call nvm use 18.20.8
if errorlevel 1 (
    echo ERRO: nao foi possivel mudar para o Node 18.20.8.
    echo Verifique se essa versao esta instalada: nvm list
    pause
    exit /b 1
)
node -v

echo.
echo [2/4] Inicializando banco de dados...
cd /d "%~dp0apps\api"
call npm run db:init
if errorlevel 1 (
    echo ERRO: falha ao rodar db:init.
    pause
    exit /b 1
)

echo.
echo [3/4] Iniciando a API (Porta 3333) em Node 18.20.8...
start "API Backend (Porta 3333)" cmd /k "call nvm use 18.20.8 && cd /d "%~dp0apps\api" && npm run dev"

echo Iniciando o Web Server (Porta 8080) em Node 18.20.8...
start "Web Frontend (Porta 8080)" cmd /k "call nvm use 18.20.8 && cd /d "%~dp0apps\web" && npx ws"

:: -----------------------------------------------------------
:: Volta o terminal principal para Node 24.19.0 (Playwright)
:: -----------------------------------------------------------
echo.
echo [4/4] Retornando este terminal para Node 24.19.0 (Playwright)...
call nvm use 24.19.0
if errorlevel 1 (
    echo AVISO: nao foi possivel voltar para o Node 24.19.0.
    echo Verifique se essa versao esta instalada: nvm list
) else (
    node -v
)

echo.
echo ===============================================
echo  Tudo pronto! Acesse: http://localhost:8080
echo  Este terminal ja esta em Node 24.19.0 para o Playwright.
echo ===============================================

endlocal