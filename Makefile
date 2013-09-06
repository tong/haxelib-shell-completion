
## haxelib-shell-completion

SRC=src/*.hx

run.n: $(SRC) build.hxml
	haxe build.hxml

shell-completion.zip: run.n $(SRC) res/*
	zip -r $@ haxelib.json Makefile README run.n

haxelib: shell-completion.zip

install-haxelib: haxelib
	haxelib install shell-completion.zip

uninstall-haxelib:
	haxelib remove shell-completion

clean:
	rm -f run.n shell-completion.zip

.PHONY: haxelib install-haxelib uninstall-haxelib clean
