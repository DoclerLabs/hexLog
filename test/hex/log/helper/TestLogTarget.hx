package hex.log.helper;

import hex.log.filter.IFilter;
import hex.log.layout.ILayout;
import hex.log.target.AbstractLogTarget;

class TestLogTarget extends AbstractLogTarget
{
	
	public var messages(default, null):List<LogEvent>;
	
	public function new(name:String, filter:IFilter, layout:ILayout) 
	{
		super(name, filter, layout);
		messages = new List<LogEvent>();
	}
	
	override public function onLog(message:LogEvent):Void 
	{
		messages.add(message);
	}
	
}
