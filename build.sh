#!/bin/bash
set -e

echo "==========================================="
echo " Building Custom Planna Docker Image"
echo "==========================================="

echo "1. Stopping any existing containers..."
sudo docker compose down || true

echo "2. Building the custom image 'planna-postiz:latest' (This takes 10-20 mins on first run)..."
sudo docker build -t planna-postiz:latest .

echo "3. Starting the branded container..."
sudo docker compose up -d

echo "==========================================="
echo " Done! The container is booting."
echo " Note: You may see a 502 for ~60 seconds while"
echo " Prisma syncs the database on startup."
echo "==========================================="
