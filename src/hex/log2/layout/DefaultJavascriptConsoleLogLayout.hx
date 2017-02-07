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
		return message.message + "[" + message.domain.getName() + "]" + formatPosInfos(message);
	}
	
}