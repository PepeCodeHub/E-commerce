# Makefile for managing the MongoDB Docker setup with docker-compose

# Load environment variables from .env
include .env
export $(shell sed 's/=.*//' .env)

# Default target
.PHONY: up down logs ps

# Start the containers without rebuilding
up:
	@echo "Starting containers..."
	docker-compose up -d

# Stop and remove the containers
down:
	@echo "Stopping and removing containers..."
	docker-compose down

# View logs from containers
logs:
	@echo "Viewing logs..."
	docker-compose logs -f

# Show running containers
ps:
	@echo "Showing running containers..."
	docker-compose ps

# Clean up unused Docker resources (optional)
clean:
	@echo "Cleaning up unused Docker resources..."
	docker system prune -f

# Display help
help:
	@echo "Available commands:"
	@echo "  up          Start MongoDB containers without rebuilding"
	@echo "  down        Stop and remove MongoDB containers"
	@echo "  logs        View logs from running MongoDB containers"
	@echo "  ps          Show running MongoDB containers"
	@echo "  clean       Clean up unused Docker resources"