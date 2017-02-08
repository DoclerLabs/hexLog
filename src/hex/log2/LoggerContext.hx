package hex.log2;
import hex.log2.LogManager.ClassInfo;
import hex.log2.configuration.BasicConfiguration;
import hex.log2.configuration.IConfiguration;
import hex.log2.message.IMessageFactory;

/**
 * ...
 * @author ...
 */
class LoggerContext implements ILoggerContext
{

	var configuration:IConfiguration = new BasicConfiguration();
	var loggerRegistry:Map<String,ILogger> = new Map<String,ILogger>();
	
	public function new() 
	{
	}
	
	public function getLoggerByClassInfo(classInfo:ClassInfo, ?messageFactory:IMessageFactory):ILogger
	{
		if(classInfo == null)
		{
			return getLogger(null, messageFactory);
		}
		else
		{
			return getLogger(classInfo.fqcn, messageFactory);
		}
	}
	
	public function getLogger(name:String, ?messageFactory:IMessageFactory):ILogger
	{
		if (!loggerRegistry.exists(name))
		{
			var logger = new Logger(this, name, messageFactory);
			loggerRegistry.set(name, logger);
		}
		return loggerRegistry.get(name);
	}
	
	public function getConfiguration():IConfiguration
	{
		return configuration;
	}
	
}