package hex;
import hex.log2.AbstractLoggerTest;
import hex.log2.LogManagerTest;
import hex.log2.LoggerTest;
import hex.log2.LoggerTestParenting;
import hex.log2.filter.AbstractFilterableTest;
import hex.log2.message.ParameterizedMessageTest;

/**
 * ...
 * @author ...
 */
class HexLogSuite 
{

	@Suite( "HexLog suite" )
    public var list : Array<Class<Dynamic>> = [ LogManagerTest, AbstractLoggerTest, LoggerTest, ParameterizedMessageTest, LoggerTestParenting, AbstractFilterableTest ];

}