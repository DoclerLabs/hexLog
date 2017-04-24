package hex.log.layout;

#if macro
import hex.log.LogEvent;
import hex.log.message.ExpressionMessage;

class MacroLogLayout implements ILayout 
{

	public function new() 
	{
	}
	
	public function toString(message:LogEvent):String 
	{
		if (Std.is(message.message, ExpressionMessage))
		{
			return message.message.getFormattedMessage();
		}
		else
		{
			return message.level + " : " + message.message.getFormattedMessage();
		}
	}
}
#end