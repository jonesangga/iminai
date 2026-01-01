repl:
	rlwrap lua main.lua

doc:
	cmark-gfm -e table docs/imola.md > docs/imola.html

test:
	lua tests/integration/1.lua
