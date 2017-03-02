package hex.log.layout;
import haxe.PosInfos;
import hex.log.LogEvent;

/**
 * ...
 * @author ...
 */
class DefaultJavascriptConsoleLogLayout extends AbstractLayout implements ILayout 
{

	public function toString(message:LogEvent):String 
	{
		//var domain = message.domain == null ? "" : " [" + message.domain.getName() + "]";
		return message.message.getFormattedMessage() + " " + formatPosInfos(message);
	}
	
}