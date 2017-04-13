package hex.log.layout;
import hex.log.LogEvent;

/**
 * ...
 * @author ...
 */
class DefaultJavascriptConsoleLogLayout extends AbstractLayout implements ILayout 
{

	public function toString(message:LogEvent):String 
	{
		return "[" + message.logger.getName() + "] " + message.message.getFormattedMessage() + " " + formatPosInfos(message);
	}
	
}