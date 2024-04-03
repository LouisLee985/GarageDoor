powershell -Command "Expand-Archive -Path 'python.zip' -DestinationPath 'InteractiveHtmlBom' -Force"
robocopy  .\config.ini .\InteractiveHtmlBom
del python.zip
del extract_zip.bat

# robocopy  .\python .\InteractiveHtmlBom /e 
# del python.zip
# rmdir /s/q  python
# del extract_zip.bat
