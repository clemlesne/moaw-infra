.PHONY: version version-full deploy

version_small ?= $(shell $(MAKE) --silent version)
version_full ?= $(shell $(MAKE) --silent version-full)

version:
	@bash ./version/version.sh -g . -c

version-full:
	@bash ./version/version.sh -g . -c -m

deploy:
	@make -C terraform init plan apply
