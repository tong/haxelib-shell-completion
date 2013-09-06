
import haxe.io.Bytes;

/*
*/
class ShellCompletion {

	/***/
	public static inline var LIB_NEKO = "completion.n";

	//function new() {}
	//public function create() : Array<String> {

	public static inline function writeWords( words : Array<String> ) {
		write( words.join(" ") );
	}

	public static inline function write( s : String ) {
		Sys.stdout().writeString( s );
	}
	
	/*
	macro public static function getHaxelibVersion() {
		return macro haxe.Json.parse( File.getContent('haxelib.json') ).version;
	}
	*/

}
