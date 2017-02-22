package hex.log2;

import haxe.PosInfos;
import hex.log2.message.IMessage;

/**
 * ...
 * @author Francis Bourre
 */
class LogEvent
{
	public var message:IMessage;
	public var level:LogLevel;
	public var posInfos:PosInfos;
	public var logger:ILogger;

	public function new( logger:ILogger, message : IMessage, level : LogLevel, ?posInfos : PosInfos )
	{
		this.logger = logger;
		this.message = message;
		this.level = level;
		this.posInfos = posInfos;
	}
}