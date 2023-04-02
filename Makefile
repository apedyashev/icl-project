# FRONT_END_BINARY=frontApp

## up: starts all containers in the background without forcing build
up:
	@echo "Starting Docker images..."
	docker-compose up -d
	@echo "Docker images started!"

## up_build: stops docker-compose (if running), builds all projects and starts docker compose
up_build: down build_broker build_auth build_posts build_images
	@echo "Stopping docker images (if running...)"
	docker-compose down
	@echo "Building (when required) and starting docker images..."
	docker-compose up --build -d
	@echo "Docker images built and started!"

## down: stop docker compose
down:
	@echo "Stopping docker compose..."
	docker-compose down --remove-orphans
	@echo "Done!"

## build_broker: builds the broker binary as a linux executable
build_broker:
	@echo "Building broker binary..."
	cd ../icl-broker-service &&  make build 
	@echo "Done!"

## build_auth: builds the auth binary as a linux executable
build_auth:
	@echo "Building auth binary..."
	cd ../icl-auth-service && make build
	@echo "Done!"

## build_posts: builds the posts binary as a linux executable
build_posts:
	@echo "Building posts binary..."
	cd ../icl-posts-service && make build
	@echo "Done!"

## build_images: builds the images binary as a linux executable
build_images:
	@echo "Building images binary..."
	cd ../icl-images-service && make build
	@echo "Done!"

## build_front: builds the frone end binary
# build_front:
# 	@echo "Building front end binary..."
# 	cd ../front-end && env CGO_ENABLED=0 go build -o ${FRONT_END_BINARY} ./cmd/web
# 	@echo "Done!"

## start: starts the front end
# start: build_front
# 	@echo "Starting front end"
# 	cd ../front-end && ./${FRONT_END_BINARY} &

## stop: stop the front end
# stop:
# 	@echo "Stopping front end..."
# 	@-pkill -SIGTERM -f "./${FRONT_END_BINARY}"
# 	@echo "Stopped front end!"