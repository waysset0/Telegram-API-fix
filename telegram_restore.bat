@echo off
chcp 65001 >nul
echo ========================================
echo  Восстановление hosts
echo ========================================
echo.

:: Проверка прав администратора
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ОШИБКА] Требуются права администратора!
    pause
    exit /b 1
)

echo Удаление записей Telegram из hosts...
findstr /v /i "api.telegram.org core.telegram.org Telegram API Unblock" "%SystemRoot%\System32\drivers\etc\hosts" > "%SystemRoot%\System32\drivers\etc\hosts.temp"
move /y "%SystemRoot%\System32\drivers\etc\hosts.temp" "%SystemRoot%\System32\drivers\etc\hosts" >nul

echo Очистка DNS кэша...
ipconfig /flushdns >nul

echo.
echo [УСПЕШНО] Изменения отменены!
echo.
pause