package hex.log2;

import haxe.PosInfos;
import hex.log2.LogLevel;
import hex.log2.internal.AbstractLogger;
import hex.log2.message.IMessage;
import hex.log2.message.ParametrizedMessage;
import hex.log2.message.ParametrizedMessageFactory;
import hex.log2.message.SimpleMessage;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author ...
 */
class AbstractLoggerTest 
{

	var str:String;
	var events:Array<TestLogEvent>;
	var simpleParam:Dynamic;
	var simpleMessage:IMessage;
	var complexMessage:IMessage;

	public function new() 
	{
	}
	
	@Before
	public function setup()
	{
		str = "Hello";
		simpleParam = { param: "World" };
		
		simpleMessage = new SimpleMessage(str);
		complexMessage = new ParametrizedMessage(str, [simpleParam]);
		events = [
			{
				message: new SimpleMessage(null),
				messageString: null,
				params: null
			},
			{
				message: simpleMessage,
				messageString: str,
				params: null
			},
			{
				message: simpleMessage,
				messageString: str,
				params: null
			},
			{
				message: complexMessage,
				messageString: str,
				params: [simpleParam]
			}
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
		
		logger.currentEvent = events[3];
		logger.debugMessage(complexMessage);
		
		Assert.equals(1, logger.countMsg);
		Assert.equals(3, logger.countStr);
	}
	
	@Test("Test info function")
	public function testInfo()
	{
		var logger = new CountingLogger();
		logger.currentLevel = LogLevel.INFO;
		
		logger.currentEvent = events[0];
		logger.info(null);
		
		logger.currentEvent = events[1];
		logger.info(str);
		
		logger.currentEvent = events[2];
		logger.info(str, [simpleParam]);
		
		logger.currentEvent = events[3];
		logger.infoMessage(complexMessage);
		
		Assert.equals(1, logger.countMsg);
		Assert.equals(3, logger.countStr);
	}
	
	@Test("Test warn function")
	public function testWarn()
	{
		var logger = new CountingLogger();
		logger.currentLevel = LogLevel.WARN;
		
		logger.currentEvent = events[0];
		logger.warn(null);
		
		logger.currentEvent = events[1];
		logger.warn(str);
		
		logger.currentEvent = events[2];
		logger.warn(str, [simpleParam]);
		
		logger.currentEvent = events[3];
		logger.warnMessage(complexMessage);
		
		Assert.equals(1, logger.countMsg);
		Assert.equals(3, logger.countStr);
	}
	
	@Test("Test error function")
	public function testError()
	{
		var logger = new CountingLogger();
		logger.currentLevel = LogLevel.ERROR;
		
		logger.currentEvent = events[0];
		logger.error(null);
		
		logger.currentEvent = events[1];
		logger.error(str);
		
		logger.currentEvent = events[2];
		logger.error(str, [simpleParam]);
		
		logger.currentEvent = events[3];
		logger.errorMessage(complexMessage);
		
		Assert.equals(1, logger.countMsg);
		Assert.equals(3, logger.countStr);
	}
	
	@Test("Test fatal function")
	public function testFatal()
	{
		var logger = new CountingLogger();
		logger.currentLevel = LogLevel.FATAL;
		
		logger.currentEvent = events[0];
		logger.fatal(null);
		
		logger.currentEvent = events[1];
		logger.fatal(str);
		
		logger.currentEvent = events[2];
		logger.fatal(str, [simpleParam]);
		
		logger.currentEvent = events[3];
		logger.fatalMessage(complexMessage);
		
		Assert.equals(1, logger.countMsg);
		Assert.equals(3, logger.countStr);
	}
	
}

class CountingLogger extends AbstractLogger
{
	
	public var currentEvent:TestLogEvent;
	public var currentLevel:LogLevel;
	
	public var countStr = 0;
	public var countMsg = 0;
	
	public function new() 
	{
		super(new ParametrizedMessageFactory());
	}
	
	override public function isEnabled(level:LogLevel, message:Dynamic, ?params:Array<Dynamic>, posInfos:PosInfos):Bool 
	{
		countStr++;
		Assert.isTrue(level == currentLevel, "isEnabled - Levels must be the same");
		Assert.isTrue(message == currentEvent.messageString, "isEnabled - Messages must be the same");
		if (currentEvent.params != null)
		{
			if (params == null)
			{
				Assert.fail("isEnabled - Params must be defined");
			}
			else
			{
				Assert.deepEquals(currentEvent.params, params, "isEnabled - Params must be same");
			}
		}
		return true;
	}
	
	override public function isMessageEnabled(level:LogLevel, message:IMessage, posInfos:PosInfos):Bool 
	{
		countMsg++;
		Assert.isTrue(level == currentLevel, "isMessageEnabled - Levels must be the same");
		Assert.isTrue(message.getFormattedMessage() == currentEvent.message.getFormattedMessage(), "isMessageEnabled - Messages must be the same");
		return true;
	}

	override public function logEnabledMessage(level:LogLevel, message:IMessage, posInfos:PosInfos):Void 
	{
		Assert.isTrue(level == currentLevel, "logEnabledMessage - Levels must be the same");
		Assert.isTrue(message.getFormattedMessage() == currentEvent.message.getFormattedMessage(), "logEnabledMessage - Messages must be the same");
		if (currentEvent.params != null)
		{
			if (message.getParameters() == null)
			{
				Assert.fail("logEnabledMessage - Params must be defined");
			}
			else
			{
				Assert.deepEquals(currentEvent.params, message.getParameters(), "logEnabledMessage - Params must be same");
			}
		}
	}

	override public function getLevel():LogLevel 
	{
		return currentLevel;
	}
	
}

typedef TestLogEvent = {
	var message:IMessage;
	var messageString:String;
	var params:Array<Dynamic>;
};
