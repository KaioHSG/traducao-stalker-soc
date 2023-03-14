@echo off
title Instalar Tradu‡Æo e InGameCC

:installPath
set StalkerPath=.
if not "%StalkerPath%"=="." (goto :checkPath)
for /f "tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\GSC Game World\STALKER-SHOC" /v InstallPath') do (set StalkerPath=%%b)
if not "%StalkerPath%"=="." (goto :checkPath)
for /f "tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\WOW6432Node\GSC Game World\STALKER-SHOC" /v InstallPath') do (set StalkerPath=%%b)
if not "%StalkerPath%"=="." (goto :checkPath)
goto :errNoStalker

:checkPath
if not exist "%StalkerPath%\bin\XR_3DA.exe" (goto :errStillNoStalker)
if exist "%StalkerPath%\gamedata\scripts\closecaption.script" (goto :errCCExists)
goto :chooseInstall

:chooseInstall
cls
echo O S.T.A.L.K.E.R. est  instalado em:
echo "%StalkerPath%"
echo.
echo NOTA: Dependendo do local do jogo, vai ser ness rio executar o script como
echo       administrador.
echo.
choice /c sn  /m "Instalar tradu‡Æo"
if %ErrorLevel%==1 (goto :doInstall)
if %ErrorLevel%==2 (exit)

:doInstall
cls
if exist "%StalkerPath%\gamedata" (
    echo Fazendo backup...
    xcopy "%StalkerPath%\gamedata" "%StalkerPath%\gamedata_backup\" /E /Y
    echo.
)
echo Instalando arquivos...
xcopy "Arquivos" "%StalkerPath%" /e /y
xcopy "Desinstalar.bat" "%StalkerPath%" /y
xcopy "InGameCC Leia-me.txt" "%StalkerPath%" /y
xcopy "TriboGamer Cr‚ditos.txt" "%StalkerPath%" /y
xcopy "ReadMe.md" "%StalkerPath%" /y
if exist "%StalkerPath%\bin\msvcr80.dll" (goto :version10004) else (goto :version10003)

:version10004
ren "%StalkerPath%\gamedata\config\ui\ui_movies10004.xml" "ui_movies.xml"
xcopy "files\gamedata\config\ui\ui_movies10004.xml" "%StalkerPath%\gamedata\config\ui" /Y
echo.
echo ---------------------------------------------------------------
echo.
echo Instala‡Æo finalizada.
echo.
echo NOTA: As legendas das cenas nÆo aparecerÆo nesta versÆo (1.0004 ou posterior) da
echo       engine do jogo.
echo.
echo Precione qualquer tecla para sair...
pause > nul
exit

:version10003
ren "%StalkerPath%\gamedata\config\ui\ui_movies10003.xml" "ui_movies.xml"
xcopy "files\gamedata\config\ui\ui_movies10003.xml" "%StalkerPath%\gamedata\config\ui" /Y
echo.
echo ---------------------------------------------------------------
echo.
echo Instala‡Æo finalizada.
echo.
echo NOTA: Se vocˆ atualizar para v1.0004 ou uma versÆo posterior, lembre-se de
echo       reinstalar a tradu‡Æo ou executar o "InGameCC_v10004.bat".
echo.
echo Precione qualquer tecla para sair...
pause > nul
exit

:errNoStalker
cls
echo A pasta do S.T.A.L.K.E.R. nÆo foi encontrada no registro.
echo.
echo NOTA: Vocˆ pode especificar a pasta do jogo editando a linha "set StalkerPath=." no
echo       instalador.
echo.
echo Precione qualquer tecla para sair...
pause > nul
exit

:errStillNoStalker
cls
echo O executavel do S.T.A.L.K.E.R. nÆo pode ser encontrado em:
echo.
echo "%StalkerPath%\bin\XR_3DA.exe"
echo.
echo NOTA: No entanto, a instala‡Æo pode ser feita copiando todos os arquivos da pasta
echo       "Arquivos" para a pasta do jogo instalado.
echo.
echo       Se vocˆ usa a versÆo do jogo 1.0003 ou anterior, deve executar o arquivo em
echo       lote chamado "InGameCC_v10003.bat" para permitir que as legendas tamb‚m
echo       apare‡am nas cenas. Infelizmente v1.0004 e versäes posteriores do jogo nÆo tem
echo       este recurso.
echo.
echo Precione qualquer tecla para sair...
pause > nul
exit

:errCCExists
cls
echo Uma versÆo do mod InGameCC j  est  instalada.
echo.
echo NOTA: Remova o mod e tente novamente.
echo.
echo Precione qualquer tecla para sair...
pause > nul
exit