package hex.log2.message;

/**
 * ...
 * @author ...
 */
class ParametrizedMessage extends SimpleMessage
{
	var params:Array<Dynamic>;

	public function new(message:String, params:Array<Dynamic>) 
	{
		super(message);
		this.params = params;
		
	}
	
	override public function getParameters():Array<Dynamic> 
	{
		return params;
	}
	
}