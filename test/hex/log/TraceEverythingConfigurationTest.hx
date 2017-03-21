package hex.log;
import hex.log.configuration.TraceEverythingConfiguration;
import hex.log.helper.TestLogTarget;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author ...
 */
class TraceEverythingConfigurationTest 
{

	public function new() 
	{
	}
	
	@Before
	public function setup()
	{
		LogManager.context = new LoggerContext();
	}
	
	@Test("Trace everything configuration test")
	public function testTraceEverythingConfiguration()
	{
		LoggerContext.getContext().setConfiguration(new TraceEverythingConfiguration());
		
		// add test log target to be able to count messages
		var testTarget = new TestLogTarget("Test", null, null);
		LoggerContext.getContext().getConfiguration().getRootLogger().addLogTarget(testTarget, null, null);
		
		var logger = LogManager.getLogger("hex.log.TraceEverythingConfigurationTest");
		var message = "Test - level: {}";
		logger.debug(message, ["debug"]);
		logger.info(message, ["info"]);
		logger.warn(message, ["warn"]);
		logger.error(message, ["error"]);
		logger.fatal(message, ["fatal"]);
		
		Assert.equals(5, testTarget.messages.length, "Number of messages must match");
		
		testTarget.messages.clear();
		logger = LogManager.getLogger("hex.log.TraceEverythingConfigurationTest.Child");
		logger.debug(message, ["debug"]);
		logger.info(message, ["info"]);
		logger.warn(message, ["warn"]);
		logger.error(message, ["error"]);
		logger.fatal(message, ["fatal"]);
		
		Assert.equals(5, testTarget.messages.length, "Number of messages must match");
	}
	
}