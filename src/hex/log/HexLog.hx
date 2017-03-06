package hex.log;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
#end

/**
 * ...
 * @author ...
 */
class HexLog 
{

	public static macro function getLogger():ExprOf<ILogger>
	{
		return macro ${getLoggerCall()};
	}
	
	public static macro function debug(message:ExprOf<Dynamic>, ?params:ExprOf<Array<Dynamic>>):ExprOf<Void>
	{
		return macro @:pos(message.pos) ${getLoggerCall()}.debug($message, $params);
	}
	
	public static macro function info(message:ExprOf<String>, ?params:ExprOf<Array<Dynamic>>):ExprOf<Void>
	{
		return macro @:pos(message.pos) ${getLoggerCall()}.info($message, $params);
	}
	
	public static macro function warn(message:ExprOf<String>, ?params:ExprOf<Array<Dynamic>>):ExprOf<Void>
	{
		return macro @:pos(message.pos) ${getLoggerCall()}.warn($message, $params);
	}
	
	public static macro function error(message:ExprOf<String>, ?params:ExprOf<Array<Dynamic>>):ExprOf<Void>
	{
		return macro @:pos(message.pos) ${getLoggerCall()}.error($message, $params);
	}
	
	public static macro function fatal(message:ExprOf<String>, ?params:ExprOf<Array<Dynamic>>):ExprOf<Void>
	{
		return macro @:pos(message.pos) ${getLoggerCall()}.fatal($message, $params);
	}
	
	#if macro
	
	static function getLoggerName():String
	{
		var ct = Context.getLocalClass().get();
		return (ct.pack.length > 0 ? ct.pack.join(".") + "." : "") + ct.name;
	}
	
	static function getLoggerCall():Expr
	{
		return macro hex.log.LogManager.getLogger($v{getLoggerName()});
	}
	
	#end
}
