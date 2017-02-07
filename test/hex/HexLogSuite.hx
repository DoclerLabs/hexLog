package hex;
import hex.log2.AbstractLoggerTest;
import hex.log2.LogManagerTest;

/**
 * ...
 * @author ...
 */
class HexLogSuite 
{

	@Suite( "HexLog suite" )
    public var list : Array<Class<Dynamic>> = [ LogManagerTest, AbstractLoggerTest ];

}