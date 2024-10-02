# Makefile for WisupAI Python Projects using Conda

.PHONY: help setup test lint format clean run

# Default target
.DEFAULT_GOAL := help

# Configurable variables
CONDA_ENV = base
PYTHON_VERSION = 3.12

# Conda and environment paths
CONDA_ACTIVATE = source $$(conda info --base)/etc/profile.d/conda.sh ; conda activate
CONDA = conda run -n $(CONDA_ENV)

help:
	@echo "Available commands:"
	@echo "  setup    - Set up the Conda environment and install dependencies"
	@echo "  test     - Run tests"
	@echo "  lint     - Run code linting"
	@echo "  format   - Format code"
	@echo "  clean    - Clean up project files"
	@echo "  run      - Run the main program"
	@echo ""
	@echo "Configurable variables:"
	@echo "  CONDA_ENV       - Name of the Conda environment (default: $(CONDA_ENV))"
	@echo "  PYTHON_VERSION  - Python version to use (default: $(PYTHON_VERSION))"

setup:
	conda create -n $(CONDA_ENV) python=$(PYTHON_VERSION) -y
	$(CONDA_ACTIVATE) $(CONDA_ENV) && \
	conda install poetry -c conda-forge -y && \
	poetry install

test:
	$(CONDA) pytest

lint:
	$(CONDA) ruff check .

format:
	$(CONDA) ruff check . --fix

clean:
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete
	rm -rf .pytest_cache
	rm -rf .ruff_cache
	rm -rf dist
	rm -rf build
	rm -rf *.egg-info

run:
	$(CONDA) python src/python_project_template/main.py