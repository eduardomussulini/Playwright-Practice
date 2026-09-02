@echo off
echo Encerrando a API e o Servidor Web...

:: Encerra todas as janelas do Node.js e processos associados
taskkill /F /IM node.exe /T

echo Todos os servicos foram desligados com sucesso!
pause