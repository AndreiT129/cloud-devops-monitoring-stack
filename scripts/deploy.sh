#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "Checking Docker..."
if ! command -v docker &> /dev/null; then
  echo "Docker not found. Install Docker first."
  exit 1
fi

echo "Checking Docker Compose..."
if ! docker compose version &> /dev/null; then
  echo "Docker Compose plugin not found."
  exit 1
fi

echo "Starting stack..."
cd "$PROJECT_ROOT"

docker compose pull
docker compose build
docker compose up -d

echo "Waiting a few seconds for services..."
sleep 5

echo "Containers:"
docker ps

echo "Endpoints:"
echo "App:        http://localhost:5000"
echo "Prometheus: http://localhost:9090"
echo "Grafana:    http://localhost:3000"
echo "Grafana login: admin / admin"
