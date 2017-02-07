package hex.log2.configuration;
import hex.log2.ILogger;
import hex.log2.LoggerConfig;
import hex.log2.filter.AbstractFilterable;
import hex.log2.filter.IFilter;
import hex.log2.target.ILogTarget;
import hex.log2.util.NameUtil;

/**
 * ...
 * @author ...
 */
class BasicConfiguration extends AbstractFilterable implements IConfiguration 
{

	var root:LoggerConfig = RootLogger.createLogger();
	var loggerConfigs:Map<String, LoggerConfig> = new Map<String, LoggerConfig>();
	
	public function new() 
	{
		super();
	}
	
	public function addTarget(target:ILogTarget):Void
	{
		
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
}