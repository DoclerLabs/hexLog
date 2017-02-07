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
	override public function onLog( message : LogEvent ) : Void 
	{
		Log.trace(getLayout().toString(message));
	}
	
	public function onClear() : Void 
	{
		#if (flash || js)
		Log.clear();
		#end
	}
}
