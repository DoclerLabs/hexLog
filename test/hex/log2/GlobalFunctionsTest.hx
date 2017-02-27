package hex.log2;
import hex.log2.helper.TestLogger;
import hex.log2.helper.TestLoggerContext;
import hex.unittest.assertion.Assert;

import hex.log2.HexLog.*;


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
		Assert.equals("hex.log2.GlobalFunctionsTest", logger.getName(), "Logger names has to match");
		Assert.equals(logger, getLogger(), "Loggers must be the same");
		Assert.equals(getLogger(), getLogger(), "Loggers must be the same");
	}
	
	@Test("Test direct calls")
	public function testDirectCalls()
	{
		var ctx = new TestLoggerContext();
		
		var config = ctx.getConfiguration();
		config.addLogger("hex.log2.UsingTest", LoggerConfig.createLogger("hex.log2.UsingTest", LogLevel.ALL, null, null));
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
		config.addLogger("hex.log2.UsingTest", LoggerConfig.createLogger("hex.log2.UsingTest", LogLevel.ALL, null, null));
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