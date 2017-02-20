package hex.log2.layout;
import haxe.PosInfos;
import hex.log2.LogEvent;

/**
 * ...
 * @author ...
 */
class DefaultJavascriptConsoleLogLayout extends AbstractLayout implements ILayout 
{

	public function toString(message:LogEvent):String 
	{
		var domain = message.domain == null ? "" : " [" + message.domain.getName() + "]";
		return message.message.getFormattedMessage() + domain + " " + formatPosInfos(message);
	}
	
}