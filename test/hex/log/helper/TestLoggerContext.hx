package hex.log.helper;

import hex.log.ILogger;
import hex.log.LoggerContext;
import hex.log.helper.TestLogger;
import hex.log.message.IMessageFactory;


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