package hex.log2;
import hex.log2.message.IMessage;

import haxe.PosInfos;
import hex.domain.Domain;
import hex.log2.LogLevel;

/**
 * @author Francis Bourre
 */
interface ILogger
{
	function debug( message:Dynamic, ?params:Array<Dynamic>, ?posInfos : PosInfos ) : Void;
	function debugMessage(message:IMessage, ?posInfos:PosInfos):Void;

	function info( message:Dynamic, ?params:Array<Dynamic>, ?posInfos : PosInfos ) : Void;
	function infoMessage(message:IMessage, ?posInfos:PosInfos):Void;
	
	function warn( message:Dynamic, ?params:Array<Dynamic>, ?posInfos : PosInfos ) : Void;
	function warnMessage(message:IMessage, ?posInfos:PosInfos):Void;
	
	function error( message:Dynamic, ?params:Array<Dynamic>, ?posInfos : PosInfos ) : Void;
	function errorMessage(message:IMessage, ?posInfos:PosInfos):Void;
	
	function fatal( message:Dynamic, ?params:Array<Dynamic>, ?posInfos : PosInfos ) : Void;
	function fatalMessage(message:IMessage, ?posInfos:PosInfos):Void;
	
	function log( level:LogLevel, message:Dynamic, ?params:Array<Dynamic>, ?posInfos : PosInfos ) : Void;
	function logMessage(level:LogLevel, message:IMessage, ?posInfos:PosInfos):Void;
	
	function getLevel():LogLevel;
	
	function getName():String;
	
}