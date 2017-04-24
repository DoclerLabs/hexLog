package hex.log.message;

/**
 * ...
 * @author ...
 */
class ObjectMessage implements IMessage 
{
	var obj:Dynamic;
	var objString:String;

	public function new(obj:Dynamic) 
	{
		this.obj = obj == null ? "null" : obj;		
	}
	
	public function getFormattedMessage():String 
	{
		if (objString == null)
		{
			objString = Std.string(obj); //TODO: make this better
		}
		return objString;
	}
	
	public function getFormat():String 
	{
		return getFormattedMessage();
	}
	
	public function getParameters():Array<Dynamic> 
	{
		return [obj];
	}
	
}