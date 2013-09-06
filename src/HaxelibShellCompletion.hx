
import sys.FileSystem;
import sys.io.File;

using StringTools;

/*
	Haxelib shell completion
*/
class HaxelibShellCompletion {

	public static var haxelib_path(default,null) = Sys.getEnv("HAXELIB");
	public static var haxelib_commands(default,null) = ["install","list","upgrade","update","selfupdate","remove","set","search","info","user","register","submit","setup","config","path","run","local","dev","git","proxy"];

	public static function haxelib_complete( words : Array<String>, cword : Int ) : Array<String> {
		if( words.length == 0 )
			return haxelib_commands;
		var prev = words[cword-1];
		return switch prev {
		case "config","proxy","register","search","selfupdate","setup","upgrade","user":
			null;
		case "install":
			null; //TODO getAvailableLibraries();
		case "dev","git","info","list","path","set","update","remove":
			getInstalledLibraries();
		case "local","submit":
			var reply = new Array<String>();
			var path = Sys.getCwd();
			for( f in FileSystem.readDirectory( path ) )
				if( f.endsWith('.zip') )
					reply.push( f );
			reply;
		case "run":
			getRunableLibraries();
		case _:
			if( words[0] == 'run' ) {
				var lib = words[1];
				if( lib != null ) {
					//TODO
					var libPath = getHaxelibLibraryPath( lib );
					//Sys.command( 'sh', ['/home/tong/disktree/exp/haxelib-shell-completion/res/hxcpp-completion.sh'].concat( words.slice(2) ) );
					/*
					var libBinPath = '$libPath/shell-complete.n';
					if( FileSystem.exists( libBinPath ) ) {
						//Sys.command( 'neko', [libBinPath].concat( words.slice(2) ) );
						//var l = neko.vm.Loader.local();
						//var m = l.loadModule( libBinPath );
						var classes = m.exportsTable().__classes;
						var i = Type.createInstance( classes.TestShellCompletion, [] );
						trace( i.shell_complete() );
					}
					*/
				}
				null;
			} else
				haxelib_commands;
		}
	}

	static function getInstalledLibraries() : Array<String> {
		var libs = new Array<String>();
		var path = haxelib_path;
		for( lib in FileSystem.readDirectory( path ) ) {
			var p = '$path/$lib';
			if( FileSystem.isDirectory( p ) ) //&& FileSystem.exists( '$p/haxelib.json' ) )
				libs.push( lib );
		}
		return libs;
	}

	static function getRunableLibraries() : Array<String> {
		var libs = new Array<String>();
		var path = haxelib_path;
		for( lib in FileSystem.readDirectory( path ) ) {
			var p = '$path/$lib';
			if( !FileSystem.isDirectory( p ) )
				continue;
			var v = File.getContent( '$p/.current' ).replace('.',',');
			if( FileSystem.exists( '$p/$v/run.n' ) )
				libs.push( lib );
		}
		return libs;
	}

	/*
	static function getAvailableLibraries() : List<{name:String,id:Int}> {
		var siteUrl = "http://" + SERVER.host + ":" + SERVER.port + "/" + SERVER.dir;
		var site = new SiteProxy( haxe.remoting.HttpConnection.urlConnect( siteUrl + "api/" + SERVER.apiVersion + "/" + SERVER.url ).api );
		//var word = param( "Search word" );
		return site.search("");
	}
	*/

	static function getHaxelibLibraryPath( name : String ) : String {
		var path = '$haxelib_path/$name';
		var version = File.getContent( '$path/.current' ).replace( '.', ',' );
		return '$path/$version';
	}

	static function main() {
		var args = Sys.args();
		var cmd = args.shift();
		switch cmd {
		case "haxelib":
			var cword = Std.parseInt( args.pop() )-1;
			var words = haxelib_complete( args, cword );
			if( words != null )
				ShellCompletion.output( words );
		//case "install":
		//case "cache": 
		//case "update":
		}
	}

}
