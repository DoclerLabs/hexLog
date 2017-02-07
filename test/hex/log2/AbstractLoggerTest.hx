package hex.log2;

import haxe.PosInfos;
import hex.log2.AbstractLoggerTest.CountingLogger;
import hex.log2.LogLevel;
import hex.log2.internal.AbstractLogger;
import hex.log2.message.IMessage;
import hex.log2.message.SimpleMessage;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author ...
 */
class AbstractLoggerTest 
{

	public function new() 
	{
	}
	
	var str = "Hello";
	var simpleParam = { param: "World" };
	var simpleMessage:IMessage;
	
	var events:Array<TestLogEvent>;
	
	@Before
	public function setup()
	{
		simpleMessage = new SimpleMessage(str);
		events = [
			new TestLogEvent(new SimpleMessage(null), null, null),
			new TestLogEvent(simpleMessage, str, null),
			new TestLogEvent(simpleMessage, str, [simpleParam])
		];
	}
	
	@Test("Test debug function")
	public function testDebug()
	{
		var logger = new CountingLogger();
		logger.currentLevel = LogLevel.DEBUG;
		
		logger.currentEvent = events[0];
		logger.debug(null);
		
		logger.currentEvent = events[1];
		logger.debug(str);
		
		logger.currentEvent = events[2];
		logger.debug(str, [simpleParam]);
		
		logger.debugMessage(simpleMessage);
		
		Assert.equals(1, logger.countMsg);
		Assert.equals(3, logger.countStr);
	}
	/*
	@Test("Test info function")
	public function testInfo()
	{
		var logger = new CountingLogger();
		logger.currentLevel = LogLevel.INFO;
		
		logger.currentMessage = simpleMessage;
		logger.infoMessage(simpleMessage);
		
		logger.info(null);
		logger.info(str);
		logger.info(str, [simpleParam]);
		
		Assert.equals(1, logger.countMsg);
		Assert.equals(3, logger.countStr);
	}
	
	@Test("Test warn function")
	public function testWarn()
	{
		var logger = new CountingLogger();
		logger.currentLevel = LogLevel.WARN;
		
		logger.currentMessage = simpleMessage;
		logger.warnMessage(simpleMessage);
		
		logger.warn(null);
		logger.warn(str);
		logger.warn(str, [simpleParam]);
		
		Assert.equals(1, logger.countMsg);
		Assert.equals(3, logger.countStr);
	}
	
	@Test("Test error function")
	public function testError()
	{
		var logger = new CountingLogger();
		logger.currentLevel = LogLevel.ERROR;
		
		logger.currentMessage = simpleMessage;
		logger.errorMessage(simpleMessage);
		
		logger.error(null);
		logger.error(str);
		logger.error(str, [simpleParam]);
		
		Assert.equals(1, logger.countMsg);
		Assert.equals(3, logger.countStr);
	}
	
	@Test("Test fatal function")
	public function testFatal()
	{
		var logger = new CountingLogger();
		logger.currentLevel = LogLevel.FATAL;
		
		logger.currentMessage = simpleMessage;
		logger.fatalMessage(simpleMessage);
		
		logger.fatal(null);
		logger.fatal(str);
		logger.fatal(str, [simpleParam]);
		
		Assert.equals(1, logger.countMsg);
		Assert.equals(3, logger.countStr);
	}
	*/
	
	
}

class CountingLogger extends AbstractLogger
{
	
	public var currentEvent:TestLogEvent;
	public var currentLevel:LogLevel;
	
	public var countStr = 0;
	public var countMsg = 0;
	
	public function new() 
	{
		super();
	}
	
	override public function isEnabled(level:LogLevel, message:Dynamic, ?params:Array<Dynamic>, posInfos:PosInfos):Bool 
	{
		countStr++;
		Assert.isTrue(level == currentLevel, "Levels must be the same");
		Assert.isTrue(message == currentEvent.messageString, "Messages must be the same");
		if (currentEvent.params != null)
		{
			if (params == null)
			{
				Assert.fail("Params must be defined");
			}
			else
			{
				Assert.deepEquals(currentEvent.params, params, "Params must be same");
			}
		}
		return true;
	}
	
	override public function isMessageEnabled(level:LogLevel, message:IMessage, posInfos:PosInfos):Bool 
	{
		countMsg++;
		Assert.isTrue(level == currentLevel, "Levels must be the same");
		Assert.isTrue(message.getFormattedMessage() == currentEvent.message.getFormattedMessage(), "Messages must be the same");
		return true;
	}

	override public function logEnabledMessage(level:LogLevel, message:IMessage, posInfos:PosInfos):Void 
	{
		Assert.isTrue(level == currentLevel, "Levels must be the same");
		Assert.isTrue(message.getFormattedMessage() == currentEvent.message.getFormattedMessage(), "Messages must be the same");
	}

	override public function getLevel():LogLevel 
	{
		return currentLevel;
	}
	
}

class TestLogEvent
{
	public var message:IMessage;
	public var messageString:String;
	public var params:Array<Dynamic>;
	
	public function new(message:IMessage, messageString:String, params:Array<Dynamic>)
	{
		this.params = params;
		this.messageString = messageString;
		this.message = message;
	}
}