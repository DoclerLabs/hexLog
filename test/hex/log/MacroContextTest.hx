package hex.log;
import hex.log.helper.MacroContextTester;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author ...
 */
class MacroContextTest 
{

	public function new() 
	{
	}
	
	@Test("Test macro layout")
	public function testMacroLayout()
	{
		MacroContextTester.getLayoutTest();
	}
	
	@Test("Test expression message factory")
	public function testExpressionMessageFactory()
	{
		MacroContextTester.getMessageFactoryTest();
	}
	
	@Test("Test context")
	public function testContext()
	{
		MacroContextTester.getContextTest();
	}
}