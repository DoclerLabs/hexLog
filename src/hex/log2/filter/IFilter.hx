package hex.log2.filter;
import haxe.PosInfos;
import hex.log2.LogLevel;
import hex.log2.Logger;
import hex.log2.LogEvent;
import hex.log2.message.IMessage;

enum FilterResult
{
	ACCEPT;
	NEUTRAL;
	DENY;
}

interface IFilter 
{
	function filter(logger:Logger, level:LogLevel, message:Dynamic, params:Array<Dynamic>, ?posInfos:PosInfos):FilterResult;
	function filterEvent(event:LogEvent):FilterResult;
	function filterMessage(logger:Logger, level:LogLevel, message:IMessage, ?posInfos:PosInfos):FilterResult;
	function filterLoggerMessage(logger:Logger, message:IMessage):FilterResult;
}