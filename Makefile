export PWD=`pwd`

build:
	docker-compose up -d --build
up:
	docker-compose up -d
down:
	docker-compose down

clean-test:
	rm -rf ${PWD}/.nbconvert ${PWD}/.hypothesis ${PWD}/.pytest_cache
scripts: clean-test
	find ${PWD}/notebooks -name "*.ipynb" ! -iname "*checkpoint*" -exec jupyter nbconvert --output-dir=${WS_DIR}/.nbconvert/src --to=python --template=custompython.tpl {} \;
	find ${PWD}/tests -name "*.ipynb" ! -iname "*checkpoint*" -exec jupyter nbconvert --output-dir=${WS_DIR}/.nbconvert/tests --to=python --template=custompython.tpl {} \;
test: scripts
	py.test ${PWD}/.nbconvert/tests
lint: scripts
	flake8 ${PWD}/.nbconvert/src

clean-neo4j: 
	rm -rf ${PWD}/neo4j/data/databases ${PWD}/neo4j/data/dbms
	rm -f ${PWD}/neo4j/logs/*
	rm -f ${PWD}/neo4j/import/*
load-neo4j:
	rm -rf neo4j/data/databases/graphHDX.db
	cp ${PWD}/data/processed/neo4j/* ${PWD}/neo4j/import/
	docker exec -it neo4j-hdx-container bin/neo4j-import -into data/databases/graphHDX.db --nodes:Country import/test_countries_residing.csv --relationships:ORIGINATE_FROM ./import/test_residing.csv
	docker-compose restart neo4j-hdx