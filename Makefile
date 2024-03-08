docker-compose:
	make docker-compose-down
	docker compose -f docker-compose.yml up

docker-compose-build:
	make docker-compose-down
	docker compose -f docker-compose.yml up --build

docker-compose-down:
	docker stop postgres-15 || exit 0
	docker stop postgres-11 || exit 0
	docker stop postgres || exit 0
	docker compose down || exit 0
