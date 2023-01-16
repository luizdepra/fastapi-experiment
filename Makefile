.PHONY: all  format isort black lint type test test-cov run build

CMD:=poetry run
SRC:=api
TESTS:=tests

all: lint format test build

format: isort black

isort:
	$(CMD) isort $(SRC) $(TESTS)

black:
	$(CMD) black $(SRC) $(TESTS)

lint: flake8 type

flake8:
	$(CMD) flake8 $(SRC) $(TESTS)

type:
	$(CMD) mypy $(SRC) $(TESTS)

test:
	$(CMD) pytest --cov=$(SRC) $(TESTS)

test-cov:
	$(CMD) pytest --cov=$(SRC) $(TESTS) --cov-report html

run:
	$(CMD) gunicorn --worker-class uvicorn.workers.UvicornWorker api.main:app
