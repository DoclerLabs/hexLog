package hex.log2;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author ...
 */
class LogManagerTest 
{

	public function new() 
	{
	}
	
	@Test("Get logger without name")
	public function testGetLoggerNoName()
	{
		var logger = LogManager.getLogger();
		Assert.isNotNull(logger);
	}
	
	@Test("Get logger with null name")
	public function testGetLoggerNullName()
	{
		var logger = LogManager.getLogger(null);
		Assert.isNotNull(logger);
	}
	
	@Test("Get logger with name")
	public function testGetLoggerName()
	{
		var logger = LogManager.getLogger("TestLogger");
		Assert.isNotNull(logger);
	}
	
	@Test("Loggers with same names are same instances")
	public function testGetLoggerSameNameSameInstance()
	{
		var logger1 = LogManager.getLogger("TestLogger");
		var logger2 = LogManager.getLogger("TestLogger");
		
		Assert.equals(logger1.getName(), logger2.getName(), "Names must be same");
		Assert.equals(logger1, logger2);
	}
	
	@Test("Loggers with different names are different instances")
	public function testGetLoggerDifferentNameDifferentInstance()
	{
		var logger1 = LogManager.getLogger("TestLogger1");
		var logger2 = LogManager.getLogger("TestLogger2");
		
		Assert.notEquals(logger1.getName(), logger2.getName(), "Names must be different");
		Assert.notEquals(logger1, logger2);
	}
	
	@Test("Get logger by class info")
	public function testGetLoggerByClassInfo()
	{
		var logger = LogManager.getLoggerByClassInfo({fqcn:"hex.log2.LogManagerTest"});
		Assert.isNotNull(logger);
	}
	
	@Test("Get logger with null class info")
	public function testGetLoggerNullClassInfo()
	{
		var logger = LogManager.getLoggerByClassInfo(null);
		Assert.isNotNull(logger);
	}
	
	@Test("Loggers with same class info are same instance")
	public function testGetLoggerByClassInfoSameInfoSameInstance()
	{
		var logger1 = LogManager.getLoggerByClassInfo({fqcn:"hex.log2.LogManagerTest"});
		var logger2 = LogManager.getLoggerByClassInfo({fqcn:"hex.log2.LogManagerTest"});
		
		Assert.equals(logger1.getName(), logger2.getName(), "Names must be same");
		Assert.equals(logger1, logger2);
	}
	
	@Test("Loggers with different class info are different instance")
	public function testGetLoggerByClassInfoDifferentInfoDifferentInstance()
	{
		var logger1 = LogManager.getLoggerByClassInfo({fqcn:"hex.log2.LogManagerTest1"});
		var logger2 = LogManager.getLoggerByClassInfo({fqcn:"hex.log2.LogManagerTest2"});
		
		Assert.notEquals(logger1.getName(), logger2.getName(), "Names must be different");
		Assert.notEquals(logger1, logger2);
	}
	
	
	@Test("Get root logger")
	public function testGetRootLogger()
	{
		Assert.isNotNull(LogManager.getRootLogger());
		Assert.isNotNull(LogManager.getLogger(""));
		Assert.isNotNull(LogManager.getLogger(LogManager.ROOT_LOGGER_NAME));
		Assert.equals(LogManager.getRootLogger(), LogManager.getLogger(""));
		Assert.equals(LogManager.getRootLogger(), LogManager.getLogger(LogManager.ROOT_LOGGER_NAME));
	}
	
	
	
}