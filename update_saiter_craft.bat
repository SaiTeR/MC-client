@echo off

REM --- ��������� ---
SET REPO_URL=https://github.com/SaiTeR/MC-client/archive/refs/heads/main.zip
SET MINECRAFT_DIR=%APPDATA%\.minecraft

REM --- ��������� ����� ��� ���������� ---
SET TEMP_DIR=%TEMP%\minecraft_update
mkdir "%TEMP_DIR%"

echo ��������� ���� � ������� � GitHub...
curl -L -o "%TEMP_DIR%\update.zip" %REPO_URL%

echo ������� ������ ���� � �������...
rmdir /S /Q "%MINECRAFT_DIR%\mods"
rmdir /S /Q "%MINECRAFT_DIR%\config"

echo ������������� �����...
mkdir "%TEMP_DIR%\unzipped"
powershell -Command "Expand-Archive -Path '%TEMP_DIR%\update.zip' -DestinationPath '%TEMP_DIR%\unzipped'"

echo �������� ����� �����...
xcopy /E /Y /I "%TEMP_DIR%\unzipped\MC-client-main\mods" "%MINECRAFT_DIR%\mods"
xcopy /E /Y /I "%TEMP_DIR%\unzipped\MC-client-main\config" "%MINECRAFT_DIR%\config"

echo ������� ��������� ������...
rmdir /S /Q "%TEMP_DIR%"

echo ���������� ������ ���������!
pause
