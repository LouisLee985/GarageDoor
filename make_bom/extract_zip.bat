powershell -Command "Expand-Archive -Path 'python.zip' -DestinationPath 'InteractiveHtmlBom' -Force"
del python.zip
del extract_zip.bat

rem Expand-Archive -Force -Path python.zip -DestinationPath InteractiveHtmlBom