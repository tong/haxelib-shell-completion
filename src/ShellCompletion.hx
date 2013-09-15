
import haxe.io.Bytes;

class ShellCompletion {


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


	#if macro

	public static function install(){
		
		if( Sys.systemName() != 'Linux' ) {
			Sys.println( 'Your operating system is not supported' );
			Sys.exit( 1 );
		}

		var installPath = '/etc/bash_completion.d';
		try {
			sys.io.File.copy( 'res/haxelib-completion.sh', '$installPath/haxelib' );
		} catch(e:Dynamic) {
			trace(e);
		}

	}

	#end

}
