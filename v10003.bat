@echo off
title Engine v1.0003
xcopy "gamedata\config\ui\ui_movies10003.xml" "%temp%\" /y
del "gamedata\config\ui\ui_movies.xml"
ren "gamedata\config\ui\ui_movies10003.xml" "ui_movies.xml"
xcopy "%temp%\ui_movies10003.xml" "gamedata\config\ui\" /y
echo ##################################################
echo Cenas defindas para versão 1.0003.
echo Dependendo do local do jogo, vai ser necessário executar o script como administrador.
echo.
echo Precione qualquer tecla para sair...
pause > nul
exit