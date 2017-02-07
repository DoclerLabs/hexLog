package hex.log2.message;
import hex.log2.message.IMessage;

/**
 * ...
 * @author ...
 */
class SimpleMessageFactory implements IMessageFactory 
{

	public function new() 
	{
	}
	
	public function newMessage(message:String, ?params:Array<Dynamic>):IMessage
	{
		return new SimpleMessage(message);
	}
	
}