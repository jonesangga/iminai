repl:
	rlwrap lua main.lua

doc:
	cmark-gfm -e table imola.md > imola.html

test:
	lua tests/integration/1.lua
