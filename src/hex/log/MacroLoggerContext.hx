package hex.log;

#if macro
import hex.log.configuration.MacroConfiguration;
import hex.log.message.ExpressionMessageFactory;
import hex.log.message.IMessageFactory;

class MacroLoggerContext extends LoggerContext
{
	
	public function new() 
	{
		super();
		configuration = new MacroConfiguration();
	}
	
	override public function getLogger(name:String, ?messageFactory:IMessageFactory):ILogger 
	{
		name = name == null ? "" : name;
		if (!loggerRegistry.exists(name))
		{
			if (messageFactory == null)
			{
				messageFactory = ExpressionMessageFactory.instance;
			}
			var logger = new Logger(this, name, messageFactory);
			loggerRegistry.set(name, logger);
		}
		return loggerRegistry.get(name);
	}
}

#end