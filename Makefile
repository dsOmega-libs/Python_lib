ifneq (,$(wildcard ./.env.dev))
    include .env.dev
    export
endif

build-image:
	docker build . -t ${IMAGE_NAME}

start:
	docker run --name "${CONTAINER_NAME}" --detach --rm "${IMAGE_NAME}"

lint-check:
	docker exec "${CONTAINER_NAME}" pixi run --environment dev lint-check

format-check:
	docker exec "${CONTAINER_NAME}" pixi run --environment dev format-check

types-check:
	docker exec "${CONTAINER_NAME}" pixi run --environment dev types-check

order-imports-check:
	docker exec "${CONTAINER_NAME}" pixi run --environment dev order-imports-check

connect:
	docker run --name ${CONTAINER_NAME} -it ${IMAGE_NAME} --entrypoint /bin/bash

stop:
	docker stop "${CONTAINER_NAME}"

rm-all-containers:
	docker rm $(docker ps --quiet --all)

test:
	pixi run test

# Minimal makefile for Sphinx documentation

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
SPHINXPROJ    = sphinx-intl
SOURCEDIR     = source
BUILDDIR      = build

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

# Also has .env.dev file to avoid triggering sphinx when target `include .env.dev` is run.
.PHONY: help Makefile .env.dev

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
