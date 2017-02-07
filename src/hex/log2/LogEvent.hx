package hex.log2;

import haxe.PosInfos;
import hex.domain.Domain;
import hex.event.MessageType;
import hex.log2.message.IMessage;

/**
 * ...
 * @author Francis Bourre
 */
class LogEvent
{
	public var message 	: IMessage;
	public var level 	: LogLevel;
	public var domain 	: Domain;
	public var posInfos : PosInfos;
	
	public function new( message : IMessage, level : LogLevel, ?domain : Domain, ?posInfos : PosInfos ) 
	{
		this.message 	= message;
		this.level 		= level;
		this.domain 	= domain;
		this.posInfos 	= posInfos;
	}
}