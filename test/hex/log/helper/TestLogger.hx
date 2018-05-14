package hex.log.helper;
import hex.log.LogLevel;
import hex.log.LoggerContext;
import hex.log.internal.AbstractLogger;
import hex.log.message.IMessage;
import hex.log.message.IMessageFactory;
import hex.log.message.ParameterizedMessageFactory;

class TestLogger extends Logger
{
	
	public var entries(default, null):List<String>;
	
	public function new(context:LoggerContext, name:String, messageFactory:IMessageFactory) 
	{
		super(context, name, messageFactory == null ? ParameterizedMessageFactory.instance : messageFactory);
		this.name = name;
		entries = new List<String>();
	}
	
	public function getMessageFactory():IMessageFactory
	{
		return messageFactory;
	}
	
	override public function logEnabledMessage(level:LogLevel, message:IMessage, ?posInfos:PosInfos):Void 
	{
		var buffer = new StringBuf();
		buffer.add(level.toString());
		buffer.add(" ");
		buffer.add(message.getFormattedMessage());
		
		var msg = buffer.toString();
		entries.add(msg);
		trace(msg);
	}
	
	override public function isEnabled(level:LogLevel, message:Dynamic, ?params:Array<Dynamic>, ?posInfos:PosInfos):Bool 
	{
		return true;
	}
	
	override public function isMessageEnabled(level:LogLevel, message:IMessage, ?posInfos:PosInfos):Bool 
	{
		return true;
	}
	
	override public function getLevel():LogLevel 
	{
		return LogLevel.ALL;
	}
	
}