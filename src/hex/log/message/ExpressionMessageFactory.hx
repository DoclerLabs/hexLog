package hex.log.message;
import hex.log.message.IMessage;

#if macro
class ExpressionMessageFactory implements IMessageFactory 
{

	public static var instance(get, null):IMessageFactory;
	
	static function get_instance():IMessageFactory 
	{
		if (instance == null)
		{
			instance = new ExpressionMessageFactory();
		}
		return instance;
	}
	
	
	public function new() 
	{
	}
	
	public function newMessage(message:String, ?params:Array<Dynamic>):IMessage 
	{
		return new ParameterizedMessage(message, params);
	}
	
	public function newObjectMessage(message:Dynamic):IMessage 
	{
		var isExpr = try 
		{
			switch([Reflect.hasField(message, "expr"), Reflect.hasField(message, "pos")])
			{
				case [true, true]:true;
				case _: false;
			} 
		}
		catch (e:Dynamic) false;
		
		if (isExpr)
		{
			return new ExpressionMessage(message);
		}
		else
		{
			return new ObjectMessage(message);
		}
	}
	
}
#end