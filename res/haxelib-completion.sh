__haxelib(){
	local cur=${COMP_WORDS[COMP_CWORD]}
	#COMPREPLY=()
	local VERSION=$(head -n 1 $HAXELIB/shell-completion/.current | tr "." ,)
	local BIN=$HAXELIB/shell-completion/$VERSION/run.n
	local WORDS=$(neko $BIN $COMP_LINE $COMP_CWORD)
	COMPREPLY=($(compgen -W "$WORDS" -- $cur))
}
complete -F __haxelib haxelib
