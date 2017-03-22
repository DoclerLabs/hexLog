package hex;
import hex.log.AbstractLoggerTest;
import hex.log.ConfigurationTest;
import hex.log.GlobalFunctionsTest;
import hex.log.LogManagerTest;
import hex.log.LoggerTest;
import hex.log.LoggerTestParenting;
import hex.log.TraceEverythingConfigurationTest;
import hex.log.filter.FiltersSuite;
import hex.log.message.ParameterizedMessageTest;

/**
 * ...
 * @author ...
 */
class HexLogSuite 
{

	@Suite( "HexLog suite" )
    public var list : Array<Class<Dynamic>> = [
		LogManagerTest,
		AbstractLoggerTest,
		LoggerTest,
		ParameterizedMessageTest,
		LoggerTestParenting,
		FiltersSuite,
		ConfigurationTest,
		GlobalFunctionsTest,
		TraceEverythingConfigurationTest
	];

}