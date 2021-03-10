package hex.log.internal;

import hex.log.IExtendedLogger;
import hex.log.ILoggerContext;
import hex.log.LogLevel;
import hex.log.message.IMessage;
import hex.log.message.IMessageFactory;
import hex.log.message.ParameterizedMessageFactory;

/**
 * ...
 * @author ...
 */
class AbstractLogger implements IExtendedLogger
{

	var messageFactory:IMessageFactory;
	
	public function new(?messageFactory:IMessageFactory) 
	{
		this.messageFactory = (messageFactory == null) ? ParameterizedMessageFactory.instance : messageFactory;
	}
	
	public function log(level:LogLevel, message:Dynamic, ?params:Array<Dynamic>, ?posInfos:PosInfos):Void 
	{
		logIfEnabled(level, message, params, posInfos);
	}
	
	public function logMessage(level:LogLevel, message:IMessage, ?posInfos:PosInfos):Void 
	{
		logMessageIfEnabled(level, message, posInfos);
	}
	
	public function debug(message:Dynamic, ?params:Array<Dynamic>, ?posInfos:PosInfos):Void 
	{
		logIfEnabled(LogLevel.DEBUG, message, params, posInfos);
	}
	
	public function debugMessage(message:IMessage, ?posInfos:PosInfos):Void 
	{
		logMessageIfEnabled(LogLevel.DEBUG, message, posInfos);
	}
	
	public function info(message:Dynamic, ?params:Array<Dynamic>, ?posInfos:PosInfos):Void 
	{
		logIfEnabled(LogLevel.INFO, message, params, posInfos);
	}
	
	public function infoMessage(message:IMessage, ?posInfos:PosInfos):Void 
	{
		logMessageIfEnabled(LogLevel.INFO, message, posInfos);
	}
	
	public function warn(message:Dynamic, ?params:Array<Dynamic>, ?posInfos:PosInfos):Void 
	{
		logIfEnabled(LogLevel.WARN, message, params, posInfos);
	}
	
	public function warnMessage(message:IMessage, ?posInfos:PosInfos):Void 
	{
		logMessageIfEnabled(LogLevel.WARN, message, posInfos);
	}
	
	public function error(message:Dynamic, ?params:Array<Dynamic>, ?posInfos:PosInfos):Void 
	{
		logIfEnabled(LogLevel.ERROR, message, params, posInfos);
	}
	
	public function errorMessage(message:IMessage, ?posInfos:PosInfos):Void 
	{
		logMessageIfEnabled(LogLevel.ERROR, message, posInfos);
	}
	
	public function fatal(message:Dynamic, ?params:Array<Dynamic>, ?posInfos:PosInfos):Void 
	{
		logIfEnabled(LogLevel.FATAL, message, params, posInfos);
	}
	
	public function fatalMessage(message:IMessage, ?posInfos:PosInfos):Void 
	{
		logMessageIfEnabled(LogLevel.FATAL, message, posInfos);
	}
	
	public function logIfEnabled(level:LogLevel, message:Dynamic, ?params:Array<Dynamic>, ?posInfos:PosInfos):Void
	{
		if (isEnabled(level, message, params, posInfos))
		{
			if(Std.isOfType(message, String) || message == null)
			{
				logEnabledMessage(level, messageFactory.newMessage(message, params), posInfos);
			}
			else
			{
				logEnabledMessage(level, messageFactory.newObjectMessage(message), posInfos);
			}
		}
	}
	
	public function logMessageIfEnabled(level:LogLevel, message:IMessage, ?posInfos:PosInfos):Void
	{
		if (isMessageEnabled(level, message, posInfos))
		{
			logEnabledMessage(level, message, posInfos);
		}
	}
	
	public function logEnabledMessage(level:LogLevel, message:IMessage, ?posInfos:PosInfos):Void
	{
		throw "This method must be implemented";
	}
	
	public function isLevelEnabled(level:LogLevel):Bool 
	{
		return isEnabled(level, null);
	}
	
	public function isEnabled(level:LogLevel, message:Dynamic, ?params:Array<Dynamic>, ?posInfos:PosInfos):Bool
	{
		throw "This method must be implemented";
	}
	
	public function isMessageEnabled(level:LogLevel, message:IMessage, ?posInfos:PosInfos):Bool
	{
		throw "This method must be implemented";
	}
	
	public function getLevel():LogLevel 
	{
		throw "This method must be implemented";
	}
	
	public function getName():String 
	{
		throw "This method must be implemented";
	}
	
	public function getContext():ILoggerContext 
	{
		throw "This method must be implemented";
	}
	
}
