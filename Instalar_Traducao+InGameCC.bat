@ECHO OFF
TITLE Instalar Traducao + InGameCC

:installPath
SET STALKERPATH=.
IF NOT "%STALKERPATH%"=="." GOTO :checkPath
FOR /F "tokens=2*" %%A IN ('reg query "HKLM\SOFTWARE\GSC Game World\STALKER-SHOC" /v InstallPath') DO SET STALKERPATH=%%B
IF NOT "%STALKERPATH%"=="." GOTO :checkPath
FOR /F "tokens=2*" %%A IN ('reg query "HKLM\SOFTWARE\WOW6432Node\GSC Game World\STALKER-SHOC" /v InstallPath') DO SET STALKERPATH=%%B
IF NOT "%STALKERPATH%"=="." GOTO :checkPath
GOTO :errNoStalker

:checkPath
IF NOT EXIST "%STALKERPATH%\bin\XR_3DA.exe" GOTO :errStillNoStalker
IF EXIST "%STALKERPATH%\gamedata\scripts\closecaption.script" GOTO :errCCExists
GOTO :chooseInstall

:chooseInstall
CLS
ECHO S.T.A.L.K.E.R. esta instalado em:
ECHO "%STALKERPATH%"
ECHO.
ECHO NOTA: Dependendo do local do jogo vai ser nessario executar o script como
ECHO       administrador.
ECHO.
CHOICE /c sn  /m "Instalar traducao"
IF %errorLevel%==1 GOTO :doInstall
IF %errorLevel%==2 EXIT
EXIT

:doInstall
CLS
ECHO Instalando arquivos. . .
XCOPY "%STALKERPATH%\gamedata" "%STALKERPATH%\gamedata_backup\" /E /Y
XCOPY "files" "%STALKERPATH%" /E /Y
XCOPY "Desinstalar_Traducao+InGameCC.bat" "%STALKERPATH%" /Y
XCOPY "InGameCC_Leia-me.txt" "%STALKERPATH%" /Y
XCOPY "TriboGamer_Creditos.txt" "%STALKERPATH%" /Y
IF EXIST "%STALKERPATH%\bin\msvcr80.dll" GOTO :version10004
IF NOT EXIST "%STALKERPATH%\bin\msvcr80.dll" GOTO :version10003
EXIT

:version10004
REN "%STALKERPATH%\gamedata\config\ui\ui_movies10004.xml" "ui_movies.xml"
XCOPY "files\gamedata\config\ui\ui_movies10004.xml" "%STALKERPATH%\gamedata\config\ui" /Y
ECHO.
ECHO ---------------------------------------------------------------
ECHO.
ECHO Instalacao finalizada.
ECHO.
ECHO NOTA: As legendas das cenas nao aparecerao nesta versao (1.0004 ou posterior) da
ECHO       engine do jogo.
ECHO.
PAUSE
EXIT

:version10003
REN "%STALKERPATH%\gamedata\config\ui\ui_movies10003.xml" "ui_movies.xml"
XCOPY "files\gamedata\config\ui\ui_movies10003.xml" "%STALKERPATH%\gamedata\config\ui" /Y
ECHO.
ECHO ---------------------------------------------------------------
ECHO.
ECHO Instalacao finalizada.
ECHO.
ECHO NOTA: Se voce atualizar para v1.0004 ou uma versao posterior, lembre-se de
ECHO       reinstalar a traducao ou executar o "InGameCC_v10004.bat".
ECHO.
PAUSE
EXIT

:errNoStalker
CLS
ECHO A pasta do S.T.A.L.K.E.R. nao foi encontrada no registro.
ECHO.
ECHO NOTA: Voce pode especificar a pasta do jogo editando a linha "SET STALKERPATH=." no
ECHO       instalador.
ECHO.
PAUSE
EXIT

:errStillNoStalker
CLS
ECHO O executavel do S.T.A.L.K.E.R. nao pode ser encontrado em:
ECHO.
ECHO "%STALKERPATH%\bin\XR_3DA.exe"
ECHO.
ECHO NOTA: No entanto, a instalacao pode ser feita copiando todos os arquivos da pasta
ECHO       "files" para a pasta do jogo instalado.
ECHO.
ECHO       Se voce usa a versão do jogo 1.0003 ou anterior, deve executar o arquivo em
ECHO       lote chamado "InGameCC_v10003.bat" para permitir que as legendas tambem
ECHO       aparecam nas cenas. Infelizmente v1.0004 e versoes posteriores do jogo nao tem
ECHO       este recurso.
ECHO.
PAUSE
EXIT

:errCCExists
CLS
ECHO Uma vercao do mod InGameCC ja seta instalada.
ECHO.
ECHO NOTA: Remova o mod e tente novamente.
ECHO.
PAUSE
EXIT