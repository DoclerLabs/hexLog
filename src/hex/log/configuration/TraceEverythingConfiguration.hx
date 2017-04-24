package hex.log.configuration;
import hex.log.layout.DefaultTraceLogLayout;
import hex.log.target.TraceLogTarget;

/**
 * ...
 * @author ...
 */
class TraceEverythingConfiguration extends BasicConfiguration 
{

	public function new() 
	{
		super();
		
		var lc = getRootLogger();
		var traceTarget = new TraceLogTarget("Trace", null, new DefaultTraceLogLayout());
		root.level = LogLevel.ALL;
		lc.addLogTarget(traceTarget, LogLevel.ALL, null);
		addLogger(lc.name, lc);
	}
	
}