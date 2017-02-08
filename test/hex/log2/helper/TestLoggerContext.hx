package hex.log2.helper;

import hex.log2.ILogger;
import hex.log2.ILoggerContext;
import hex.log2.LogManager.ClassInfo;
import hex.log2.helper.TestLogger;
import hex.log2.message.IMessageFactory;


/**
 * ...
 * @author ...
 */
class TestLoggerContext implements ILoggerContext 
{

	public function new() 
	{
		
	}
	
	public function getLoggerByClassInfo(classInfo:ClassInfo, ?messageFactory:IMessageFactory):ILogger 
	{
		return getLogger(classInfo.fqcn, messageFactory);
	}
	
	public function getLogger(name:String, ?messageFactory:IMessageFactory):ILogger 
	{
		return new TestLogger(name, messageFactory);
	}
	
}