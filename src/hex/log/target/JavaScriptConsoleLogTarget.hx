package hex.log.target;
import hex.log.LogEvent;
import hex.log.LogLevel;

#if js
import hex.log.target.ILogTarget;
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