.PHONY: all install test test-cov pre-commit check fix run

CMD:=poetry run
SRCS:=main.py hypercorn_config.py api
TESTS:=tests

all: install fix test-cov

install:
	poetry install --no-root
	$(CMD) pre-commit install

pre-commit:
	$(CMD) pe-commit run --all --verbose

check:
	$(CMD) ruff check $(SRCS) $(TESTS)
	$(CMD) ruff format --check $(SRCS) $(TESTS)
	$(CMD) mypy $(SRCS) $(TESTS)

fix:
	$(CMD) ruff check --fix $(SRCS) $(TESTS)
	$(CMD) ruff format $(SRCS) $(TESTS)

mypy:
	$(CMD) mypy -m $(SRCS)

test:
	$(CMD) pytest --cov=$(SRCS) $(TESTS)

test-cov:
	$(CMD) pytest --cov=$(SRCS) $(TESTS) --cov-report html

run:
	$(CMD) ./start_local.sh
