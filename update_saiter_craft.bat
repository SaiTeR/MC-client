@echo off
REM --- Настройки ---
SET REPO_URL=https://github.com/SaiTeR/MC-client/archive/refs/heads/main.zip
SET MINECRAFT_DIR=%APPDATA%\Roaming\.minecraft

REM --- Временная папка для скачивания ---
SET TEMP_DIR=%TEMP%\minecraft_update

echo Загружаем моды и конфиги с GitHub...
curl -L -o "%TEMP_DIR%\update.zip" %REPO_URL%

echo Удаляем старые моды и конфиги...
rmdir /S /Q "%MINECRAFT_DIR%\mods"
rmdir /S /Q "%MINECRAFT_DIR%\config"

echo Распаковываем архив...
mkdir "%TEMP_DIR%\unzipped"
powershell -Command "Expand-Archive -Path '%TEMP_DIR%\update.zip' -DestinationPath '%TEMP_DIR%\unzipped'"

echo Копируем новые файлы...
xcopy /E /Y "%TEMP_DIR%\unzipped\REPOSITORY-main\mods" "%MINECRAFT_DIR%\mods"
xcopy /E /Y "%TEMP_DIR%\unzipped\REPOSITORY-main\config" "%MINECRAFT_DIR%\config"

echo Очистка временных файлов...
rmdir /S /Q "%TEMP_DIR%"

echo Обновление завершено!
pause
