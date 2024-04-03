@echo off
powershell -Command "Expand-Archive -Path 'python.zip' -DestinationPath 'InteractiveHtmlBom' -Force"
robocopy %~dp0 "%~dp0InteractiveHtmlBom" config.ini
::del python.zip
::del extract_zip.bat
del /q "%~dp0"\*
exit
