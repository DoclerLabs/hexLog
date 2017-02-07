package hex.log2.filter;
import hex.log2.LogEvent;
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