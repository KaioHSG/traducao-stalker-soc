@set stalkerPath=.

@echo off
set version=1.1
title Inastalador Tradu‡Æo STALKER SoC v%version%
if not "%stalkerPath%"=="." (goto :checkPath)
for /f "tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\GSC Game World\STALKER-SHOC" /v InstallPath 2^>nul') do (set stalkerPath=%%b)
if not "%stalkerPath%"=="." (goto :checkPath)
for /f "tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\WOW6432Node\GSC Game World\STALKER-SHOC" /v InstallPath 2^>nul') do (set stalkerPath=%%b)
if not "%stalkerPath%"=="." (goto :checkPath)
goto :noStalker

:checkPath
if not exist "traducao-stalker-soc-mods.zip" (goto :noFiles)
echo Inastalador Tradu‡Æo STALKER SoC v%version%
echo.
echo O S.T.A.L.K.E.R. est  instalado em: "%stalkerPath%"
echo Dependendo do local do jogo, vai ser necess rio executar o script como administrador.
echo.
choice /c sn  /m "Instalar tradu‡Æo"
if %errorLevel%==2 (exit)
echo --------------------------------------------------
if exist "%stalkerPath%\gamedata" (
    pushd "%stalkerPath%"
    tar -cf "gamedata-backup.tar" "gamedata"
    pushd "%~dp0"
    echo --------------------------------------------------
)
tar -zxvf "traducao-stalker-soc-mods.zip" -C "%stalkerPath%" --strip-components=1 "traducao-stalker-soc-mods/*"
echo --------------------------------------------------
xcopy "Desinstalar.bat" "%stalkerPath%" /y
if not exist "%stalkerPath%\bin\msvcr80.dll" (goto :version10003)
echo ##################################################
echo Instala‡Æo finalizada.
echo As legendas das cenas nÆo aparecerÆo nesta versÆo (1.0004 ou posterior) da engine do jogo.
echo.
echo Precione qualquer tecla para sair...
pause > nul
exit

:version10003
echo --------------------------------------------------
ren "%stalkerPath%\gamedata\config\ui\ui_movies10003.xml" "ui_movies.xml"
echo --------------------------------------------------
xcopy "files\gamedata\config\ui\ui_movies10003.xml" "%stalkerPath%\gamedata\config\ui" /y
echo ##################################################
echo Instala‡Æo finalizada.
echo Se vocˆ atualizar para v1.0004 ou uma versÆo posterior, lembre-se de reinstalar a tradu‡Æo ou executar o "v10004.bat".
echo.
echo Precione qualquer tecla para sair...
pause > nul
exit

:noStalker
echo A pasta do S.T.A.L.K.E.R. nÆo foi encontrada no registro.
echo Mas vocˆ pode especificar a pasta do jogo editando a linha "@set stalkerPath=." no instalador.
echo Ex.: @set stalkerPath=C:\Pasta do Jogo
echo.
echo Precione qualquer tecla para sair...
pause > nul
exit

:noFiles
echo NÆo foi possivel encontrar os arquivos dos mods em: "%cd%\traducao-stalker-soc-mods.zip"
echo Baixe novamenete em: https://github.com/KaioHSG/traducao-stalker-soc/tree/mods
echo.
echo Precione qualquer tecla para sair...
pause > nul
exit