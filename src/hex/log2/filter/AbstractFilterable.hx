package hex.log2.filter;
import hex.log2.LogEvent;
import hex.log2.filter.IFilter;

/**
 * ...
 * @author ...
 */
class AbstractFilterable implements IFilterable 
{
	var filter:IFilter;

	public function new(?filter:IFilter) 
	{
		this.filter = filter;
	}
	
	public function addFilter(filter:IFilter):Void 
	{
		//todo: compisition of filters
		this.filter = filter;
	}
	
	public function removeFilter(filter:IFilter):Void 
	{
		//todo: compisition of filters
		this.filter = null;
	}
	
	public function getFilter():IFilter 
	{
		return filter;
	}
	
	public function isFiltered(event:LogEvent):Bool 
	{
		return filter != null && filter.filterEvent(event) == FilterResult.DENY;
	}
	
}