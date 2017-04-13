package hex.log;
import hex.log.ILoggerContext;
import hex.log.ILogger;

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
	
	override function newInstance(context:LoggerContext, name:String, messageFactory:IMessageFactory):Logger 
	{
		if (messageFactory == null)
		{
			messageFactory = ExpressionMessageFactory.instance;
		}
		return super.newInstance(context, name, messageFactory);
	}
}

#end