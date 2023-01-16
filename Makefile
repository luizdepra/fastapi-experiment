.PHONY: all isort black flake8 mypy test test-cov format run

CMD:=poetry run
SRC:=api
TESTS:=tests

all: flake8 mypy isort black test

isort:
	$(CMD) isort --check $(SRC) $(TESTS)

black:
	$(CMD) black --check $(SRC) $(TESTS)

flake8:
	$(CMD) flake8 $(SRC) $(TESTS)

mypy:
	$(CMD) mypy -m $(SRC)

format:
	$(CMD) isort $(SRC) $(TESTS)
	$(CMD) black $(SRC) $(TESTS)

test:
	$(CMD) pytest --cov=$(SRC) $(TESTS)

test-cov:
	$(CMD) pytest --cov=$(SRC) $(TESTS) --cov-report html

run:
	$(CMD) gunicorn --worker-class uvicorn.workers.UvicornWorker api.main:app
