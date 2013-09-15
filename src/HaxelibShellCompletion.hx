
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
		switch prev {
		case "config","proxy","register","search","selfupdate","setup","upgrade","user":
			return null;
		case "install":
			return null; //TODO getAvailableLibraries();
		case "dev","git","info","list","path","set","update","remove":
			return getInstalledLibraries();
		case "local","submit":
			var reply = new Array<String>();
			var path = Sys.getCwd();
			for( f in FileSystem.readDirectory( path ) )
				if( f.endsWith('.zip') )
					reply.push( f );
			return reply;
		case "run":
			return getRunableLibraries();
		case _:
			switch words[0] {
			case "run":
				var lib = words[1];
				if( lib != null ) {
					var libPath = getHaxelibLibraryPath( lib );
					var params = words.slice(2);
					var index = cword-2;
					if( libPath != null ) {
						var r = runCompletionModule( '$libPath/run.n', params, index );
						return r;
					}
				}
				return null;
			case _:
				return haxelib_commands;
			}
		}
	}

	static function runCompletionModule( mod : String, params : Array<String>, index : Int ) : Array<String> {
		var l = neko.vm.Loader.local();
		var m = l.loadModule( mod );
		var cl = m.exportsTable().__classes;
		try return cl.ShellCompletion.complete( params, index ) catch(e:Dynamic) {
			return null;
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
		
		if( Sys.systemName() != 'Linux' ) {
			Sys.println( 'Your operating system is not supported yet' );
			Sys.exit( 1 );
		}

		var cwd = Sys.getCwd();
		var script = cwd+'res/haxelib-completion.sh';
		var targetDirectory = '/etc/bash_completion.d';
		var installPath = '$targetDirectory/haxelib';
		var args = Sys.args();
		var cmd = args.shift();
		switch cmd {
		case "haxelib":
			var cword = Std.parseInt( args.pop() )-1;
			var words = haxelib_complete( args, cword );
			if( words != null )
				ShellCompletion.writeWords( words );
		/*
		case "install":
			if( FileSystem.exists( installPath ) )
				FileSystem.deleteFile( installPath );
			try File.copy( script, installPath ) catch(e:Dynamic) {
				Sys.println(e);
				return;
			}
			Sys.println( 'Haxelib shell-completion successfully installed' );
		case "uninstall":
			try FileSystem.deleteFile( installPath ) catch(e:Dynamic) {
				Sys.println(e);
				Sys.exit(1);
			}
		*/
		//case "cache": 
		//case "update":
		//case "custom":
		default:
			Sys.println('???');
		}
	}

}
