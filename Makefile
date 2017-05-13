.PHONY: test
test:
	bash -n **/*.sh
	if which zsh > /dev/null 2>&1; then zsh -n **/*.sh; fi
	shellcheck -x -e SC2039,SC2086 **/*.sh
