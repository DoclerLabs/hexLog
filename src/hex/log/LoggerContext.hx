package hex.log;

import hex.log.configuration.BasicConfiguration;
import hex.log.configuration.IConfiguration;
import hex.log.message.IMessageFactory;

/**
 * ...
 * @author ...
 */
class LoggerContext implements ILoggerContext
{

	var configuration:IConfiguration;
	var loggerRegistry:Map<String,Logger>;
	
	public static function getContext():LoggerContext
	{
		return cast LogManager.getContext();
	}
	
	public function new() 
	{
		configuration = new BasicConfiguration();
		loggerRegistry = new Map<String,Logger>();
	}
	
	public function getLogger(name:String, ?messageFactory:IMessageFactory):ILogger
	{
		name = name == null ? "" : name;
		if (!loggerRegistry.exists(name))
		{
			var logger = newInstance(this, name, messageFactory);
			loggerRegistry.set(name, logger);
		}
		return loggerRegistry.get(name);
	}
	
	public function getConfiguration():IConfiguration
	{
		return configuration;
	}
	
	public function setConfiguration(newConfiguration:IConfiguration):Void
	{
		if (newConfiguration == null)
		{
			return;
		}
		configuration = newConfiguration;
		updateLoggers();
	}
	
	public function updateLoggers():Void 
	{
		for (logger in loggerRegistry)
		{
			logger.updateConfiguration(configuration);
		}
	}
	
	function newInstance(context:LoggerContext, name:String, messageFactory:IMessageFactory):Logger
	{
		return new Logger(context, name, messageFactory);
	}
	
}