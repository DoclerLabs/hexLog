package hex.log2;
import hex.log2.helper.TestLogger;
import hex.log2.helper.TestLoggerContext;
import hex.log2.message.ParameterizedMessageFactory;
import hex.log2.message.SimpleMessageFactory;
import hex.unittest.assertion.Assert;



class LoggerTest 
{

	public function new() {}
	
	var logger:TestLogger;
	var results:List<String>;
	
	@Before
	public function setup()
	{
		LogManager.context = new TestLoggerContext();
		logger = cast LogManager.getLogger("LoggerTest");
		results = logger.entries;
	}
	
	@Test("Debug")
	public function testDebug()
	{
		logger.debug("Debug message");
		Assert.equals(1, results.length);
		Assert.isTrue(results.first() == "DEBUG Debug message", "Incorrect message");
	}
	
	@Test("Debug object")
	public function testDebugObject()
	{
		logger.debug(Date.now());
		Assert.equals(1, results.length);
		Assert.isTrue(results.first().length > 7, "Invalid length");
	}
	
	@Test("Debug with params")
	public function testDebugWithParams()
	{
		logger.debug("Hello {}", ["World"]);
		Assert.equals(1, results.length);
		Assert.isTrue(results.first() == "DEBUG Hello World", "Incorrect message");
	}
	
	@Test("Get parameterized message factory")
	public function testParameterizedMessageFactory()
	{
		var messageFactory = ParameterizedMessageFactory.instance;
		var testLogger:TestLogger = cast LogManager.getLogger("Logger_ParameterizedMessageFactory", messageFactory);
		
		Assert.isNotNull(testLogger);
		Assert.equals(messageFactory, testLogger.getMessageFactory());
		
		testLogger.debug("{}", [0]);
		Assert.equals(1, testLogger.entries.length);
		Assert.equals("DEBUG 0", testLogger.entries.first(), "Incorrect message");
	}
	
	@Test("Get simple message factory")
	public function testSimpleMessageFactory()
	{
		var messageFactory = SimpleMessageFactory.instance;
		var testLogger:TestLogger = cast LogManager.getLogger("Logger_SimpleMessageFactory", messageFactory);
		
		Assert.isNotNull(testLogger);
		Assert.equals(messageFactory, testLogger.getMessageFactory());
		
		testLogger.debug("{}", [0]);
		Assert.equals(1, testLogger.entries.length);
		Assert.equals("DEBUG {}", testLogger.entries.first(), "Incorrect message");
	}
	
	public static var levelsDataProvider:Array<Array<LogLevel>> = [for (level in LogLevel.LEVELS) [level]];
	
	@Test("Test is level enabled")
	@DataProvider("levelsDataProvider")
	public function testIsLevelEnabled(logLevel:LogLevel)
	{
		Assert.isTrue(logger.isLevelEnabled(logLevel), "Incorrect level");
	}
}
