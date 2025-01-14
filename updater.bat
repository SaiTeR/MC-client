@echo off

echo SaiterCraft updater v 1.33.7
echo (c) Saiter Holdings Corp.
echo -----------------------------


SET REPO_URL=https://github.com/SaiTeR/MC-client/archive/refs/heads/main.zip
SET MINECRAFT_DIR=%APPDATA%\.minecraft

SET TEMP_DIR=%TEMP%\minecraft_update
mkdir "%TEMP_DIR%"

echo Downloading MODS and CONFIG form GitHub...
curl -L -o "%TEMP_DIR%\update.zip" %REPO_URL%

echo Deleting old files...
rmdir /S /Q "%MINECRAFT_DIR%\mods"
rmdir /S /Q "%MINECRAFT_DIR%\config"

echo Uzipping archive...
mkdir "%TEMP_DIR%\unzipped"
powershell -Command "Expand-Archive -Path '%TEMP_DIR%\update.zip' -DestinationPath '%TEMP_DIR%\unzipped'"

echo Copying MODS and CONFIG...
xcopy /E /Y /I "%TEMP_DIR%\unzipped\MC-client-main\mods" "%MINECRAFT_DIR%\mods"
xcopy /E /Y /I "%TEMP_DIR%\unzipped\MC-client-main\config" "%MINECRAFT_DIR%\config"

echo Deleting temp files...
rmdir /S /Q "%TEMP_DIR%"

echo Update complete!
pause
