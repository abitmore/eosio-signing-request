PATH  := $(PATH):$(PWD)/node_modules/.bin
SHELL := env PATH=$(PATH) /bin/bash
SRC_FILES := $(shell find src -name '*.ts')

lib: ${SRC_FILES} package.json tsconfig.json node_modules rollup.config.js
	@rollup -c && touch lib

.PHONY: test
test: node_modules
	@mocha -r ts-node/register --extension ts test/*.ts --grep '$(grep)'

.PHONY: coverage
coverage: node_modules
	@nyc --reporter=html mocha -r ts-node/register --extension ts test/*.ts -R nyan && open coverage/index.html

.PHONY: lint
lint: node_modules
	@eslint src --ext .ts --fix

.PHONY: ci-test
ci-test: node_modules
	@nyc --reporter=text mocha -r ts-node/register --extension ts test/*.ts -R list

.PHONY: ci-lint
ci-lint: node_modules
	@eslint src --ext .ts --max-warnings 0 --format unix && echo "Ok"

node_modules:
	yarn install --non-interactive --frozen-lockfile --ignore-scripts

.PHONY: clean
clean:
	rm -rf lib/ coverage/

.PHONY: distclean
distclean: clean
	rm -rf node_modules/
