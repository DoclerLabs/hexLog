package hex.log.filter;
import hex.log.filter.ThresholdFilter;
import hex.unittest.assertion.Assert;

class AbstractFilterableTest 
{

	public function new() {}
	
	var filterable:MockFilterable;
	
	@Before
	public function setup()
	{
		filterable = new MockFilterable();
	}
	
	@Test("Add simple filter")
	public function testAddSimpleFilter()
	{
		var filter:IFilter = new ThresholdFilter(LogLevel.DEBUG, null, null);
		filterable.addFilter(filter);
		
		Assert.equals(filter, filterable.getFilter(), "Filters must be same");
	}
	
	@Test("Add simple filter and null filter")
	public function testAddSimpleFilterAndNullFilter()
	{
		var filter:IFilter = new ThresholdFilter(LogLevel.DEBUG, null, null);
		filterable.addFilter(filter);
		filterable.addFilter(null);
		Assert.equals(filter, filterable.getFilter(), "Filters must be same");
	}
	
	@Test("Add multiple simple filters")
	public function testAddMultipleFimpleFilters()
	{
		var filter:IFilter = new ThresholdFilter(LogLevel.DEBUG, null, null);
		filterable.addFilter(filter);
		
		Assert.equals(filter, filterable.getFilter(), "Filters must be same");
		
		filterable.addFilter(filter);
		Assert.isInstanceOf(filterable.getFilter(), CompositeFilter, "Combined filter must be a CompositeFilter");
		Assert.equals(2, (cast filterable.getFilter():CompositeFilter).filters.length, "Number of filters must match");
	}
	
	@Test("Add composite filter")
	public function testAddCompositeFilter()
	{
		var filter1 = new ThresholdFilter(LogLevel.ERROR, null, null);
		var filter2 = new ThresholdFilter(LogLevel.ERROR, null, null);
		var compositeFilter = new CompositeFilter([filter1, filter2]);
		
		filterable.addFilter(compositeFilter);
		Assert.equals(compositeFilter, filterable.getFilter(), "Composite filters must be same");
	}
	
	@Test("Add multiple composite filters")
	public function testAddMultipleCompositeFilters()
	{
		var filter1 = new ThresholdFilter(LogLevel.ERROR, null, null);
		var filter2 = new ThresholdFilter(LogLevel.ERROR, null, null);
		var filter3 = new ThresholdFilter(LogLevel.ERROR, null, null);
		var compositeFilter = new CompositeFilter([filter1, filter2, filter3]);
		
		filterable.addFilter(compositeFilter);
		Assert.equals(compositeFilter, filterable.getFilter(), "Composite filters must be same");
		
		filterable.addFilter(compositeFilter);
		Assert.isInstanceOf(filterable.getFilter(), CompositeFilter, "Combined filter must be a CompositeFilter");
		Assert.equals(6, (cast filterable.getFilter():CompositeFilter).filters.length, "Number of filters must match");
	}
	
	@Test("Add simple filter and composite filter")
	public function testAddSimpleFilterAndCompositeFilter()
	{
		var filter1 = new ThresholdFilter(LogLevel.ERROR, null, null);
		var filter2 = new ThresholdFilter(LogLevel.ERROR, null, null);
		var notInComposite = new ThresholdFilter(LogLevel.ERROR, null, null);
		var compositeFilter = new CompositeFilter([filter1, filter2]);
		
		filterable.addFilter(notInComposite);
		Assert.equals(notInComposite, filterable.getFilter(), "Composite filters must be same");
		
		filterable.addFilter(compositeFilter);
		Assert.isInstanceOf(filterable.getFilter(), CompositeFilter, "Combined filter must be a CompositeFilter");
		Assert.equals(2, (cast filterable.getFilter():CompositeFilter).filters.length, "Number of filters must match");
	}
	
	@Test("Add composite filter and simple filter")
	public function testAddCompositeFilterAndSimpleFilter()
	{
		var filter1 = new ThresholdFilter(LogLevel.ERROR, null, null);
		var filter2 = new ThresholdFilter(LogLevel.ERROR, null, null);
		var notInComposite = new ThresholdFilter(LogLevel.ERROR, null, null);
		var compositeFilter = new CompositeFilter([filter1, filter2]);
		
		filterable.addFilter(compositeFilter);
		Assert.equals(compositeFilter, filterable.getFilter(), "Composite filters must be same");
		
		filterable.addFilter(notInComposite);
		Assert.isInstanceOf(filterable.getFilter(), CompositeFilter, "Combined filter must be a CompositeFilter");
		Assert.equals(3, (cast filterable.getFilter():CompositeFilter).filters.length, "Number of filters must match");
	}
	
	@Test("Remove simple filter")
	public function testRemoveSimpleFilter()
	{
		var filter:IFilter = new ThresholdFilter(LogLevel.DEBUG, null, null);
		filterable.addFilter(filter);
		filterable.removeFilter(filter);
		
		Assert.isNull(filterable.getFilter(), "Filter must be null");
	}
	
	@Test("Remove null filter from single simple filter")
	public function testRemoveNullFilterFromSimpleFilter()
	{
		var filter:IFilter = new ThresholdFilter(LogLevel.DEBUG, null, null);
		filterable.addFilter(filter);
		filterable.removeFilter(null);
		
		Assert.equals(filter, filterable.getFilter(), "Filters must be same");
	}
	
	@Test("Remove non-existing filter from a simple filter")
	public function testRemoveNonExistingFilterFromSimpleFilter()
	{
		var filter:IFilter = new ThresholdFilter(LogLevel.DEBUG, null, null);
		var newFilter:IFilter = new ThresholdFilter(LogLevel.DEBUG, null, null);
		filterable.addFilter(filter);
		filterable.removeFilter(newFilter);
		
		Assert.equals(filter, filterable.getFilter(), "Filters must be same");
	}
	
	@Test("Remove simple filter from composite filter")
	public function testRemoveSimpleFilterFromCompositeFilter()
	{
		var filter1 = new ThresholdFilter(LogLevel.ERROR, null, null);
		var filter2 = new ThresholdFilter(LogLevel.ERROR, null, null);
		var compositeFilter = new CompositeFilter([filter1, filter2]);
		
		filterable.addFilter(compositeFilter);
		filterable.removeFilter(filter1);
		
		Assert.equals(filter2, filterable.getFilter(), "Filters must be same");
	}
	
	@Test("Remove simple filter from composite and simple filter")
	public function testRemoveSimpleFilterFromCompositeAndSimpleFilter()
	{
		var filter1 = new ThresholdFilter(LogLevel.ERROR, null, null);
		var filter2 = new ThresholdFilter(LogLevel.ERROR, null, null);
		var compositeFilter = new CompositeFilter([filter1, filter2]);
		var anotherFilter = new ThresholdFilter(LogLevel.ERROR, null, null);
		
		filterable.addFilter(compositeFilter);
		filterable.addFilter(anotherFilter);
		filterable.removeFilter(anotherFilter);
		
		Assert.isInstanceOf(filterable.getFilter(), CompositeFilter, "Combined filter must be a CompositeFilter");
		Assert.equals(2, (cast filterable.getFilter():CompositeFilter).filters.length, "Number of filters must match");
	}
	
	@Test("Remove composite filter from composite filter")
	public function testRemoveCompositeFilterFromCompositeFilter()
	{
		var filter1 = new ThresholdFilter(LogLevel.ERROR, null, null);
		var filter2 = new ThresholdFilter(LogLevel.ERROR, null, null);
		var compositeFilter = new CompositeFilter([filter1, filter2]);
		
		filterable.addFilter(compositeFilter);
		filterable.removeFilter(compositeFilter);
		
		Assert.isNull(filterable.getFilter(), "Filter must be null");
	}
	
	@Test("Remove filters from composite filter")
	public function testRemoveFiltersFromCompositeFilter()
	{
		var filter1 = new ThresholdFilter(LogLevel.ERROR, null, null);
		var filter2 = new ThresholdFilter(LogLevel.ERROR, null, null);
		var compositeFilter = new CompositeFilter([filter1, filter2]);
		var anotherFilter = new ThresholdFilter(LogLevel.ERROR, null, null);
		
		filterable.addFilter(compositeFilter);
		filterable.addFilter(anotherFilter);
		Assert.equals(3, (cast filterable.getFilter():CompositeFilter).filters.length, "Number of filters must match");
		
		filterable.removeFilter(filter1);
		Assert.equals(2, (cast filterable.getFilter():CompositeFilter).filters.length, "Number of filters must match");
		
		filterable.removeFilter(filter2);
		Assert.equals(anotherFilter, filterable.getFilter(), "Filters must be same");
	}
	
}

class MockFilterable extends AbstractFilterable
{
}