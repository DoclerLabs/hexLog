package hex.log.target;

import haxe.Log;
import haxe.PosInfos;
import hex.log.target.ILogTarget;
import hex.log.LogEvent;

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
}
