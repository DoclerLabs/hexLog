package hex.log;
import hex.log.ILogger;
import hex.log.configuration.IConfiguration;
import hex.log.message.IMessageFactory;
/**
 * @author ...
 */

interface ILoggerContext 
{
	
	function getLogger(name:String, ?messageFactory:IMessageFactory):ILogger;
	
	function getConfiguration():IConfiguration;
	
	function updateLoggers():Void;
	
	
}