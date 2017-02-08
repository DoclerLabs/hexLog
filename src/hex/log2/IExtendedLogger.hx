package hex.log2;
import haxe.PosInfos;
import hex.log2.LogLevel;
import hex.log2.message.IMessage;
/**
 * @author ...
 */

interface IExtendedLogger extends ILogger
{
	
	function isEnabled(level:LogLevel, message:Dynamic, ?params:Array<Dynamic>, ?posInfos:PosInfos):Bool;
	function isLevelEnabled(level:LogLevel):Bool;
	function isMessageEnabled(level:LogLevel, message:IMessage, ?posInfos:PosInfos):Bool;
	
	function logIfEnabled(level:LogLevel, message:Dynamic, ?params:Array<Dynamic>, ?posInfos:PosInfos):Void;
	function logMessageIfEnabled(level:LogLevel, message:IMessage, ?posInfos:PosInfos):Void;
	
	function logEnabledMessage(level:LogLevel, message:IMessage, ?posInfos:PosInfos):Void;
	
}