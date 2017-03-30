package hex.log.configuration;
import haxe.Log;
import hex.log.LogEvent;
import hex.log.LogLevel;
import hex.log.layout.ILayout;
import hex.log.target.AbstractLogTarget;
import hex.log.target.TraceLogTarget;

#if macro
class MacroConfiguration extends BasicConfiguration 
{

	public function new() 
	{
		super();
		
		var lc = getRootLogger();
		var traceTarget = new TraceLogTarget("Trace", null, new MacroLogLayout());
		root.level = LogLevel.ALL;
		lc.addLogTarget(traceTarget, LogLevel.ALL, null);
		addLogger(lc.name, lc);
	}
	
}

class MacroLogLayout implements ILayout
{
	
	public function new() 
	{
	}
	
	public function toString(message:LogEvent):String 
	{
		return message.level + " : " + message.message.getFormattedMessage();
	}
}

#end