@ECHO OFF
TITLE Desinstalar Teaducao + InGameCC

:checkPath
SET STALKERPATH=.
IF EXIST "%STALKERPATH%\gamedata\scripts\closecaption.script" GOTO :chooseInstall
IF EXIST "InGameCC_files.lst" GOTO :chooseInstall
GOTO :noFileList

:chooseInstall
ECHO NOTA: Dependendo do local do jogo vai ser nessario executar o script como
ECHO       administrador.
ECHO.
CHOICE /c sn  /m "Desinstalar traducao"
IF %errorLevel%==1 GOTO :doUninstall
IF %errorLevel%==2 EXIT
EXIT

:doUninstall
CLS
ECHO Desinstalando arquivos. . .
RD "%STALKERPATH%\gamedata" /S /Q
DEL "%STALKERPATH%\InGameCC_files.lst" /Q
DEL "%STALKERPATH%\InGameCC_v10003.bat" /Q
DEL "%STALKERPATH%\InGameCC_v10004.bat" /Q
DEL "%STALKERPATH%\InGameCC_Leia-me.txt" /Q
DEL "%STALKERPATH%\TriboGamer_Creditos.txt" /Q
ECHO.
ECHO Restaurando "gamedata". . .
XCOPY "%STALKERPATH%\gamedata_backup" "%STALKERPATH%\gamedata\" /E /Y
RD "%STALKERPATH%\gamedata_backup" /S /Q
ECHO.
ECHO ---------------------------------------------------------------
ECHO.
ECHO Traducao e InGameCC removidos.
ECHO.
PAUSE
DEL "%STALKERPATH%\desinstalar.bat" /Q
EXIT

:noFileList
ECHO Aquivos do InGameCC nao encontados.
ECHO.
ECHO NOTA: Voce pode especificar a pasta do jogo editando a linha "SET STALKERPATH=." no
ECHO       desinstalador.
ECHO.
PAUSE
EXIT
