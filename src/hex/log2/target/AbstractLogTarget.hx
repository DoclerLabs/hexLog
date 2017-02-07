package hex.log2.target;
import hex.log2.LogEvent;
import hex.log2.filter.IFilter;
import hex.log2.layout.ILayout;

/**
 * ...
 * @author ...
 */
class AbstractLogTarget implements ILogTarget
{
	var filter:IFilter;
	var layout:ILayout;
	var name:String;

	public function new(name:String, filter:IFilter, layout:ILayout) 
	{
		this.name = name;
		this.layout = layout;
		this.filter = filter;
	}
	
	public function onLog(message:LogEvent):Void 
	{
		throw "onLog must be implemented!";
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