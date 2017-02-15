package hex.log2;
import hex.log2.ILogger;
import hex.log2.configuration.IConfiguration;
import hex.log2.message.IMessageFactory;
import hex.log2.LogManager.ClassInfo;
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