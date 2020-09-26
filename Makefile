.NOCACHE: fmt
fmt:
	shfmt -w -s -i 2 **/*.sh **/*.bash **/*.zsh
	if which deno > /dev/null 2>&1; then deno fmt **/*.deno.* ; fi
	if which eslint > /dev/null 2>&1; then eslint --fix . ; fi
	if which prettier > /dev/null 2>&1; then prettier --write '**/*.{css,md,mjs,js}' ; fi

.NOCACHE: test
test:
	bash -n **/*.sh
	if which zsh > /dev/null 2>&1; then zsh -n **/*.sh; fi
	shellcheck -x -e SC2039,SC2086 **/*.sh config/bashrc config/profile
	if which deno > /dev/null 2>&1; then deno fmt --check **/*.deno.* ; fi
	if which deno > /dev/null 2>&1; then deno test **/*.deno.test.* ; fi
	if which eslint > /dev/null 2>&1; then eslint . ; fi
	if which prettier > /dev/null 2>&1; then prettier --check '**/*.{css,md,mjs,js}' ; fi
