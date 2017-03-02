package hex.log;
import hex.log.LoggerConfig;
import hex.log.configuration.BasicConfiguration;
import hex.log.helper.TestLogTarget;
import hex.log.layout.DefaultTraceLogLayout;
import hex.log.target.TraceLogTarget;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author ...
 */
class ConfigurationTest 
{

	public function new() 
	{
	}
	
	@Before
	public function setup()
	{
	}
	
	
	@Test("Configuration test")
	public function testConfiguration()
	{
		//----- CONFIGURATION
		
		var configuration = new BasicConfiguration();
		
		//create log targets
		var traceTarget = new TraceLogTarget("Trace", null, new DefaultTraceLogLayout());
		var testTarget = new TestLogTarget("Test", null, null);
		
		//create a logger config and add targets
		//(at this point we can also add filters to the configuration etc.)
		var lc1:LoggerConfig = LoggerConfig.createLogger("hex", LogLevel.WARN, null, null); // Logger will only forward warnings+
		lc1.addLogTarget(traceTarget, LogLevel.ALL, null); // Target will accept every event that arrives (in this case only warnings+ will be forwarded from the logger anyway)
		lc1.addLogTarget(testTarget, LogLevel.ALL, null);
		configuration.addLogger(lc1.name, lc1); //Add logger config to the configuration
		
		//apply the configuration
		LoggerContext.getContext().setConfiguration(configuration);
		
		
		//----- LOGGER USAGE
		
		//grab logger and start logging
		var logger = LogManager.getLogger("hex.log.ConfigurationTest");
		var message = "Test - level: {}";
		logger.debug(message, ["debug"]);
		logger.info(message, ["info"]);
		logger.warn(message, ["warn"]);
		logger.error(message, ["error"]);
		logger.fatal(message, ["fatal"]);
		
		//-----
		//Just an assert to make sure everything is loggin as it's supposed to
		Assert.equals(3, testTarget.messages.length, "Number of messages must match");
	}
	
}