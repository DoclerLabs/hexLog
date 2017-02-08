package hex.log2.message;
import hex.log2.message.IMessage;
import hex.log2.message.ParameterizedMessage;

/**
 * ...
 * @author ...
 */
class ParameterizedMessageFactory extends SimpleMessageFactory
{

	public static var instance(get, null):IMessageFactory;
	
	static function get_instance():IMessageFactory 
	{
		if (instance == null)
		{
			instance = new ParameterizedMessageFactory();
		}
		return instance;
	}
	
	public function new() 
	{
		super();
	}
	
	override public function newMessage(message:String, ?params:Array<Dynamic>):IMessage 
	{
		return new ParameterizedMessage(message, params);
	}
	
}