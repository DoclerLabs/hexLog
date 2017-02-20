package hex.log2.helper;

import hex.log2.filter.IFilter;
import hex.log2.layout.ILayout;
import hex.log2.target.AbstractLogTarget;

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
