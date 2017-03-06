package hex.log.message;

/**
 * ...
 * @author ...
 */
class ParameterizedMessage implements IMessage
{
	var params:Array<Dynamic>;
	var messagePattern:String;
	var formattedMessage:String;

	public function new(messagePattern:String, params:Array<Dynamic>) 
	{
		this.messagePattern = messagePattern;
		this.params = params;
	}
	
	public function getParameters():Array<Dynamic> 
	{
		return params;
	}
	
	public function getFormattedMessage():String 
	{
		if (formattedMessage == null)
		{
			var buffer:StringBuf = new StringBuf();
			ParameterFormatter.formatMessage(buffer, messagePattern, params);
			formattedMessage = buffer.toString();
		}
		return formattedMessage;
	}
	
	public function getFormat():String 
	{
		return messagePattern;
	}
	
}