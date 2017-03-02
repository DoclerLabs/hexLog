package hex.log.layout;
import hex.log.LogEvent;

/**
 * ...
 * @author ...
 */
class DefaultTraceLogLayout extends AbstractLayout implements ILayout
{
	
	public function toString(message:LogEvent):String 
	{
		//var domain = message.domain == null ? "" : " [" + message.domain.getName() + "]";
		return ">>> " + message.level + ":" + message.message.getFormattedMessage();//+ " " + formatPosInfos(message);
	}
	
}