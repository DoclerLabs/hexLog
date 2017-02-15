package hex.log2.filter;
import hex.log2.filter.IFilter;
import hex.log2.message.IMessage;
import hex.log2.LogEvent;
import haxe.PosInfos;
import hex.log2.LogLevel;
import hex.log2.ILogger;
import hex.log2.filter.IFilter.FilterResult;

/**
 * ...
 * @author ...
 */
class CompositeFilter implements IFilter 
{
	
	public var filters(default, null):Array<IFilter>;

	public function new(?filters:Array<IFilter>) 
	{
		this.filters = filters == null ? [] : filters;
	}
	
	public function addFilter(filter:IFilter):CompositeFilter
	{
		if (filter == null)
		{
			return this;
		}
		if (Std.is(filter, CompositeFilter))
		{
			var composite:CompositeFilter = cast filter;
			return new CompositeFilter(filters.copy().concat(composite.filters.copy()));
		}
		var copy = filters.copy();
		copy.push(filter);
		return new CompositeFilter(copy);
	}
	
	public function removeFilter(filter:IFilter):CompositeFilter
	{
		if (filter == null)
		{
			return this;
		}
		
		var newFilters = filters.copy();
		if (Std.is(filter, CompositeFilter))
		{
			var composite:CompositeFilter = cast filter;
			for (f in composite.filters)
			{
				var i = newFilters.indexOf(f);
				if (i >= 0)
				{
					newFilters.splice(i, 1);
				}
			}
		}
		else
		{
			var i = newFilters.indexOf(filter);
			if (i >= 0)
			{
				newFilters.splice(i, 1);
			}
		}
		return new CompositeFilter(newFilters);
	}
	
	public function filter(logger:ILogger, level:LogLevel, message:Dynamic, params:Array<Dynamic>, ?posInfos:PosInfos):FilterResult 
	{
		var result = FilterResult.NEUTRAL;
		for (f in filters)
		{
			var result = f.filter(logger, level, message, params, posInfos);
			if (result == FilterResult.ACCEPT || result == FilterResult.DENY)
			{
				return result;
			}
		}
		return result;
	}
	
	public function filterEvent(event:LogEvent):FilterResult 
	{
		var result = FilterResult.NEUTRAL;
		for (f in filters)
		{
			var result = f.filterEvent(event);
			if (result == FilterResult.ACCEPT || result == FilterResult.DENY)
			{
				return result;
			}
		}
		return result;
	}
	
	public function filterMessage(logger:ILogger, level:LogLevel, message:IMessage, ?posInfos:PosInfos):FilterResult 
	{
		var result = FilterResult.NEUTRAL;
		for (f in filters)
		{
			var result = f.filterMessage(logger, level, message, posInfos);
			if (result == FilterResult.ACCEPT || result == FilterResult.DENY)
			{
				return result;
			}
		}
		return result;
	}
	
	public function filterLoggerMessage(logger:ILogger, message:IMessage):FilterResult 
	{
		var result = FilterResult.NEUTRAL;
		for (f in filters)
		{
			var result = f.filterLoggerMessage(logger, message);
			if (result == FilterResult.ACCEPT || result == FilterResult.DENY)
			{
				return result;
			}
		}
		return result;
	}
	
	
}