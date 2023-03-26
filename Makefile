SHELL := /bin/bash
.SILENT:
.DEFAULT_GOAL := help

# Default binary
export SYS_TF_BIN=$(shell which terraform)
export SYS_YC_BIN=$(shell which yc)

# Terraform commands

.PHONY: init
## Initialize terraform
init:
	$(SYS_TF_BIN) init

.PHONY: plan
## Show plan
plan: fmt valid
	$(SYS_TF_BIN) plan

.PHONY: apply
## Apply plan
apply:
	$(SYS_TF_BIN) apply -auto-approve

.PHONY: destroy
## Destroy plan
destroy:
	$(SYS_TF_BIN) destroy

.PHONY: fmt
## Fix formatting
fmt:
	$(SYS_TF_BIN) fmt

.PHONY: valid
## Validate terraform
validate:
	$(SYS_TF_BIN) validate

.PHONY: help
## Show this help message
help:
	@echo "$$(tput bold)Available rules:$$(tput sgr0)"
	@echo
	@sed -n -e "/^## / { \
		h; \
		s/.*//; \
		:doc" \
		-e "H; \
		n; \
		s/^## //; \
		t doc" \
		-e "s/:.*//; \
		G; \
		s/\\n## /---/; \
		s/\\n/ /g; \
		p; \
	}" ${MAKEFILE_LIST} \
	| LC_ALL='C' sort --ignore-case \
	| awk -F '---' \
		-v ncol=$$(tput cols) \
		-v indent=19 \
		-v col_on="$$(tput setaf 6)" \
		-v col_off="$$(tput sgr0)" \
	'{ \
		printf "%s%*s%s ", col_on, -indent, $$1, col_off; \
		n = split($$2, words, " "); \
		line_length = ncol - indent; \
		for (i = 1; i <= n; i++) { \
			line_length -= length(words[i]) + 1; \
			if (line_length <= 0) { \
				line_length = ncol - indent - length(words[i]) - 1; \
				printf "\n%*s ", -indent, " "; \
			} \
			printf "%s ", words[i]; \
		} \
		printf "\n"; \
	}' \
	| more $(shell test $(shell uname) == Darwin && echo '--no-init --raw-control-chars')

