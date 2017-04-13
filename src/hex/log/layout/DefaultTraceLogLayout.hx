package hex.log.layout;
import hex.log.LogEvent;

/**
 * ...
 * @author ...
 */
class DefaultTraceLogLayout implements ILayout
{
	
	public function new() {}
	
	public function toString(message:LogEvent):String 
	{
		return "[" + message.logger.getName() + "] " + message.level + ":" + message.message.getFormattedMessage();
	}
	
}