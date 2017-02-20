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
		
		if ( message.level.value == LogLevel.DEBUG.value )
		{
			m = Browser.console.debug;
		}
		else if ( message.level.value == LogLevel.INFO.value )
		{
			m = Browser.console.info;
		}
		else if ( message.level.value == LogLevel.WARN.value )
		{
			m = Browser.console.warn;
		}
		else if ( message.level.value == LogLevel.FATAL.value || message.level.value == LogLevel.ERROR.value)
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