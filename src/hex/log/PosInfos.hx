package hex.log;

#if hex_log_positions
typedef PosInfos = haxe.PosInfos;
#else
abstract PosInfos(Dynamic) {
	public var className(get, never):String;
		inline function get_className() return '';
	public var fileName(get, never):String;
		inline function get_fileName() return '';
	public var methodName(get, never):String;
		inline function get_methodName() return '';
	public var lineNumber(get, never):Int;
		inline function get_lineNumber() return -1;
}
#end