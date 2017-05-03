package hex.log.message;

/**
 * ...
 * @author ...
 */
class ParameterFormatter 
{
	
	private static var DELIM_START = '{';
    private static var DELIM_STOP = '}';
	
	static public function formatMessage(buffer:StringBuf, messagePattern:String, params:Array<Dynamic>) 
	{
		if (messagePattern == null || params == null)
		{
			buffer.add(messagePattern);
			return;
		}
		
		var currentArgument = 0;
		var delim = false;
		for (i in 0...messagePattern.length)
		{
			var currChar = messagePattern.charAt(i);
			if (currChar == DELIM_START)
			{
				delim = true;
			}
			if(!delim)
			{
				buffer.add(currChar);
			}
			if (currChar == DELIM_STOP && delim)
			{
				buffer.add(params[currentArgument++] + "");
				delim = false;
			}
		}
	}
}