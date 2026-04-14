@echo off
chcp 65001 >nul
echo ========================================
echo  Обход блокировки Telegram API
echo ========================================
echo.

:: Проверка прав администратора
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ОШИБКА] Требуются права администратора!
    echo Запустите файл правой кнопкой мыши -^> "Запуск от имени администратора"
    pause
    exit /b 1
)

echo [1/3] Создание резервной копии hosts...
copy "%SystemRoot%\System32\drivers\etc\hosts" "%SystemRoot%\System32\drivers\etc\hosts.backup_%date:~-4,4%%date:~-7,2%%date:~-10,2%" >nul

echo [2/3] Добавление записей Telegram в hosts...

:: Удаление старых записей Telegram (если есть)
findstr /v /i "api.telegram.org core.telegram.org" "%SystemRoot%\System32\drivers\etc\hosts" > "%SystemRoot%\System32\drivers\etc\hosts.temp"
move /y "%SystemRoot%\System32\drivers\etc\hosts.temp" "%SystemRoot%\System32\drivers\etc\hosts" >nul

:: Добавление новых записей
echo. >> "%SystemRoot%\System32\drivers\etc\hosts"
echo # Telegram API Unblock >> "%SystemRoot%\System32\drivers\etc\hosts"
echo 149.154.167.220 api.telegram.org >> "%SystemRoot%\System32\drivers\etc\hosts"
echo 149.154.167.220 core.telegram.org >> "%SystemRoot%\System32\drivers\etc\hosts"
echo 149.154.167.220 web.telegram.org >> "%SystemRoot%\System32\drivers\etc\hosts"

echo [3/3] Очистка DNS кэша...
ipconfig /flushdns >nul

echo.
echo [УСПЕШНО] Telegram разблокирован!
echo.
echo Проверка доступности:
ping -n 1 api.telegram.org | findstr "TTL"

echo.
echo ========================================
pause