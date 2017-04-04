package hex.log.configuration;

#if macro
import hex.log.layout.MacroLogLayout;
import hex.log.target.TraceLogTarget;

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
#end