package hex.log;
import hex.log.configuration.IConfiguration;
import hex.log.helper.TestLogTarget;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author ...
 */
class LoggerTestParenting 
{

	public function new() 
	{
	}
	
	var logger:Logger;
	var loggerChild:Logger;
	var loggerGrandchild:Logger;
	
	var rootTarget:TestLogTarget;
	var target:TestLogTarget;
	var targetChild:TestLogTarget;
	var targetGrandchild:TestLogTarget;
	
	@Before
	public function setup()
	{
		LogManager.context = new LoggerContext();
		
		logger = cast LogManager.getLogger("LoggerTest");
		loggerChild = cast LogManager.getLogger("LoggerTest.child");
		loggerGrandchild = cast LogManager.getLogger("LoggerTest.child.grand");
		
		rootTarget = new TestLogTarget("TargetTest", null, null);
		target = new TestLogTarget("TargetTest", null, null);
		targetChild = new TestLogTarget("TargetTest.child", null, null);
		targetGrandchild = new TestLogTarget("TargetTest.chil.grand", null, null);
		
		LogManager.getContext().getConfiguration().addLoggerLogTarget(LogManager.getRootLogger(), rootTarget);
		LogManager.getContext().getConfiguration().addLoggerLogTarget(logger, target);
		LogManager.getContext().getConfiguration().addLoggerLogTarget(loggerChild, targetChild);
		LogManager.getContext().getConfiguration().addLoggerLogTarget(loggerGrandchild, targetGrandchild);
		
		Configurator.setRootLevel(LogLevel.ALL);
		Configurator.setAllLevels(logger.getName(), LogLevel.ALL);
	}
	
	@Test("Test bubbling - one logger and root")
	public function testLogBubbleRoot()
	{
		Configurator.setAllLevels(logger.getName(), LogLevel.ALL);
		
		logger.debug("Hello");
		Assert.equals(1, rootTarget.messages.length, "Number of messages is wrong");
		Assert.equals(1, target.messages.length, "Number of messages is wrong");
	}
	
	@Test("Test bubbling - child logger, parent and root")
	public function testLogBubbleChild()
	{
		Configurator.setAllLevels(logger.getName(), LogLevel.ALL);
		
		loggerChild.debug("Hello");
		Assert.equals(1, rootTarget.messages.length, "Number of messages is wrong");
		Assert.equals(1, target.messages.length, "Number of messages is wrong");
		Assert.equals(1, targetChild.messages.length, "Number of messages is wrong");
	}
	
	@Test("Test bubbling - grandchild, child, parent and root")
	public function testLogBubbleGrandchild()
	{
		Configurator.setAllLevels(logger.getName(), LogLevel.ALL);
		
		loggerGrandchild.debug("Hello");
		Assert.equals(1, rootTarget.messages.length, "Number of messages is wrong");
		Assert.equals(1, target.messages.length, "Number of messages is wrong");
		Assert.equals(1, targetChild.messages.length, "Number of messages is wrong");
		Assert.equals(1, targetGrandchild.messages.length, "Number of messages is wrong");
	}
	
	@Test("Debug channel level")
	public function testDebugChannelLevel()
	{
		logger.setLevel(LogLevel.DEBUG);
		logger.debug("Debug message 1");
		Assert.equals(1, target.messages.length, "Number of messages is wrong");
		
		logger.setLevel(LogLevel.OFF);
		logger.debug("Debug message 2");
		Assert.equals(1, target.messages.length, "Number of messages is wrong");
		
		logger.setLevel(LogLevel.DEBUG);
		logger.debug("Debug message 3");
		Assert.equals(2, target.messages.length, "Number of messages is wrong");
	}
	
	@Test("Debug change level of all children loggers")
	public function testDebugChangeLevelAllChildrenLoggers()
	{
		logger.debug("Debug message 1");
		loggerChild.debug("Debug message 1 child");
		loggerGrandchild.debug("Debug message 1 grandchild");
		Assert.equals(3, target.messages.length, "Number of messages is wrong");
		
		Configurator.setAllLevels(logger.getName(), LogLevel.OFF);
		
		logger.debug("Debug message 2");
		loggerChild.warn("Debug message 2 child");
		loggerGrandchild.fatal("Debug message 2 grandchild");
		Assert.equals(3, target.messages.length, "Number of messages is wrong");
		
		Configurator.setAllLevels(logger.getName(), LogLevel.INFO);
		
		logger.info("Debug message 3");
		loggerChild.warn("Debug message 3 child");
		loggerGrandchild.debug("Debug message 3 grandchild"); // level is set to info, this one shouldn't bubble up
		Assert.equals(5, target.messages.length, "Number of messages is wrong");
	}
	
	@Test("Debug change level of one child logger")
	public function testDebugChangeLevelChildLogger()
	{
		logger.debug("Debug message 1");
		loggerChild.debug("Debug message 1 child");
		loggerGrandchild.debug("Debug message 1 grandchild");
		Assert.equals(3, rootTarget.messages.length, "Number of messages is wrong");
		
		Configurator.setLoggerLevelByName(logger.getName(), LogLevel.OFF);
		
		logger.debug("Debug message 2");
		loggerChild.debug("Debug message 2 child");
		loggerGrandchild.debug("Debug message 2 grandchild");
		Assert.equals(3, rootTarget.messages.length, "Number of messages is wrong");
		
		Configurator.setLoggerLevelByName(logger.getName(), LogLevel.DEBUG);
		
		logger.debug("Debug message 3");
		loggerChild.debug("Debug message 3 child");
		loggerGrandchild.debug("Debug message 3 grandchild");
		Assert.equals(6, rootTarget.messages.length, "Number of messages is wrong");
	}
	
	@Test("Change root level")
	public function testChangeRootLevel()
	{
		logger.debug("Debug message 1");
		Assert.equals(1, rootTarget.messages.length);
		
		Configurator.setRootLevel(LogLevel.OFF);
		logger.debug("Debug message 2");
		Assert.equals(1, rootTarget.messages.length);
		
		Configurator.setRootLevel(LogLevel.DEBUG);
		logger.debug("Debug message 3");
		Assert.equals(2, rootTarget.messages.length);
	}
	
	@Test("Level inheritance")
	public function testLevelInheritance()
	{
		var config = LoggerContext.getContext().getConfiguration();
		var loggerConfig = config.getLoggerConfig(logger.getName());
		Assert.isNotNull(loggerConfig);
		Assert.equals("LoggerTest", loggerConfig.name, "Config names must be the same");
		Assert.equals(LogLevel.ALL, loggerConfig.level, "Levels must be the same");
		var localLogger = LogManager.getLogger("LoggerTest");
		Assert.equals(LogLevel.ALL, localLogger.getLevel(), "Levels of local logger must be inherited");
	}
	
}

class Configurator
{
	public static function setAllLevels(parentLoggerName:String, level:LogLevel):Bool
	{
		var context = LoggerContext.getContext();
		var config = context.getConfiguration();
		var set = setLevel(parentLoggerName, level, config);
		var loggers = config.getLoggers();
		for (key in loggers.keys())
		{
			if (key.indexOf(parentLoggerName) == 0)
			{
				set = setLoggerLevel(loggers.get(key), level) || set;
			}
		}
		if (set)
		{
			context.updateLoggers();
		}
		return set;
	}
	
	public static function setLoggerLevel(loggerConfig:LoggerConfig, level:LogLevel):Bool
	{
		var set = loggerConfig.level != level;
		if (set)
		{
			loggerConfig.level = level;
		}
		return set;
	}
	
	public static function setLoggerLevelByName(loggerName:String, level:LogLevel)
	{
		var context = LoggerContext.getContext();
		if (loggerName == null || loggerName == "")
		{
			setRootLevel(level);
		}
		else
		{
			if (setLevel(loggerName, level, context.getConfiguration()))
			{
				context.updateLoggers();
			}
		}
	}
	
	public static function setLevel(loggerName:String, level:LogLevel, config:IConfiguration):Bool
	{
		var set = false;
		
		var loggerConfig = config.getLoggerConfig(loggerName);
		if (loggerName != loggerConfig.name)
		{
			loggerConfig = new LoggerConfig(loggerName, level, config);
			config.addLogger(loggerName, loggerConfig);
			loggerConfig.level = level;
			set = true;
		}
		else
		{
			set = setLoggerLevel(loggerConfig, level);
		}
		return set;
	}
	
	public static function setRootLevel(level:LogLevel)
	{
		var context = LoggerContext.getContext();
		var config = context.getConfiguration().getRootLogger();
		if (config.level != level)
		{
			config.level = level;
			context.updateLoggers();
		}
	}
}