package hex.log2.message;
import hex.log2.message.IMessage;
import hex.log2.message.ParametrizedMessage;

/**
 * ...
 * @author ...
 */
class ParametrizedMessageFactory implements IMessageFactory 
{

	public function new() 
	{
		
	}
	
	public function newMessage(message:String, ?params:Array<Dynamic>):IMessage 
	{
		return new ParametrizedMessage(message, params);
	}
	
}