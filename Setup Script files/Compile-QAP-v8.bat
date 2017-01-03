rem Set current directory
C:
CD \Dropbox\AutoHotkey\QuickAccessPopup\Build-v8%QAPBETAPROD%\
rem Check current version file
IF NOT EXIST "QAP-v%QAPVERSIONPREV%.txt" ECHO QAP-v%QAPVERSIONPREV%.txt INTROUVABLE...
IF EXIST "QAP-v%QAPVERSIONFILE%.txt" ECHO MAIS QAP-v%QAPVERSIONFILE%.txt EXISTE - OK!
IF NOT EXIST "QAP-v%QAPVERSIONPREV%.txt" PAUSE
rem Compile exe files
ECHO Ahk2Exe-QAP-v8.ahk 32 %QAPBETAPROD%
"C:\Dropbox\AutoHotkey\QuickAccessPopup\Distribution-files\Ahk2Exe-Custom\Ahk2Exe-QAP-v8.ahk" 32 %QAPBETAPROD%
ECHO Ahk2Exe-QAP-v8.ahk 64 %QAPBETAPROD%
"C:\Dropbox\AutoHotkey\QuickAccessPopup\Distribution-files\Ahk2Exe-Custom\Ahk2Exe-QAP-v8.ahk" 64 %QAPBETAPROD%
rem Compile Setup file
ECHO Inno Setup Compile-QAP-v8.iss
"C:\Program Files (x86)\Inno Setup 5\compil32" /cc "C:\Dropbox\AutoHotkey\QuickAccessPopup\Setup Script files\Compile-QAP-v8.iss"
IF %ERRORLEVEL% NEQ 0 ECHO UNE ERREUR EST SURVENUE...
IF %ERRORLEVEL% NEQ 0 PAUSE
IF %ERRORLEVEL% NEQ 0 EXIT
ECHO Copy quickaccesspopup-setup%QAPBETAPROD%.exe
COPY "C:\temp\InnoSetup-OutputDir\quickaccesspopup-setup%QAPBETAPROD%.exe"
rem Update version file
IF NOT EXIST "QAP-v%QAPVERSIONFILE%.txt" REN "QAP-v%QAPVERSIONPREV%.txt" "QAP-v%QAPVERSIONFILE%.txt"
rem Remove previous version and executable files from zip file
ECHO Remove previous version and executable files from zip file
7z d -bso0 "%QAPZIPFILE%.zip" QAP-v*.txt QuickAccessPopup-??-bit.exe
rem Add new version and executable files to zip file
ECHO Add new version and executable files to zip file
7z a -bso0 "%QAPZIPFILE%.zip" QAP-v%QAPVERSIONFILE%.txt QuickAccessPopup-??-bit.exe
IF %QAPBETAPROD% EQU -beta ECHO Copy %QAPZIPFILE%.zip to %QAPZIPFILEVERSION%.zip
IF EXIST %QAPZIPFILEVERSION%.zip DEL %QAPZIPFILEVERSION%.zip
IF %QAPBETAPROD% EQU -beta COPY %QAPZIPFILE%.zip %QAPZIPFILEVERSION%.zip
ECHO TERMINE DE v%QAPVERSIONPREV% A v%QAPVERSIONFILE% AVEC SUCCES
PAUSE
