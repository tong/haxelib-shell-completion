#!bash
#
# bash/zsh completion support for haxelib
#
__haxelib() {
	local CUR="${COMP_WORDS[COMP_CWORD]}"
	local V=$(head -n 1 $HAXELIB/shell-completion/.current | tr "." ,)
	local BIN="$HAXELIB/shell-completion/$V/run.n"
	COMPREPLY=()
	OPTS=$(neko $BIN $COMP_LINE $COMP_CWORD)
	COMPREPLY=($(compgen -W "$OPTS" -- $CUR))
}
complete -F __haxelib haxelib
