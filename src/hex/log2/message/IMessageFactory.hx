package hex.log2.message;
import hex.log2.message.IMessage;
/**
 * @author ...
 */

interface IMessageFactory 
{
	
	function newMessage(message:String, ?params:Array<Dynamic>):IMessage;
	
	function newObjectMessage(message:Dynamic):IMessage;
	
}