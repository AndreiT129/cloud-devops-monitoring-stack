#!/usr/bin/env bash
set -e

echo "Updating package metadata..."
sudo dnf makecache

echo "Installing base tools..."
sudo dnf install -y git curl wget nano vim dnf-plugins-core

echo "Removing conflicting container tools if present..."
sudo dnf remove -y podman buildah docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine || true

echo "Adding Docker repository..."
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

echo "Installing Docker and Compose plugin..."
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Starting and enabling Docker..."
sudo systemctl enable --now docker

echo "Adding current user to docker group..."
sudo usermod -aG docker "$USER" || true

echo
echo "Bootstrap complete."
echo "Log out and back in, or run: newgrp docker"
echo "Then run: ./scripts/deploy.sh"
