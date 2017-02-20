package hex.log2.target;
import hex.log2.LogEvent;
import hex.log2.filter.AbstractFilterable;
import hex.log2.filter.IFilter;
import hex.log2.layout.ILayout;

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