package hex.log2.filter;

/**
 * ...
 * @author ...
 */
class FiltersSuite 
{

	@Suite( "Filters suite" )
    public var list : Array<Class<Dynamic>> = [ AbstractFilterableTest, ThresholdFilterTest ];
	
}