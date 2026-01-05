repl:
	@rlwrap lua main.lua

doc:
	cmark-gfm -e table docs/imola.md > docs/imola.html

test: unit integration

unit:
	lua tests/unit/lexer_test.lua

integration:
	lua tests/integration/1.lua
