package hex.log.message;
import hex.log.message.IMessage;
/**
 * @author ...
 */

interface IMessageFactory 
{
	
	function newMessage(message:String, ?params:Array<Dynamic>):IMessage;
	
	function newObjectMessage(message:Dynamic):IMessage;
	
}