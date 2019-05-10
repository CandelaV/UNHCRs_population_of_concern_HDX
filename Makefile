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
