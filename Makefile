pages   := $(shell find . -type f -name '*.adoc')
web_dir := ./_public

docker_cmd  ?= docker
docker_opts ?= --rm --tty --user "$$(id -u)"

asciidoctor_cmd  ?= $(docker_cmd) run $(docker_opts) --volume "$${PWD}":/documents/ asciidoctor/docker-asciidoctor asciidoctor
asciidoctor_opts ?= --destination-dir=$(web_dir) --attribute stem=latexmath --attribute hide-uri-scheme --attribute source-highlighter=rouge --attribute icons=font --attribute icon-set=fi --attribute numbered --attribute toc --attribute toclevels=2

UNAME := $(shell uname)
ifeq ($(UNAME), Linux)
	OS = linux-x64
	OPEN = xdg-open
endif
ifeq ($(UNAME), Darwin)
	OS = darwin-x64
	OPEN = open
endif

.PHONY: all
all: html open

# This will clean the Antora Artifacts, not the npm artifacts
.PHONY: clean
clean:
	rm -rf $(web_dir)

.PHONY: open
open: $(web_dir)/index.html
	-$(OPEN) $<

.PHONY: html
html:    $(web_dir)/index.html

$(web_dir)/index.html: $(pages)
	$(asciidoctor_cmd) $(asciidoctor_opts) $<
