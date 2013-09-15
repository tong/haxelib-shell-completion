
## haxelib-shell-completion

PROJECT:=shell-completion
SRC=src/*.hx
HX=haxe -cp src

run.n: $(SRC) build.hxml
	haxe build.hxml

$(PROJECT).zip: run.n $(SRC)
	zip -r $@ src/ res/haxelib-completion.sh haxelib.json Makefile README run.n

haxelib: $(PROJECT).zip

install: haxelib
	haxelib install $(PROJECT).zip

uninstall:
	haxelib remove shell-completion

clean:
	rm -f run.n shell-completion.zip

.PHONY: haxelib install uninstall clean
