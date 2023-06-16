.PHONY: version version-full deploy

version_small ?= $(shell $(MAKE) --silent version)
version_full ?= $(shell $(MAKE) --silent version-full)

version:
	@bash ./version/version.sh -g . -c

version-full:
	@bash ./version/version.sh -g . -c -m

init:
	terraform init

plan:
	terraform plan \
		-var-file=local.tfvars.json \
		-out=local.tfplan

apply:
	terraform apply \
		local.tfplan
