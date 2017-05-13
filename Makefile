.PHONY: test
test:
	bash -n **/*.sh
	if which zsh > /dev/null 2>&1; then zsh -n **/*.sh; fi
	shellcheck **/*.sh
