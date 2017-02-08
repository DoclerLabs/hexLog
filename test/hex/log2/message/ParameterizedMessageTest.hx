package hex.log2.message;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author ...
 */
class ParameterizedMessageTest 
{

	public function new() 
	{
	}
	
	public static var parameters:Array<Array<Dynamic>> = [
		["Test message {}", null, "Test message {}"],
		["Test message {}", [], "Test message {}"],
		["", null, ""],
		["", [], ""],
		["d", null, "d"],
		["d", [], "d"],
		["{}", null, "{}"],
		["{}", [], "{}"],
		["{}", ["a"], "a"],
		["{}", [null], "null"],
		["{           }", ["a"], "a"],
		["Test message {}{} {}", ["a", "b", "c"], "Test message ab c"],
		["Test message {}{} {}", [null, null, null], "Test message nullnull null"],
		["Test message {}{} {}", [null, "b", null], "Test message nullb null"],
		["Test message {} {} {} {} {}", ["a", null, "c", null, null], "Test message a null c null null"],
		["Test message {}{} {}Text", ["a", "b", "c"], "Test message ab cText"],
		["Test message {}{} {}", ["a", "b", "c", "unnecessary", "superfluous"], "Test message ab c"],
		["Test message {}{} {}", ["a", "b"], "Test message ab null"]
	];
	
	@Test("Test parameters replacement")
	@DataProvider("parameters")
	public function testParameters(message:String, params:Array<Dynamic>, expectedMessage:String)
	{
		var msg = new ParameterizedMessage(message, params);
		var result = msg.getFormattedMessage();
		Assert.equals(expectedMessage, result, "Messages must be the same");
	}
	
	
}