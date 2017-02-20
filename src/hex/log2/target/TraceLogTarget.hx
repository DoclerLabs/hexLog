package hex.log2.target;

import haxe.Log;
import haxe.PosInfos;
import hex.log2.target.ILogTarget;
import hex.log2.LogEvent;

/**
 * ...
 * @author Francis Bourre
 */
class TraceLogTarget extends AbstractLogTarget
{
	override function logInternal( message : LogEvent ) : Void 
	{
		Log.trace(getLayout().toString(message), message.posInfos);
	}
	
	public function onClear() : Void 
	{
		#if (flash || js)
		Log.clear();
		#end
	}
}
