package hex.log;
import hex.log.helper.TestLogger;
import hex.log.helper.TestLoggerContext;
import hex.unittest.assertion.Assert;

import hex.log.HexLog.*;


/**
 * ...
 * @author ...
 */
class GlobalFunctionsTest 
{

	public function new() 
	{
		
	}
	
	@Before
	public function setup()
	{
		
	}
	
	@Test("Test getLogger()")
	public function testMacroUtil()
	{
		var logger = getLogger();
		
		Assert.isNotNull(logger, "Logger can't be null");
		Assert.equals("hex.log.GlobalFunctionsTest", logger.getName(), "Logger names has to match");
		Assert.equals(logger, getLogger(), "Loggers must be the same");
		Assert.equals(getLogger(), getLogger(), "Loggers must be the same");
	}
	
	@Test("Test direct calls")
	public function testDirectCalls()
	{
		var ctx = new TestLoggerContext();
		
		var config = ctx.getConfiguration();
		config.addLogger("hex.log.UsingTest", LoggerConfig.createLogger("hex.log.UsingTest", LogLevel.ALL, null, null));
		ctx.setConfiguration(config);
		
		LogManager.context = ctx;
		
		var message = "Test - level: {}";
		debug(message, ["debug"]);
		info(message, ["info"]);
		warn(message, ["warn"]);
		error(message, ["error"]);
		fatal(message, ["fatal"]);
		
		var logger:TestLogger = cast getLogger();
		Assert.equals(5, logger.entries.length, "Number of messages must match");
	}
	
	@Test("Test getLoggerCalls")
	public function testGetLoggerCalls()
	{
		var ctx = new TestLoggerContext();
		
		var config = ctx.getConfiguration();
		config.addLogger("hex.log.UsingTest", LoggerConfig.createLogger("hex.log.UsingTest", LogLevel.ALL, null, null));
		ctx.setConfiguration(config);
		
		LogManager.context = ctx;
		
		var message = "Test - level: {}";
		getLogger().debug(message, ["debug"]);
		getLogger().info(message, ["info"]);
		getLogger().warn(message, ["warn"]);
		getLogger().error(message, ["error"]);
		getLogger().fatal(message, ["fatal"]);
		
		var logger:TestLogger = cast getLogger();
		Assert.equals(5, logger.entries.length, "Number of messages must match");
	}
	
}