package hex.log.filter;
import hex.log.message.IMessage;
import hex.log.LogEvent;
import hex.log.LogLevel;
import hex.log.ILogger;
import hex.log.filter.IFilter.FilterResult;

/**
 * ...
 * @author ...
 */
class AbstractFilter implements IFilter 
{
	var onMismatch:FilterResult;
	var onMatch:FilterResult;

	public function new(onMatch:FilterResult, onMismatch:FilterResult)
	{
		this.onMatch = onMatch == null ? FilterResult.NEUTRAL : onMatch;
		this.onMismatch = onMismatch == null ? FilterResult.DENY : onMismatch;
	}
	
	public function filter(logger:ILogger, level:LogLevel, message:Dynamic, params:Array<Dynamic>, ?posInfos:PosInfos):FilterResult 
	{
		return FilterResult.NEUTRAL;
	}
	
	public function filterEvent(event:LogEvent):FilterResult 
	{
		return FilterResult.NEUTRAL;
	}
	
	public function filterMessage(logger:ILogger, level:LogLevel, message:IMessage, ?posInfos:PosInfos):FilterResult 
	{
		return FilterResult.NEUTRAL;
	}
	
	public function filterLoggerMessage(logger:ILogger, message:IMessage):FilterResult 
	{
		return FilterResult.NEUTRAL;
	}
	
}