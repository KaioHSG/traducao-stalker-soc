@ECHO OFF
TITLE Set InGameCC v1.0003

XCOPY "gamedata\config\ui\ui_movies10003.xml" "%TEMP%\" /Y
DEL "gamedata\config\ui\ui_movies.xml"
REN "gamedata\config\ui\ui_movies10003.xml" "ui_movies.xml"
XCOPY "%TEMP%\ui_movies10003.xml" "gamedata\config\ui\" /Y
ECHO.
ECHO ---------------------------------------------------------------
ECHO.
ECHO InGameCC cutscene file set to work with game ver. 1.0003 or older
ECHO.
ECHO NOTE: Depending on the game's location it may be necessary to run this script as an
echo       administrator.
ECHO.
PAUSE
EXIT