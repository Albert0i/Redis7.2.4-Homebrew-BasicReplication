#
# Import and expose environment variables
#
cnf ?= .env
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))

#
# Main
#
.PHONY: help prune config my-ciapp

help:
	@echo
	@echo "Usage: make TARGET"
	@echo
	@echo "Redis Dockerize project automation helper for Windows version 1.5"
	@echo
	@echo "Targets:"
	@echo "	build		build custom image"
	@echo "	up  		start the server"
	@echo "	down 		stop the server"	
	@echo "	ps 		show running containers"
	@echo "	logs		server logs"
	@echo "" 
	@echo "	cmd		start cmd on primary"
	@echo "	cli		start redis-cli on primary"
	@echo "	info		Replication info"
	@echo "	role		Replication role"
	@echo "	config		edit configuration"

#
# build custom image
#
build:
	docker-compose build

#
# start the server
#
up:
	docker-compose up -d --remove-orphans

#
# stop the server
#
down:
	docker-compose down -v

#
# show running containers 
#
ps:
	docker-compose ps

#
# server logs
#
logs:
	docker-compose logs

#
# start cmd on primary
#
cmd:
	docker-compose exec primary cmd

#
# start redis-cli on primary
#
cli:
	docker-compose exec primary redis-cli --user ${AUTH_USER} --pass ${AUTH_PASS} --no-auth-warning

#
# Replication info
#
info:
	docker-compose exec primary redis-cli --user ${AUTH_USER} --pass ${AUTH_PASS} --no-auth-warning info replication

#
# Replication role
#
role:
	docker-compose exec primary redis-cli --user ${AUTH_USER} --pass ${AUTH_PASS} --no-auth-warning role 

#
# edit configuration
#
config:
	nano .env

#
# EOF (2024/07/03)
#
