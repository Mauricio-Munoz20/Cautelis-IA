package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"path/filepath"
	"strings"

	"cautelis-ia-backend/internal/api"
	"cautelis-ia-backend/internal/engine"
	"cautelis-ia-backend/internal/mlclient"
)

func main() {
	port := os.Getenv("CAUTELIS_IA_ADDR")
	if port == "" {
		port = ":8080"
	}
	displayAddress := port
	if strings.HasPrefix(displayAddress, ":") {
		displayAddress = "localhost" + displayAddress
	}

	fmt.Println("================================================================")
	fmt.Println(" Cautelis IA — Motor de Prevención de Autofraude Bancario")
	fmt.Println(" Emprendimiento de Alto Impacto | UCN Coquimbo")
	fmt.Println("================================================================")

	dataPath := os.Getenv("CAUTELIS_IA_DATA")
	if dataPath == "" {
		dataPath = filepath.Join("data", "cautelis-ia-state.json")
	}
	eng, err := engine.NewPersistentEngine(dataPath)
	if err != nil {
		log.Fatalf("Error cargando estado persistente (%s): %v", dataPath, err)
	}
	log.Printf("[+] Estado persistente habilitado en: %s", dataPath)

	mlURL := os.Getenv("CAUTELIS_IA_ML_URL")
	if mlURL != "" {
		eng.SetMLScorer(mlclient.New(mlURL))
		log.Printf("[+] Shadow scoring ML habilitado en: %s", mlURL)
	} else {
		log.Printf("[i] Servicio ML no configurado; se usarán solo reglas locales")
	}
	srv := api.NewServer(eng)
	handler := srv.SetupRoutes()

	fmt.Printf("[+] Servidor unificado escuchando en http://%s\n", displayAddress)
	fmt.Printf("[+] Risk Console (Frontend):    http://%s\n", displayAddress)
	fmt.Printf("[+] API REST:                   http://%s/api/health\n", displayAddress)
	fmt.Printf("[+] WebSocket:                  ws://%s/ws\n", displayAddress)
	fmt.Printf("[+] Simulador Transaccional:    ACTIVO (Modo Continuo)\n")
	fmt.Println("================================================================")

	if err := http.ListenAndServe(port, handler); err != nil {
		log.Fatalf("Error fatal iniciando servidor: %v", err)
	}
}
