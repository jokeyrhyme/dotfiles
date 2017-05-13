.PHONY: test
test:
	bash -n **/*.sh
	zsh -n **/*.sh
	shellcheck **/*.sh
