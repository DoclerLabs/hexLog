package hex.log;
import hex.log.message.IMessageFactory;

typedef ClassInfo = {
	var fqcn:String;
}

class LogManager 
{

	static public inline var ROOT_LOGGER_NAME:String = "";
	
	static public var context:ILoggerContext = new LoggerContext();
	
	static public function getLoggerByInstance(target:{}, ?messageFactory:IMessageFactory = null):ILogger
	{
		return getLoggerByClass(Type.getClass(target), messageFactory);
	}
	
	static public function getLoggerByClass(clss:Class<Dynamic>, ?messageFactory:IMessageFactory = null):ILogger
	{
		return clss != null ? getLogger(Type.getClassName(clss), messageFactory) : getLogger('', messageFactory);
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
		if (context == null)
		{
			context = new LoggerContext();
		}
		return context;
	}
	
}