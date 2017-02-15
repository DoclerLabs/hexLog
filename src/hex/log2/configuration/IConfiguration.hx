package hex.log2.configuration;
import hex.log2.ILogger;
import hex.log2.LoggerConfig;
import hex.log2.filter.IFilter;
import hex.log2.filter.IFilterable;
import hex.log2.target.ILogTarget;
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