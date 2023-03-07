.PHONY: jupyter install-dependencies create-environment install
.DEFAULT_GOAL := jupyter

# Virtual environment paths
VIRTUAL_ENV_NAME := .venv
TOOLS_FIRST_INSTALLED := $(VIRTUAL_ENV_NAME)/.tools_first_installed

# Directories
ROOT_DIR := $(CURDIR)

install: create-environment $(TOOLS_FIRST_INSTALLED) install-dependencies

$(TOOLS_FIRST_INSTALLED):
	@touch $@

create-environment:
	@pyenv install --skip-existing $(shell cat $(ROOT_DIR)/.python-version)
	@poetry env use -- $(shell pyenv which python)

install-dependencies:
	@poetry install

jupyter: install-ipykernel
	@poetry run jupyter lab

install-ipykernel: $(TOOLS_FIRST_INSTALLED)_ipykernel
$(TOOLS_FIRST_INSTALLED)_ipykernel:
	@poetry run python -m ipykernel install --sys-prefix --name plt-makeovers
	@touch $@