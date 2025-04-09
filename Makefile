.PHONY: all install test test-cov pre-commit check fix run

RUN_CMD:=uv run
SRCS:=main.py hypercorn_config.py api
TESTS:=tests

all: install fix test-cov

install:
	uv tool install ruff
	uv tool install pre-commit
	uv tool install mypy
	uv sync --all-extras --dev
	$(RUN_CMD) pre-commit install

pre-commit:
	$(RUN_CMD) pe-commit run --all --verbose

check:
	$(RUN_CMD) ruff check $(SRCS) $(TESTS)
	$(RUN_CMD) ruff format --check $(SRCS) $(TESTS)
	# enable it later $(RUN_CMD) mypy $(SRCS) $(TESTS)

fix:
	$(RUN_CMD) ruff check --fix $(SRCS) $(TESTS)
	$(RUN_CMD) ruff format $(SRCS) $(TESTS)

mypy:
	$(RUN_CMD) mypy -m $(SRCS)

test:
	$(RUN_CMD) pytest --cov=$(SRCS) $(TESTS)

test-cov:
	$(RUN_CMD) pytest --cov=$(SRCS) $(TESTS) --cov-report html

run:
	$(CMRUN_CMDD) ./start_local.sh
