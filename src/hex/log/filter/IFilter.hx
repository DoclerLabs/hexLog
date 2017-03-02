package hex.log.filter;
import haxe.PosInfos;
import hex.log.ILogger;
import hex.log.LogEvent;
import hex.log.LogLevel;
import hex.log.message.IMessage;

enum FilterResult
{
	ACCEPT;
	NEUTRAL;
	DENY;
}

interface IFilter 
{
	function filter(logger:ILogger, level:LogLevel, message:Dynamic, params:Array<Dynamic>, ?posInfos:PosInfos):FilterResult;
	function filterEvent(event:LogEvent):FilterResult;
	function filterMessage(logger:ILogger, level:LogLevel, message:IMessage, ?posInfos:PosInfos):FilterResult;
	function filterLoggerMessage(logger:ILogger, message:IMessage):FilterResult;
}