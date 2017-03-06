# hexLog [![TravisCI Build Status](https://travis-ci.org/DoclerLabs/hexLog.svg?branch=master)](https://travis-ci.org/DoclerLabs/hexLog)

hexLog contains logging system inspired by log4j written in Haxe

*Find more information about hexMachina on [hexmachina.org](http://hexmachina.org/)*

# Architecture

## Main components
Applications using hexLog API will request a logger with a specific name from the LogManager. The LogManager will locate the appropriate LoggerContext and then obtain the Logger from it. If the Logger must be created it will be associated with the LoggerConfig that contains either: a) the same name as the Logger, b) the name of a parent package, or c) the root LoggerConfig. LoggerConfig objects are created from Logger declarations in the configuration. The LoggerConfig is associated with the LogTargets that actually deliver the LogEvents.

### Logger hierarchy
The biggest advantage of using hexLog over standard `trace` is the ability to disable certain log statements while allowing other to be printed without any change. This capability assumes that the logging space, that is, the space of all possible logging statements, is categorized according to some developer-chosen criteria.
Loggers and LoggerConfigs are named entities. Logger names are case-sensitive and they follow hierarchical naming rule.

> #### Naming hierarchy
> A loggerConfig is said to be an *ancestor* of another LoggerConfig if its name followed by a dot (`.`) is a prefix of a *descendant* logger name. A LoggerConfig is said to be a *parent* of a *child* LoggerConfig if there are no ancestors between itself and the descendant LoggerConfig.

For example, the LoggerConfig named `"com.foo"` is a parent of the LoggerConfig named `"com.foo.Bar"`. Similarly, `"hex"` is a parent of `"hex.log"` and an ancestor of `"hex.log.Logger"`. This naming scheme should be familiar to most developers.
The root LoggerConfig resides at the top of the hierarchy. It's exceptional in that it always exists and is part of every hierarchy. A Logger that is directly linked to the roo LoggerConfig can be obtained as follows:
```haxe
var rootLogger = LogManager.getLogger("");
// or more simply
var rootLogger = LogManager.getRootLogger();
```
All other Loggers can be retrieved by using the `Logmanager.getLogger` static method by passing the name of the desired Logger.

### LoggerContext

The LoggerContext acts as the anchor point of the logging system. Currently it's not possible to have multiple LoggerContexts but you can change the LoggerContext implementation by changing the value of a static property `LogManager.context`

### Configuration

LoggerContext has an active `Configuration`. The Configuration contains all LogTargets, context-wide filters and LoggerConfigs.

### Logger

As stated previously, Logger can be created by calling `LogManager.getLogger`. The logger itself performs no direct actions. It simply has a name and is associated with a LoggerConfig. It extends AbstractLogger and implements the required methods. As the configuration is modified Loggers may become associated with a different LoggerConfig, thus causing their behavior to be modified.

#### Retrieving Loggers

Calling `LogManage.getLogger` method with the same name will always return a reference to the exact same Logger object.
That means:

```haxe
var x = LogManager.getLogger("something");
var y = LogManager.getLogger("something");
```
`x` and `y` refer to *exactly* the same Logger object. (`x == y` is always `true`)

Configuration of the hexLog environment is always done at application initialization.

hexLog makes it easy to name Loggers by *software component*. This can be accomplished by instantiating Logger in each class, with the Logger name equal to the fully qualified name of the class. This is a useful and straightforward method of defining loggers. As the log output bears the name of the generating Logger, this naming strategy makes it easy to identify the origin of the log message. However this is only one possible strategy of naming loggers and hexLog does not restrict the possible set of loggers. The developer is always free to name the loggers as desired.

### LoggerConfig

LoggerConfig objects are created when Loggers are declared in the logging configuration. The LoggerConfig contains set of Filters that must allow the LogEvent to pass before it will be passed to any LogTargets. It also contains reference to the set of LogTargets that should be used to process the event.

### Filter

In addition to automatic LogLevel filtering hexLog provides Filters that can be applied:
- before control is passed to any LoggerConfig
- after control is passed to a LoggerConfig but before calling **any** LogTargets
- after control is passed to a LoggerConfig but before calling **a specific** LogTarget
- on each LogTarget

[More information about filters and filtering](src/hex/log/filter/README.md)

### LogTarget

The ability to selectively enable or disable logging requests based on their logger is only part of the picture. hexLog allows logging requests to be printed to multiple destinations. In hexLog speak, an output destination is called LogTarget.

[More information about log targets](src/hex/log/target/README.md)

### Layout

More often than not, users wish to customize not only the output destination but also the output format. This is accomplished by associating a Layout with a LogTarget. The Layout is responsible for formatting the LogEvent to the user's wishes, whereas a log target takes care of sending the formatted output to its destination.

[More information about layouts](src/hex/log/layout/README.md)

### Message

Internally in the system every log statement is represented by a Message object.

[More information about messages](src/hex/log/message/README.md)

# Simple examples

## Logging

```haxe
// Getting logger
var logger = LogManager.getLogger("LoggerName");

// Logging simple message
logger.debug("Some message");

// Logging message with parameters
var name = "World";
logger.debug("Hello {}", [name]);
```

## Configuration

```haxe
// -- You can see this working in hex.log2.ConfigurationTest.hx

// Create a new configuration
var configuration = new BasicConfiguration();

// Create log targets
var traceTarget = new TraceLogTarget("Trace", null, new DefaultTraceLogLayout());

// Create a logger config and add targets
//(at this point we can also add filters to the configuration etc.)
var lc1:LoggerConfig = LoggerConfig.createLogger("hex", LogLevel.WARN, null, null); // Logger will only forward warnings and higher
lc1.addLogTarget(traceTarget, LogLevel.ALL, null); // Target will accept every event that arrives (in this case only warnings+ will be forwarded from the logger anyway)
configuration.addLogger(lc1.name, lc1); //Add logger config to the configuration

// Apply the configuration
LoggerContext.getContext().setConfiguration(configuration);

// Now you can request loggers and log as much you want and they will follow the rules set above
var logger = LogManager.getLogger("hex");
logger.debug("test"); // Fitered by config -> nothing will happen
logger.warn("test"); // will be logged

var logger2 = LogManager.getLogger("hex.log");
logger2.debug("test"); // Fitered by parent config -> nothing will happen
logger2.warn("test"); // will be logged

//NOTE: By default root logger is set to LogLevel.ERROR
var logger3 = LogManager.getLogger("something");
logger3.debug("test"); // Filtered by root logger -> nothing will happen
logger3.error("test"); // will be logged

```
