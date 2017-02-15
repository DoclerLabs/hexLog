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
		if (filter == null)
		{
			return;
		}
		if (this.filter == null)
		{
			this.filter = filter;
		}
		else if (Std.is(this.filter, CompositeFilter))
		{
			this.filter = (cast this.filter:CompositeFilter).addFilter(filter);
		}
		else
		{
			this.filter = new CompositeFilter([this.filter, filter]);
		}
	}
	
	public function removeFilter(filter:IFilter):Void 
	{
		if (this.filter == null || filter == null)
		{
			return;
		}
		if (this.filter == filter)
		{
			this.filter = null;
		}
		else if (Std.is(this.filter, CompositeFilter))
		{
			var composite:CompositeFilter = cast this.filter;
			composite = composite.removeFilter(filter);
			if (composite.filters.length > 1)
			{
				this.filter = composite;
			}
			else if (composite.filters.length == 1)
			{
				this.filter = composite.filters[0];
			}
			else
			{
				this.filter = null;
			}
		}
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