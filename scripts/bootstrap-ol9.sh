#!/usr/bin/env bash
set -e

echo "Updating package metadata..."
dnf makecache

echo "Installing base tools..."
dnf install -y git curl wget nano vim dnf-plugins-core

echo "Removing conflicting container tools if present..."
dnf remove -y podman buildah docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine || true

echo "Adding Docker repository..."
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

echo "Installing Docker and Compose plugin..."
dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Starting and enabling Docker..."
systemctl enable --now docker

echo
echo "Bootstrap complete."
echo "Log out and back in, or run: newgrp docker"
echo "Then run: ./scripts/deploy.sh"
