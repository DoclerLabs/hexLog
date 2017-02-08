package hex.log2;
import hex.log2.message.IMessageFactory;

typedef ClassInfo = {
	var fqcn:String;
}

class LogManager 
{

	static public inline var ROOT_LOGGER_NAME:String = "";
	
	public static var context:ILoggerContext = new LoggerContext();
	
	public static function getLoggerByClassInfo(classInfo:ClassInfo, ?messageFactory:IMessageFactory = null):ILogger
	{
		return getContextByClassInfo(classInfo).getLoggerByClassInfo(classInfo, messageFactory);
	}
	
	public static function getLogger(?name:String = "", ?messageFactory:IMessageFactory = null):ILogger
	{
		return getContext(name).getLogger(name, messageFactory);
	}
	
	static public function getRootLogger():ILogger
	{
		return getLogger(ROOT_LOGGER_NAME);
	}
	
	static function getContextByClassInfo(classInfo:ClassInfo):ILoggerContext
	{
		return context;
	}
	
	static function getContext(name:String):ILoggerContext
	{
		return context;
	}
	
}