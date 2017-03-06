package hex.log.message;

/**
 * ...
 * @author ...
 */
class SimpleMessage implements IMessage 
{
	
	var message:String;
	
	public function new(message:String) 
	{
		this.message = message;
	}
	
	public function getFormattedMessage():String 
	{
		return message;
	}
	
	public function getFormat():String 
	{
		return getFormattedMessage();
	}
	
	public function getParameters():Array<Dynamic> 
	{
		return null;
	}
	
}