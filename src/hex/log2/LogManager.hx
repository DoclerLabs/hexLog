package hex.log2;
import hex.log2.message.IMessageFactory;

typedef ClassInfo = {
	var fqcn:String;
}

class LogManager 
{

	static public inline var ROOT_LOGGER_NAME:String = "";
	
	static public var context:ILoggerContext = new LoggerContext();
	
	static public function getLoggerByClassInfo(classInfo:ClassInfo, ?messageFactory:IMessageFactory = null):ILogger
	{
		return getContext().getLoggerByClassInfo(classInfo, messageFactory);
	}
	
	static public function getLogger(?name:String = "", ?messageFactory:IMessageFactory = null):ILogger
	{
		return getContext().getLogger(name, messageFactory);
	}
	
	static public function getRootLogger():ILogger
	{
		return getLogger(ROOT_LOGGER_NAME);
	}
	
	static public function getContextByClassInfo(classInfo:ClassInfo):ILoggerContext
	{
		return getContext(classInfo.fqcn);
	}
	
	static public function getContext(?name:String):ILoggerContext
	{
		return context;
	}
	
}