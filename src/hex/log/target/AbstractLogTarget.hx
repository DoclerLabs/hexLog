package hex.log.target;
import hex.log.LogEvent;
import hex.log.filter.AbstractFilterable;
import hex.log.filter.IFilter;
import hex.log.layout.ILayout;

/**
 * ...
 * @author ...
 */
class AbstractLogTarget extends AbstractFilterable implements ILogTarget
{
	var layout:ILayout;
	var name:String;

	public function new(name:String, filter:IFilter, layout:ILayout) 
	{
		super(filter);
		this.name = name;
		this.layout = layout;
	}
	
	public function onLog(message:LogEvent):Void 
	{
		if (!isFiltered(message))
		{
			logInternal(message);
		}
	}
	
	function logInternal(message:LogEvent) 
	{
		throw "logInternal must be implemented!";
	}
	
	public function getLayout():ILayout 
	{
		return layout;
	}
	
	public function getName():String 
	{
		return name;
	}
	
}