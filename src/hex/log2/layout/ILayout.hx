package hex.log2.layout;
import hex.log2.LogEvent;

interface ILayout 
{

	function toString(message:LogEvent):String;
	
}