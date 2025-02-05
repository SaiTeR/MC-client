@echo off
chcp 65001 > nul
echo #########################
echo #  MC-updater v1.33.7   #
echo #         by            #
echo # Saiter Holdings Corp. #
echo #########################

echo.
echo Добро пожаловать в АПДЕЙТЕР сборки от Саитера!

if exist "%APPDATA%\.minecraft\version" (
    for /f "delims=" %%A in (%APPDATA%\.minecraft\version) do set LOCAL_VERSION=%%A
) else (
    set LOCAL_VERSION=Не указано. Определиться автоматически после первого выполнения апдейтера!
)

for /f "delims=" %%A in ('curl -s https://raw.githubusercontent.com/SaiTeR/MC-client/main/version') do set GIT_VERSION=%%A
echo Версия сборки:
echo - Текущая: [33m%LOCAL_VERSION%[0m
echo - Актуальная : [32m%GIT_VERSION%[0m

echo.
echo [32mНажмите любую клавишу или че хотите вообще сделайте для запуска процесса обновления. 
pause

SET REPO_URL=https://github.com/SaiTeR/MC-client/archive/refs/heads/main.zip
SET MINECRAFT_DIR=%APPDATA%\.minecraft
SET TEMP_DIR=%TEMP%\minecraft_update

echo.
echo [0mСоздаем папку для временных файлов...
mkdir "%TEMP_DIR%"

echo.
echo Скачивание файлов сборки, дождитесь завершения... ЕСЛИ ВАШ ИНТЕРНЕТ ГОВНО, ТО ЭТО БУДЕТ ДОЛГО...
curl -L -C - -o "%TEMP_DIR%\update.zip" %REPO_URL%

echo Удаление старых файлов сборки...
rmdir /S /Q "%MINECRAFT_DIR%\mods"
rmdir /S /Q "%MINECRAFT_DIR%\config"

echo Распаковка архива обновления...
mkdir "%TEMP_DIR%\unzipped"
powershell -Command "Expand-Archive -Path '%TEMP_DIR%\update.zip' -DestinationPath '%TEMP_DIR%\unzipped'"

echo Копирование MODS и CONFIG...
xcopy /E /Y /I "%TEMP_DIR%\unzipped\MC-client-main\mods" "%MINECRAFT_DIR%\mods"
xcopy /E /Y /I "%TEMP_DIR%\unzipped\MC-client-main\config" "%MINECRAFT_DIR%\config"
xcopy /E /Y /I "%TEMP_DIR%\unzipped\MC-client-main\version" "%MINECRAFT_DIR%\version"

echo Удаление временных файлов...
rmdir /S /Q "%TEMP_DIR%"

echo [32mОБНОВЛЕНИЕ СБОРКИ ЗАВЕРШЕНО! ДАННОЕ ОКНО МОЖНО ЗАКРЫТЬ.
pause
