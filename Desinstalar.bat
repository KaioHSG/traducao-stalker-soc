@set stalkerPath=.

@echo off
set version=1.1
title Desinstalador Tradu‡Æo STALKER SoC v%version%
if not "%stalkerPath%"=="." (goto :checkPath)
for /f "tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\GSC Game World\STALKER-SHOC" /v InstallPath 2^>nul') do (set stalkerPath=%%b)
if not "%stalkerPath%"=="." (goto :checkPath)
for /f "tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\WOW6432Node\GSC Game World\STALKER-SHOC" /v InstallPath 2^>nul') do (set stalkerPath=%%b)
if not "%stalkerPath%"=="." (goto :checkPath)
goto :noStalker

:checkPath
if not exist "%stalkerPath%\gamedata\scripts\closecaption.script" (goto :noFileList)
pushd "%stalkerPath%"
echo Desinstalador Tradu‡Æo STALKER SoC v%version%
echo.
echo O S.T.A.L.K.E.R. est  instalado em: "%stalkerPath%"
echo Dependendo do local do jogo, vai ser ness rio executar o script como administrador.
echo.
choice /c sn  /m "Desinstalar tradu‡Æo"
if %errorLevel%==2 (exit)
echo --------------------------------------------------
echo Deletando arquivos...
rd "gamedata" /s /q
del "InGameCC_files.lst" /q
del "v10003.bat" /q
del "v10004.bat" /q
del "Desinstalar.bat" /q
echo --------------------------------------------------
if exist "gamedata-backup.tar" (
    tar -xf "gamedata-backup.tar"
    del "gamedata-backup.tar" /q
)
echo ##################################################
echo Tradu‡Æo removida.
echo.
echo Precione qualquer tecla para sair...
pause > nul
exit

:noStalker
echo A pasta do S.T.A.L.K.E.R. nÆo foi encontrada no registro.
echo Vocˆ pode especificar a pasta do jogo editando a linha "@set stalkerPath=." no instalador.
echo.
echo Ex.: @set stalkerPath=C:\Pasta do Jogo
echo Precione qualquer tecla para sair...
pause > nul
exit