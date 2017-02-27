package hex.log2.helper;

import hex.log2.ILogger;
import hex.log2.ILoggerContext;
import hex.log2.LogManager.ClassInfo;
import hex.log2.LoggerContext;
import hex.log2.configuration.BasicConfiguration;
import hex.log2.configuration.IConfiguration;
import hex.log2.helper.TestLogger;
import hex.log2.message.IMessageFactory;


/**
 * ...
 * @author ...
 */
class TestLoggerContext extends LoggerContext
{
	
	override public function getLogger(name:String, ?messageFactory:IMessageFactory):ILogger 
	{
		name = name == null ? "" : name;
		if (!loggerRegistry.exists(name))
		{
			var logger = new TestLogger(this, name, messageFactory);
			loggerRegistry.set(name, logger);
		}
		return loggerRegistry.get(name);
	}
}