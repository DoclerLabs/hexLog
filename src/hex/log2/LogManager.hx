package hex.log2;

typedef ClassInfo = {
	var fqcn:String;
}

class LogManager 
{

	static var context = new LoggerContext();
	
	public static function getLoggerByClassInfo(classInfo:ClassInfo):ILogger
	{
		return getContextByClassInfo(classInfo).getLoggerByClassInfo(classInfo);
	}
	
	public static function getLogger(?name:String = ""):ILogger
	{
		return getContext(name).getLogger(name);
	}
	
	static function getContextByClassInfo(classInfo:ClassInfo):LoggerContext
	{
		return context;
	}
	
	static function getContext(name:String):LoggerContext
	{
		return context;
	}
	
}