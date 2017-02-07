package hex.log2;
import hex.log2.LogManager.ClassInfo;
import hex.log2.configuration.BasicConfiguration;
import hex.log2.configuration.IConfiguration;

/**
 * ...
 * @author ...
 */
class LoggerContext 
{

	var configuration:IConfiguration = new BasicConfiguration();
	var loggerRegistry:Map<String,ILogger> = new Map<String,ILogger>();
	
	public function new() 
	{
	}
	
	public function getLoggerByClassInfo(classInfo:ClassInfo):ILogger
	{
		return getLogger(classInfo.fqcn);
	}
	
	public function getLogger(name:String):ILogger
	{
		if (!loggerRegistry.exists(name))
		{
			var logger = new Logger(this, name);
			loggerRegistry.set(name, logger);
		}
		return loggerRegistry.get(name);
	}
	
	public function getConfiguration():IConfiguration
	{
		return configuration;
	}
	
}