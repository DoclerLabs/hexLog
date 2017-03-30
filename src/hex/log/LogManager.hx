package hex.log;
import hex.log.message.IMessageFactory;

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
	
	static public function getLoggerByInstance<T>(target:T, ?messageFactory:IMessageFactory = null):ILogger
	{
		if (target == null)
		{
			return getLogger("", messageFactory);
		}
		var type = Type.getClassName( Type.getClass( target ) );
		return getLogger(type != null ? type : "Dynamic", messageFactory);
	}
	
	static public function getLoggerByClass(clss:Class<Dynamic>, ?messageFactory:IMessageFactory = null):ILogger
	{
		if (clss == null)
		{
			return getLogger("", messageFactory);
		}
		var type = Type.getClassName( clss );
		return getLogger(type != null ? type : "Dynamic", messageFactory);
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