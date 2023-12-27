@echo off

REM Set the name of the executable and the output directory
set APP_NAME=TextEditor
set OUT_DIR=dist

REM Create the output directory if it doesn't exist
if not exist %OUT_DIR% mkdir %OUT_DIR%

REM Use PyInstaller to create the executable
pyinstaller --name=%APP_NAME% --windowed --onefile text_editor.py

REM Create the NSIS script for the setup installer
echo ;--------------------------------
echo ; NSIS script for %APP_NAME% setup installer
echo ;--------------------------------
echo Name "%APP_NAME% Setup"
echo OutFile "%OUT_DIR%\%APP_NAME%Setup.exe"
echo InstallDir "$PROGRAMFILES\%APP_NAME%"
echo
echo ; Create the directories
echo Section "Installation"
echo SetOutPath "$INSTDIR"
echo File "dist\%APP_NAME%.exe"
echo SectionEnd
echo
echo ; Add uninstaller
echo Section "Uninstall"
echo Delete "$INSTDIR\%APP_NAME%.exe"
echo RMDir "$INSTDIR"
echo SectionEnd

REM Use NSIS to create the setup installer
makensis setup.nsi

REM Clean up
rd /S /Q build
del *.spec