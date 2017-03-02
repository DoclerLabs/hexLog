package hex.log.message;
import hex.log.message.IMessage;

/**
 * ...
 * @author ...
 */
class SimpleMessageFactory implements IMessageFactory
{
	
	public static var instance(get, null):IMessageFactory;
	
	static function get_instance():IMessageFactory 
	{
		if (instance == null)
		{
			instance = new SimpleMessageFactory();
		}
		return instance;
	}
	
	public function new() 
	{
	}
	
	public function newMessage(message:String, ?params:Array<Dynamic>):IMessage
	{
		return new SimpleMessage(message);
	}
		
	public function newObjectMessage(message:Dynamic):IMessage
	{
		return new ObjectMessage(message);
	}
	
	
}