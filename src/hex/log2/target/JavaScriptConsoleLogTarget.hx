package hex.log2.target;
import hex.log2.LogEvent;
import hex.log2.LogLevel;

#if js
import haxe.PosInfos;
import hex.log2.target.ILogTarget;
import js.Browser;

/**
 * ...
 * @author Francis Bourre
 */
class JavaScriptConsoleLogTarget extends AbstractLogTarget
{
	
	override function logInternal(message:LogEvent):Void 
	{
		var m : haxe.extern.Rest<Dynamic>->Void;
		
		if ( message.level == LogLevel.DEBUG )
		{
			m = Browser.console.debug;
		}
		else if ( message.level == LogLevel.INFO )
		{
			m = Browser.console.info;
		}
		else if ( message.level == LogLevel.WARN )
		{
			m = Browser.console.warn;
		}
		else if ( message.level == LogLevel.FATAL || message.level == LogLevel.ERROR)
		{
			m = Browser.console.error;
				
		}
		else
		{
			m = Browser.console.log;
		}
		
		m(getLayout().toString(message));
	}
	
	public function onClear() : Void 
	{
		Browser.console.clear();
	}
}
#end