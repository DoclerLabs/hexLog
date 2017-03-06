package hex.log.filter;
import hex.log.message.IMessage;
import hex.log.LogEvent;
import haxe.PosInfos;
import hex.log.LogLevel;
import hex.log.ILogger;
import hex.log.filter.IFilter.FilterResult;

/**
 * ...
 * @author ...
 */
class ThresholdFilter extends AbstractFilter
{
	public var level(default, null):LogLevel;
	
	public function new(level:LogLevel, onMatch:FilterResult, onMismatch:FilterResult) 
	{
		super(onMatch, onMismatch);
		this.level = level;
	}
	
	function filterLevel(testLevel:LogLevel):FilterResult
	{
		return testLevel.isMoreSpecificThan(this.level) ? onMatch : onMismatch;
	}
	
	override public function filter(logger:ILogger, level:LogLevel, message:Dynamic, params:Array<Dynamic>, ?posInfos:PosInfos):FilterResult 
	{
		return filterLevel(level);
	}
	
	override public function filterEvent(event:LogEvent):FilterResult 
	{
		return filterLevel(event.level);
	}
	
	override public function filterLoggerMessage(logger:ILogger, message:IMessage):FilterResult 
	{
		return filterLevel(logger.getLevel());
	}
	
	override public function filterMessage(logger:ILogger, level:LogLevel, message:IMessage, ?posInfos:PosInfos):FilterResult 
	{
		return filterLevel(level);
	}
	
}