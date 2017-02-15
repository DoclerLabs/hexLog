package hex.log2;
import hex.log2.ILoggerContext;
import hex.log2.LogEvent;
import hex.log2.Logger.PrivateLoggerConfig;
import hex.log2.filter.IFilter;
import haxe.PosInfos;
import hex.log2.LogLevel;
import hex.log2.configuration.IConfiguration;
import hex.log2.filter.IFilter.FilterResult;
import hex.log2.internal.AbstractLogger;
import hex.log2.message.IMessage;
import hex.log2.message.IMessageFactory;
import hex.log2.message.ParameterizedMessageFactory;
import hex.log2.target.ILogTarget;

/**
 * ...
 * @author ...
 */
class Logger extends AbstractLogger
{
	var privateConfig:PrivateLoggerConfig;
	var name:String;
	var context:LoggerContext;

	public function new(context:LoggerContext, name:String, ?messageFactory:IMessageFactory)
	{
		super((messageFactory == null) ? ParameterizedMessageFactory.instance : messageFactory);
		this.context = context;
		this.name = name;
		privateConfig = PrivateLoggerConfig.fromConfiguration(context.getConfiguration(), this);
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
	
	override public function getContext():ILoggerContext 
	{
		return context;
	}
	
	public function addLogTarget(target:ILogTarget):Void
	{
		privateConfig.config.addLoggerLogTarget(this, target);
	}
	
	public function removeLogTarget(target:ILogTarget):Void
	{
		privateConfig.loggerConfig.removeLogTarget(target.getName());
	}
	
	public function updateConfiguration(config:IConfiguration):Void
	{
		privateConfig = PrivateLoggerConfig.fromConfiguration(config, this);
	}
	
	public function setLevel(level:LogLevel):Void
	{
		if (level == getLevel())
		{
			return;
		}
		var actualLevel;
		if (level != null)
		{
			actualLevel = level;
		}
		else
		{
			throw "New level is not set";
		}
		privateConfig = PrivateLoggerConfig.fromPrivateConfig(privateConfig, actualLevel);
	}
}

class PrivateLoggerConfig
{
	public var loggerConfigLevel(default, null):LogLevel;
	public var config(default, null):IConfiguration;
	public var loggerConfig(default, null):LoggerConfig;
	
	var logger:Logger;
	var intLevel:Int;

	public static function fromPrivateConfig(pc:PrivateLoggerConfig, level:LogLevel):PrivateLoggerConfig
	{
		return new PrivateLoggerConfig(pc.config, pc.logger, level);
	}
	
	public static function fromConfiguration(configuration:IConfiguration, logger:Logger):PrivateLoggerConfig
	{
		return new PrivateLoggerConfig(configuration, logger);
	}
	
	public function new(configuration:IConfiguration, logger:Logger, ?level:LogLevel)
	{
		this.logger = logger;
		this.config = configuration;
		this.loggerConfig = configuration.getLoggerConfig(logger.getName());
		this.loggerConfigLevel = level == null ? loggerConfig.level : level;
		intLevel = loggerConfigLevel.value;
	}

	public function logEvent(event:LogEvent):Void
	{
		loggerConfig.log(event);
	}

	public function filter(level:LogLevel, message:Dynamic, params:Array<Dynamic>, ?posInfos:PosInfos):Bool
	{
		return filterInternal(level, function(filter) {
			return filter.filter(logger, level, message, params, posInfos);
		});
	}
	
	public function filterMessage(level:LogLevel, message:IMessage, ?posInfos:PosInfos):Bool
	{
		return filterInternal(level, function(filter) {
			return filter.filterMessage(logger, level, message, posInfos);
		});
	}
	
	function filterInternal(level:LogLevel, callFilter:IFilter->FilterResult):Bool
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