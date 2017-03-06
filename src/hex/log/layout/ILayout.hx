package hex.log.layout;
import hex.log.LogEvent;

interface ILayout 
{

	function toString(message:LogEvent):String;
	
}