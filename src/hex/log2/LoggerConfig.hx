package hex.log2;
import hex.log2.LogLevel;
import hex.log2.LogEvent;
import hex.log2.configuration.IConfiguration;
import hex.log2.filter.AbstractFilterable;
import hex.log2.filter.IFilter;
import hex.log2.filter.IFilterable;
import hex.log2.target.ILogTarget;

/**
 * ...
 * @author ...
 */
class LoggerConfig extends AbstractFilterable
{

	public var name(default, null):String;
	@:isVar public var level(get, set):LogLevel;
	public var parent(default, default):LoggerConfig;
	var logTargets:Array<LogTargetControl>;
	var config:IConfiguration;
	
	public function new(name:String = null, logLevel:LogLevel = null, config:IConfiguration = null) 
	{
		super();
		this.config = config;
		this.name = name;
		this.level = logLevel;
		logTargets = new Array<LogTargetControl>();
	}
	
	function set_level(value:LogLevel):LogLevel 
	{
		return level = value;
	}
	
	function get_level():LogLevel 
	{
		return level == null ? parent.level : level;
	}
	
	public function addAppender(logTarget:ILogTarget, level:LogLevel, filter:IFilter):Void
	{
		logTargets.push(new LogTargetControl(logTarget, level, filter));
	}
	
	public function removeLogTarget(name:String):Void
	{
		for (control in logTargets)
		{
			if (control.logTargetName == name)
			{
				control.removeFilter(control.getFilter());
				break;
			}
		}
	}
	
	public function log(event:LogEvent):Void
	{
		if (!isFiltered(event))
		{
            processLogEvent(event);
        }
	}
	
	function processLogEvent(event:LogEvent) 
	{
		callLogTargets(event);
        logParent(event);
	}
	
	function logParent(event:LogEvent):Void
	{
        if (/*additive && */parent != null) {
            parent.log(event);
        }
    }

    function callLogTargets(event:LogEvent):Void
	{
        logTargets.map(function (control:LogTargetControl):Void{
			control.callLogTarget(event);
		});
    }
	
	public static function createLogger(name:String, level:LogLevel, config:IConfiguration, filter:IFilter):LoggerConfig
	{
        var loggerName = name == "root" ? "" : name;
		return new LoggerConfig(name, level, config);
	}
	
}

class RootLogger extends LoggerConfig
{
	public static function createLogger(?level:LogLevel):LoggerConfig
	{
		var actualLevel:LogLevel = level == null ? LogLevel.ERROR : level;
		return new LoggerConfig("root", actualLevel);
	}
}

class LogTargetControl extends AbstractFilterable
{
	public var logTarget(default,null):ILogTarget;
	public var logTargetName(default,null):String;
	var level:LogLevel;
	var intLevel:Int;
	
	public function new(logTarget:ILogTarget, level:LogLevel, filter:IFilter) 
	{
		super(filter);
		this.filter = filter;
		this.level = level;
		this.intLevel = level.value;
		this.logTarget = logTarget;
		this.logTargetName = logTarget.getName();
	}
	
	public function callLogTarget(event:LogEvent):Void
	{
		if (shouldSkip(event))
		{
			return;
		}
		logTarget.onLog(event);
	}
	
    function shouldSkip(event:LogEvent):Bool
	{
        return isFilteredByAppenderControl(event) || isFilteredByLevel(event);
    }

    function isFilteredByAppenderControl(event:LogEvent):Bool
	{
        var filter = getFilter();
        return filter != null && FilterResult.DENY == filter.filterEvent(event);
    }

    function isFilteredByLevel(event:LogEvent):Bool
	{
        return level != null && intLevel < event.level.value;
    }
	
}