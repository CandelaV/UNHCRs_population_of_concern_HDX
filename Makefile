export PWD=`pwd`

build:
	docker-compose up -d --build
up:
	docker-compose up -d
down:
	docker-compose down
juopyter:
	docker-compose start jupyter-hdx

# Neo4j commands
clean-neo4j: 
	rm -rf ${PWD}/neo4j/data/databases ${PWD}/neo4j/data/dbms
	rm -f ${PWD}/neo4j/logs/*
	rm -f ${PWD}/neo4j/import/*
load-neo4j-residing: clean-neo4j
	cp ${PWD}/data/processed/neo4j/*residing.csv ${PWD}/neo4j/import/
	docker exec -it neo4j-hdx-container bin/neo4j-import -into data/databases/graphHDX.db --nodes import/countries_nodes_residing.csv --nodes import/countries_residing.csv --relationships import/relationships_residing.csv --relationships import/countries_years_relationship_residing.csv
	docker-compose restart neo4j-hdx
load-neo4j-originating: clean-neo4j
	cp ${PWD}/data/processed/neo4j/*originating.csv ${PWD}/neo4j/import/
	docker exec -it neo4j-hdx-container bin/neo4j-import -into data/databases/graphHDX.db --nodes import/countries_nodes_originating.csv --nodes import/countries_originating.csv --relationships import/relationships_originating.csv --relationships import/countries_years_relationship_originating.csv
	docker-compose restart neo4j-hdx

## Tests Section In progress
clean-test:
	rm -rf ${PWD}/.nbconvert ${PWD}/.hypothesis ${PWD}/.pytest_cache
scripts: clean-test
	find ${PWD}/notebooks -name "*.ipynb" ! -iname "*checkpoint*" -exec jupyter nbconvert --output-dir=${PWD}/.nbconvert/src --to=python --template=custompython.tpl {} \;
	find ${PWD}/tests -name "*.ipynb" ! -iname "*checkpoint*" -exec jupyter nbconvert --output-dir=${PWD}/.nbconvert/tests --to=python --template=custompython.tpl {} \;
	cp ${PWD}/tests/conftest.py ${PWD}/.nbconvert/tests
test: scripts
	py.test ${PWD}/.nbconvert/tests
test-nb:
	py.test --nbval-lax notebooks/data_retrieval_from_hdx.ipynb
##

## Google cloud
install-dk:
	sudo -s # login as superuser
	apt-get update
	apt-get install docker.io -y
install-dk-compose: install-dk
	sudo -s
	apt-get update
	apt-get install python-pip -y
	pip install --upgrade pip
	pip install docker-compose