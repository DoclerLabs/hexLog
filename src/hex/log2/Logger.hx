package hex.log2;
import hex.log2.LogEvent;
import hex.log2.filter.IFilter;
import haxe.PosInfos;
import hex.log2.LogLevel;
import hex.log2.configuration.IConfiguration;
import hex.log2.filter.IFilter.FilterResult;
import hex.log2.internal.AbstractLogger;
import hex.log2.message.IMessage;
import hex.log2.message.IMessageFactory;
import hex.log2.message.ParameterizedMessageFactory;

/**
 * ...
 * @author ...
 */
class Logger extends AbstractLogger
{
	var privateConfig:PrivateLoggerConfig;
	var name:String;

	public function new(context:LoggerContext, name:String, ?messageFactory:IMessageFactory)
	{
		super((messageFactory == null) ? ParameterizedMessageFactory.instance : messageFactory);
		this.name = name;
		privateConfig = new PrivateLoggerConfig(context.getConfiguration(), this);
	}

	override public function isEnabled(level:LogLevel, message:Dynamic, ?params:Array<Dynamic>, ?posInfos:PosInfos):Bool 
	{
		return privateConfig.filter(level, message, params, posInfos);
	}
	
	override public function isMessageEnabled(level:LogLevel, message:IMessage, ?posInfos:PosInfos):Bool 
	{
		return privateConfig.filterMessage(level, message, posInfos);
	}
	
	override public function logEnabledMessage(level:LogLevel, message:IMessage, ?posInfos:PosInfos):Void 
	{
		privateConfig.logEvent(new LogEvent(message, level, null, posInfos));
	}
	
	override public function getLevel():LogLevel 
	{
		return privateConfig.loggerConfigLevel;
	}
	
	override public function getName():String 
	{
		return name;
	}
	
}

class PrivateLoggerConfig
{
	public var loggerConfigLevel(default, null):LogLevel;
	
	var config:IConfiguration;
	var logger:Logger;
	var loggerConfig:LoggerConfig;
	var intLevel:Int;

	public function new(configuration:IConfiguration, logger:Logger)
	{
		this.logger = logger;
		this.config = configuration;
		this.loggerConfig = configuration.getLoggerConfig(logger.getName());
		this.loggerConfigLevel = loggerConfig.level;
	}

	public function logEvent(event:LogEvent):Void
	{
		loggerConfig.log(event);
	}

	public function filter(level:LogLevel, message:Dynamic, params:Array<Dynamic>, ?posInfos:PosInfos)
	{
		return filterInternal(level, function(filter) {
			return filter.filter(logger, level, message, params, posInfos);
		});
	}
	
	public function filterMessage(level:LogLevel, message:IMessage, ?posInfos:PosInfos)
	{
		return filterInternal(level, function(filter) {
			return filter.filterMessage(logger, level, message, posInfos);
		});
	}
	
	function filterInternal(level:LogLevel, callFilter:IFilter->FilterResult)
	{
		var filter = config.getFilter();
		if (filter != null)
		{
			var r:FilterResult = callFilter(filter);
			if (r != FilterResult.NEUTRAL)
			{
				return r == FilterResult.ACCEPT;
			}
		}
		return level != null && intLevel >= level.value;
	}

}