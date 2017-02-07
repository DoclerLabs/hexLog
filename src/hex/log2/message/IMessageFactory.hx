package hex.log2.message;
/**
 * @author ...
 */

interface IMessageFactory 
{
	
	function newMessage(message:String, ?params:Array<Dynamic>):IMessage;
	
}