#!/bin/bash
set -e

# Remove o arquivo PID fantasma do Puma se ele existir
rm -f /gymotivate/tmp/pids/server.pid

# Executa o comando que foi passado pelo Dockerfile (no caso, ligar o servidor)
exec "$@"
