package hex.log2.layout;
import hex.log2.LogEvent;

/**
 * ...
 * @author ...
 */
class DefaultTraceLogLayout extends AbstractLayout implements ILayout
{
	
	public function toString(message:LogEvent):String 
	{
		return ">>> " + message.level + ":" + message.message + " [" + message.domain.getName() + "]" + info + " " + formatPosInfos(message);
	}
	
}