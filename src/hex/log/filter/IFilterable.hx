package hex.log.filter;
import hex.log.LogEvent;
/**
 * @author ...
 */

interface IFilterable 
{
	
    function addFilter(filter:IFilter):Void;
	function removeFilter(filter:IFilter):Void;
	function getFilter():IFilter;
	function isFiltered(event:LogEvent):Bool;
	
}