build:
	docker build -t rediscluster .
down:
	docker-compose down
up:
	make down
	make build
	docker-compose up -d
monitor:
	docker-compose logs
run-cli:
	docker-compose exec redis-slave-3 redis-cli -c -p 7000