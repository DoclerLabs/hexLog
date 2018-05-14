package hex.log;
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
	
	@Test("Get root logger")
	public function testGetRootLogger()
	{
		Assert.isNotNull(LogManager.getRootLogger());
		Assert.isNotNull(LogManager.getLogger(""));
		Assert.isNotNull(LogManager.getLogger(LogManager.ROOT_LOGGER_NAME));
		Assert.equals(LogManager.getRootLogger(), LogManager.getLogger(""));
		Assert.equals(LogManager.getRootLogger(), LogManager.getLogger(LogManager.ROOT_LOGGER_NAME));
	}
	
	@Test("Get logger by class")
	public function testGetLoggerByClass()
	{
		var logger = LogManager.getLoggerByClass(LogManagerTest);
		Assert.isNotNull(logger);
		Assert.equals("hex.log.LogManagerTest", logger.getName(), "Logger name must be the same");
	}
	
	@Test("Get logger by class null class")
	public function testGetLoggerByClassNull()
	{
		var logger = LogManager.getLoggerByClass(null);
		Assert.isNotNull(logger);
		Assert.equals("", logger.getName(), "Logger name must be the same");
	}
	
	@Test("Get logger by instance")
	public function testGetLoggerByInstance()
	{
		var logger = LogManager.getLoggerByInstance(this);
		Assert.isNotNull(logger);
		Assert.equals("hex.log.LogManagerTest", logger.getName(), "Logger name must be the same");
	}
	
	@Test("Get logger by class null class")
	public function testGetLoggerByInstanceNull()
	{
		var logger = LogManager.getLoggerByInstance(null);
		Assert.isNotNull(logger);
		Assert.equals("", logger.getName(), "Logger name must be the same");
	}
	
}