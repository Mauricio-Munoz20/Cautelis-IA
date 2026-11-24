#!/usr/bin/env bash
echo "================================================================"
echo " Cautelis IA — Entorno de Demostracion en Vivo (Bash)"
echo " Golang Backend (:8080) + Angular Risk Console (:4200)"
echo "================================================================"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "[1/2] Iniciando Backend en Go (:8080)..."
if [ -f "$DIR/backend/cautelis-ia-backend.exe" ]; then
    cmd.exe /c start cmd /k "cd /d $DIR\\backend && cautelis-ia-backend.exe"
else
    echo "No se encontro backend/cautelis-ia-backend.exe. Compila el backend antes de ejecutar la demo."
    exit 1
fi

sleep 2

echo "[2/2] Iniciando Frontend en Angular (:4200)..."
cmd.exe /c start cmd /k "cd /d $DIR\\frontend && pnpm start"

echo ""
echo "================================================================"
echo " Todo listo! Abre tu navegador en: http://localhost:4200"
echo "================================================================"
