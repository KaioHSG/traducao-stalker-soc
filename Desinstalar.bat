@echo off
title Desinstalar Tradu‡Æo e InGameCC

:installPath
set StalkerPath=.
if not "%StalkerPath%"=="." (goto :checkPath)
for /f "tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\GSC Game World\STALKER-SHOC" /v InstallPath') do (set StalkerPath=%%b)
if not "%StalkerPath%"=="." (goto :checkPath)
for /f "tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\WOW6432Node\GSC Game World\STALKER-SHOC" /v InstallPath') do (set StalkerPath=%%b)
if not "%StalkerPath%"=="." (goto :checkPath)
goto :errNoStalker

:checkPath
if exist "%StalkerPath%\gamedata\scripts\closecaption.script" (goto :chooseUninstall)
if exist "InGameCC_files.lst" (goto :chooseUninstall)
goto :noFileList

:chooseUninstall
cls
echo NOTA: Dependendo do local do jogo, vai ser ness rio executar o script como
echo       administrador.
echo.
choice /c sn  /m "Desinstalar tradu‡Æo"
if %ErrorLevel%==1 (goto :doUninstall)
if %ErrorLevel%==2 (exit)

:doUninstall
cls
echo Desinstalando arquivos...
rd "%StalkerPath%\gamedata" /s /q
del "%StalkerPath%\InGameCC_files.lst" /q
del "%StalkerPath%\InGameCC_v10003.bat" /q
del "%StalkerPath%\InGameCC_v10004.bat" /q
del "%StalkerPath%\InGameCC Leia-me.txt" /q
del "%StalkerPath%\TriboGamer Creditos.txt" /q
del "%StalkerPath%\ReadMe.md" /q
del "%StalkerPath%\Desinstalar.bat" /q
echo.
if exist "%StalkerPath%\gamedata_backup" (
    echo Restaurando "gamedata"...
    xcopy "%StalkerPath%\gamedata_backup" "%StalkerPath%\gamedata\" /e /y
    rd "%StalkerPath%\gamedata_backup" /s /q
    echo.
)
echo ---------------------------------------------------------------
echo.
echo Tradu‡Æo e InGameCC removidos.
echo.
echo Precione qualquer botÆo para sair...
pause > nul
exit

:errNoStalker
cls
echo A pasta do S.T.A.L.K.E.R. nÆo foi encontrada no registro.
echo.
echo NOTA: Vocˆ pode especificar a pasta do jogo editando a linha "set StalkerPath=." no
echo       instalador.
echo.
echo Precione qualquer botÆo para sair...
pause > nul

:noFileList
cls
echo Aquivos do InGameCC nÆo encontados.
echo.
echo NOTA: Vocˆ pode especificar a pasta do jogo editando a linha "set StalkerPath=." no
echo       desinstalador.
echo.
echo Precione qualquer botÆo para sair...
pause > nul
exit