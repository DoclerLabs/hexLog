package hex.log.configuration;
import hex.log.ILogger;
import hex.log.LoggerConfig;
import hex.log.filter.IFilter;
import hex.log.filter.IFilterable;
import hex.log.target.ILogTarget;
/**
 * @author ...
 */

interface IConfiguration extends IFilterable
{
	
	function addLogger(name:String, config:LoggerConfig):Void;
	
	function addLogTarget(target:ILogTarget):Void;
	
	function getLoggerConfig(name:String):LoggerConfig;
	
	function getFilter():IFilter;
	
	function addLoggerLogTarget(logger:ILogger, target:ILogTarget):Void;
	
	function getLoggers():Map<String, LoggerConfig>;
	
	function getRootLogger():LoggerConfig;
	
}