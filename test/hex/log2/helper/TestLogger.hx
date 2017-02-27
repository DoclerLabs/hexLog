package hex.log2.helper;
import haxe.PosInfos;
import hex.log2.LogLevel;
import hex.log2.LoggerContext;
import hex.log2.internal.AbstractLogger;
import hex.log2.message.IMessage;
import hex.log2.message.IMessageFactory;
import hex.log2.message.ParameterizedMessageFactory;

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