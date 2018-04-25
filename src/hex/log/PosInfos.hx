package hex.log;

#if remove_pos_infos
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
#else
typedef PosInfos = haxe.PosInfos;
#end