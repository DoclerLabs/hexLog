# Log targets

## LogTarget

The ability to selectively enable or disable logging requests based on their logger is only part of the picture. hexLog allows logging requests to be printed to multiple destinations. In hexLog speak, an output destination is called LogTarget.

**Each enabled logging request for a given logger will be forwarded to all the log targets in that Logger's LoggerConfig as well as LogTargets of the LoggerConfig's parents.** In other words, LogTargets are inherited additively from the LoggerConfig hierarchy. For example, if a trace log target is added to the root logger, then all enabled logging requests will be at least traced. If in addition another log target is added to a LoggerConfig, say *C*, then enabled logging requests for *C* and *C*'s children will print to that log target *and* to the trace output.

## ILogTarget implementations

### AbstractLogTarget

AbstractLogTarget should be used as a base for all ILogTarget implementations as it already contains logic for basic filtering.

### TraceLogTarget

The simplest LogTarget imaginable - it uses `haxe.Log.trace()` as an output, nothing more nothing less.

### JavascriptConsoleLogTarget

**JS only**

Uses `js.Browser.console.log`/`debug`/`info`/`warn`/`error` for output based on the severity of the event.

### SimpleBrowseLogTarget

**JS only**

Contains customized output which is rendered to a specific div in a HTML page.