#!/usr/bin/env bash
#set -e
#
#echo "Updating package index..."
#sudo apt update
#
#echo "Installing base tools..."
#sudo apt install -y git curl ca-certificates gnupg
#
#echo "Adding Docker GPG key..."
#sudo install -m 0755 -d /etc/apt/keyrings
#
#if [ ! -f /etc/apt/keyrings/docker.gpg ]; then
#  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
#    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
#    fi
#
#    sudo chmod a+r /etc/apt/keyrings/docker.gpg
#
#    echo "Adding Docker repository..."
#    echo \
#      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
#        $(. /etc/os-release && echo $VERSION_CODENAME) stable" | \
#          sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#
#          echo "Installing Docker and Docker Compose plugin..."
#          sudo apt update
#          sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
#
#          echo "Starting Docker..."
#          sudo systemctl enable --now docker
#
#          echo "Adding current user to docker group..."
#          sudo usermod -aG docker "$USER" || true
#
#          echo
#          echo "Ubuntu bootstrap complete."
#          echo "Run: newgrp docker"
#          echo "Then run: ./scripts/deploy.sh"
