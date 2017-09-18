package hex.log.configuration;
import hex.log.ILogger;
import hex.log.LoggerConfig;
import hex.log.filter.AbstractFilterable;
import hex.log.filter.IFilter;
import hex.log.target.ILogTarget;
import hex.log.util.NameUtil;

/**
 * ...
 * @author ...
 */
class BasicConfiguration extends AbstractFilterable implements IConfiguration 
{

	var root:LoggerConfig;
	var loggerConfigs:Map<String, LoggerConfig>;
	var logTargets:Map<String, ILogTarget>;
	
	public function new() 
	{
		super();
		root = LoggerConfig.createRootLogger();
		root.level = LogLevel.ERROR;
		loggerConfigs = new Map<String, LoggerConfig>();
		logTargets = new Map<String, ILogTarget>();
	}
	
	public function addLogTarget(target:ILogTarget):Void
	{
		if (!logTargets.exists(target.getName()))
		{
			logTargets.set(target.getName(), target);
		}
	}
	
	public function getLogTargets():Map<String,ILogTarget>
	{
		return logTargets;
	}
	
	public function addLoggerLogTarget(logger:ILogger, target:ILogTarget)
	{
		var loggerName = logger.getName();
		addLogTarget(target);
		var config = getLoggerConfig(loggerName);
		if (config.name == loggerName)
		{
			config.addLogTarget(target, null, null);
		}
		else
		{
			var newConfig = LoggerConfig.createLogger(loggerName, config.level, this, null);
			newConfig.addLogTarget(target, null, null);
			newConfig.parent = config;
			if (!loggerConfigs.exists(loggerName))
			{
				loggerConfigs.set(loggerName, newConfig);
			}
			setParents();
			logger.getContext().updateLoggers();
		}
	}
	
	public function removeLogTarget(targetName:String)
	{
		for (config in loggerConfigs)
		{
			config.removeLogTarget(targetName);
		}
		logTargets.remove(targetName);
	}
	
	public function addLogger(name:String, config:LoggerConfig):Void
	{
		if(!loggerConfigs.exists(name))
		{
			loggerConfigs.set(name, config);
		}
		setParents();
	}
	
	function setParents() 
	{
		for (key in loggerConfigs.keys())
		{
			var logger = loggerConfigs.get(key);
			if (key != null && key != "")
			{
				var i = key.lastIndexOf(".");
				if (i > 0)
				{
					key = key.substring(0, i);
					var parent = getLoggerConfig(key);
					if (parent == null)
					{
						parent = root;
					}
					logger.parent = parent;
				}
				else
				{
					logger.parent = root;
				}
			}
		}
	}
	
	public function getLoggerConfig(name:String):LoggerConfig 
	{
		var config = loggerConfigs.get(name);
		if (config != null)
		{
			return config;
		}
		var substr = name;
		while ((substr = NameUtil.getSubName(substr)) != null)
		{
			config = loggerConfigs.get(substr);
			if (config != null)
			{
				return config;
			}
		}
		return root;
	}	
	
	public function getLoggers():Map<String, LoggerConfig> 
	{
		return loggerConfigs;
	}
	
	public function getRootLogger():LoggerConfig 
	{
		return root;
	}
}