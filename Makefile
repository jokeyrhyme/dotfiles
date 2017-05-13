.PHONY: test
test:
	bash -n **/*.sh
	which zsh > /dev/null 2>&1 && zsh -n **/*.sh
	shellcheck **/*.sh
