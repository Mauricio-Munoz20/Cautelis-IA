@echo off
chcp 65001 >nul
title Cautelis IA - Live Demo

echo.
echo  ================================================================
echo   Cautelis IA - Demostracion en Vivo
echo   Servidor Unificado (Backend + Frontend) en :8080
echo  ================================================================
echo.

cd /d "%~dp0backend"

set "EXE="
if exist "cautelis-ia-backend.exe" set "EXE=cautelis-ia-backend.exe"
if not defined EXE if exist "cautelisia-backend.exe" set "EXE=cautelisia-backend.exe"
if not defined EXE if exist "shieldguard-backend.exe" set "EXE=shieldguard-backend.exe"

if not defined EXE (
    echo [ERROR] No se encontro el ejecutable en la carpeta backend.
    echo Asegurate de descomprimir todo el archivo ZIP antes de ejecutar.
    echo.
    pause
    exit /b 1
)

echo  Iniciando %EXE% ...
echo  (Presiona Ctrl+C para detener el servidor)
echo.
echo  El navegador se abrira automaticamente en http://localhost:8080 ...
start "" cmd /c "timeout /t 2 /nobreak >nul & start http://localhost:8080"

%EXE%

if %ERRORLEVEL% neq 0 (
    echo.
    echo [AVISO] El servidor se detuvo con codigo de salida %ERRORLEVEL%.
    pause
)
