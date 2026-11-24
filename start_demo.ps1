Write-Host "================================================================" -ForegroundColor Cyan
Write-Host " Cautelis IA - Entorno de Demostracion en Vivo" -ForegroundColor White
Write-Host " Golang Backend (:8080) + Angular Risk Console (:4200)" -ForegroundColor Cyan
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host ""

$root = $PSScriptRoot
if (-not $root) { $root = (Get-Location).Path }

Write-Host "[1/2] Iniciando Backend en Go (:8080)..." -ForegroundColor Green
$exe = if (Test-Path "$root\backend\cautelis-ia-backend.exe") {
    ".\cautelis-ia-backend.exe"
} elseif (Test-Path "$root\backend\cautelisia-backend.exe") {
    ".\cautelisia-backend.exe"
} else {
    Write-Error "No se encontro el ejecutable en backend. Compila el backend antes de ejecutar."
    pause
    exit 1
}
Start-Process powershell -WorkingDirectory "$root\backend" -ArgumentList "-NoExit", "-Command", $exe

Start-Sleep -Seconds 2

Write-Host "[2/2] Iniciando Frontend en Angular (:4200)..." -ForegroundColor Green
Start-Process powershell -WorkingDirectory "$root\frontend" -ArgumentList "-NoExit", "-Command", "pnpm start"

Write-Host ""
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host " Todo listo! Abre tu navegador en:" -ForegroundColor Yellow
Write-Host " URL: http://localhost:4200" -ForegroundColor Yellow
Write-Host "================================================================" -ForegroundColor Cyan
