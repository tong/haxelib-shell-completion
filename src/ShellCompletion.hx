
import haxe.io.Bytes;

/*
	COMPREPLY: an array containing possible completions as a result of your function
	COMP_WORDS: an array containing individual command arguments typed so far
	COMP_CWORD: the index of the command argument containing the current cursor position
	COMP_LINE: the current command line
*/
class ShellCompletion {

	public static function output( words : Array<String> ) {
		//Sys.stdout().write( Bytes.ofString( words.join(" ") ) );
		Sys.stdout().writeString( words.join(" ") );
	}
	
	/*
	macro public static function getHaxelibVersion() {
		return macro haxe.Json.parse( File.getContent('haxelib.json') ).version;
	}
	*/

}
