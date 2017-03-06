package hex.log;
import hex.log.ILogger;
import hex.log.configuration.IConfiguration;
import hex.log.message.IMessageFactory;
import hex.log.LogManager.ClassInfo;
/**
 * @author ...
 */

interface ILoggerContext 
{
	
	function getLoggerByClassInfo(classInfo:ClassInfo, ?messageFactory:IMessageFactory):ILogger;
	
	function getLogger(name:String, ?messageFactory:IMessageFactory):ILogger;
	
	function getConfiguration():IConfiguration;
	
	function updateLoggers():Void;
	
	
}