@echo off
chcp 65001 >nul
title Публікація Є Вода на GitHub
echo.
echo ========================================================
echo   💧 Запуск публікації застосунку "Є Вода" на GitHub
echo ========================================================
echo.
echo Введіть посилання на ваш створений репозиторій на GitHub
echo (Наприклад: https://github.com/vash-login/akva-ukraine.git)
echo або просто ваш нікнейм на GitHub:
echo.
set /p REPO_INPUT="Ваш GitHub нікнейм або посилання: "

if "%REPO_INPUT%"=="" (
    echo [Помилка] Нічого не введено.
    pause
    exit /b
)

echo %REPO_INPUT% | findstr /I "http" >nul
if %errorlevel%==0 (
    set REMOTE_URL=%REPO_INPUT%
) else (
    set REMOTE_URL=https://github.com/%REPO_INPUT%/akva-ukraine.git
)

echo.
echo [1/3] Налаштування віддаленого репозиторію: %REMOTE_URL%
git remote remove origin 2>nul
git remote add origin %REMOTE_URL%

echo [2/3] Підготовка гілки main...
git branch -M main

echo [3/3] Відправка коду на GitHub...
echo Зараз відкриється вікно браузера для підтвердження входу у ваш GitHub акаунт.
echo Просто натисніть "Sign in with your browser" або "Authorize".
echo.
git push -u origin main

if %errorlevel%==0 (
    echo.
    echo ========================================================
    echo   УСПІШНО! Код завантажено на GitHub!
    echo   GitHub Actions уже розпочав збірку вашого APK.
    echo   Зайдіть у вкладку "Actions" у репозиторії та завантажте APK!
    echo ========================================================
) else (
    echo.
    echo [Увага] Якщо репозиторій ще не існує на сайті GitHub,
    echo створіть його за посиланням: https://github.com/new
    echo з назвою: akva-ukraine
)
echo.
pause
