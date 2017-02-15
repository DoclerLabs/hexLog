package hex.log2.filter;
import hex.log2.LogEvent;
import hex.log2.filter.IFilter.FilterResult;
import hex.unittest.assertion.Assert;

class ThresholdFilterTest 
{

	public function new() 
	{
	}
	
	@Test("Test thresholds")
	public function testThresholds()
	{
		var filter = new ThresholdFilter(LogLevel.ERROR, null, null);
		
		//filter
		Assert.equals(FilterResult.DENY, filter.filter(null, LogLevel.DEBUG, null, null));
		Assert.equals(FilterResult.NEUTRAL, filter.filter(null, LogLevel.ERROR, null, null));
		
		//filter event
		Assert.equals(FilterResult.DENY, filter.filterEvent(new LogEvent(null, LogLevel.DEBUG)));
		Assert.equals(FilterResult.NEUTRAL, filter.filterEvent(new LogEvent(null, LogLevel.ERROR)));
		
		//filter message
		Assert.equals(FilterResult.DENY, filter.filterMessage(null, LogLevel.DEBUG, null));
		Assert.equals(FilterResult.NEUTRAL, filter.filterMessage(null, LogLevel.ERROR, null));
	}
	
}