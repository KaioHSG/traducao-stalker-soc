@set stalkerPath=.

@echo off
set version=1.1
title Desinstalador Tradu‡Æo STALKER SoC v%version%
if not "%stalkerPath%"=="." (goto :checkPath)
for /f "tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\GSC Game World\STALKER-SHOC" /v InstallPath 2^>nul') do (set stalkerPath=%%b)
if not "%stalkerPath%"=="." (goto :checkPath)
for /f "tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\WOW6432Node\GSC Game World\STALKER-SHOC" /v InstallPath 2^>nul') do (set stalkerPath=%%b)
if not "%stalkerPath%"=="." (goto :checkPath)
goto :errNoStalker

:checkPath
if not exist "%stalkerPath%\gamedata\scripts\closecaption.script" (goto :noFileList)
if not exist "InGameCC_files.lst" (goto :noFileList)
echo Desinstalador Tradu‡Æo STALKER SoC v%version%
echo.
echo O S.T.A.L.K.E.R. est  instalado em: "%stalkerPath%"
echo Dependendo do local do jogo, vai ser ness rio executar o script como administrador.
echo.
choice /c sn  /m "Desinstalar tradu‡Æo"
if %errorLevel%==2 (exit)
echo --------------------------------------------------
echo Deletando arquivos...
rd "%stalkerPath%\gamedata" /s
del "%stalkerPath%\InGameCC_files.lst"
del "%stalkerPath%\v10003.bat"
del "%stalkerPath%\v10004.bat"
del "%stalkerPath%\Desinstalar.bat"
echo --------------------------------------------------

:: Fazer sistema de backup com arquivo ".tar".

if exist "%stalkerPath%\gamedata-backup.tar" (
    echo Restaurando "gamedata"...
    tar
    del "%stalkerPath%\gamedata-backup.tar"
)
echo ##################################################
echo Tradu‡Æo e InGameCC removidos.
echo.
echo Precione qualquer tecla para sair...
pause > nul
exit

:errNoStalker
echo A pasta do S.T.A.L.K.E.R. nÆo foi encontrada no registro.
echo Vocˆ pode especificar a pasta do jogo editando a linha "@set stalkerPath=." no instalador.
echo.
echo Ex.: @set stalkerPath=C:\Pasta do Jogo
echo Precione qualquer tecla para sair...
pause > nul
exit

:noFileList
echo Aquivos do InGameCC nÆo encontados.
echo Vocˆ pode especificar a pasta do jogo editando a linha "@set stalkerPath=." no desinstalador.
echo.
echo Ex.: @set stalkerPath=C:\Pasta do Jogo
echo Precione qualquer tecla para sair...
pause > nul
exit