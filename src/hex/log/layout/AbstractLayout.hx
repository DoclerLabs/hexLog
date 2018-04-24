package hex.log.layout;
import hex.log.LogEvent;

/**
 * ...
 * @author ...
 */
class AbstractLayout
{

	public function new() 
	{
	}
	
	function formatPosInfos(message:LogEvent):String
	{
		var posInfos : PosInfos = message.posInfos;
		var info:String = posInfos != null ? " at " + posInfos.className + "::" + posInfos.methodName + " line " + posInfos.lineNumber + " in file " + posInfos.fileName : "";
		return info;
	}
	
}