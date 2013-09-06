#!bash
# Haxelib bash completion
__haxelib(){
	local CUR=${COMP_WORDS[COMP_CWORD]}
	#COMPREPLY=()
	local V=$(head -n 1 $HAXELIB/shell-completion/.current | tr "." ,)
	local BIN=$HAXELIB/shell-completion/$V/run.n
	local OPTS=$(neko $BIN $COMP_LINE $COMP_CWORD)
	COMPREPLY=($(compgen -W "$OPTS" -- $CUR))
}
complete -F __haxelib haxelib
