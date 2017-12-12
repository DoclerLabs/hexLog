package hex.log.message;
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
	
	public static var parameters:Array<{message:String, params:Array<Dynamic>, expectedMessage:String}> = [
		{message:"Test message {}", params:null, expectedMessage:"Test message {}"},
		{message:"Test message {}", params:[], expectedMessage:"Test message null"},
		{message:"", params:null, expectedMessage:""},
		{message:"", params:[], expectedMessage:""},
		{message:"d", params:null, expectedMessage:"d"},
		{message:"d", params:[], expectedMessage:"d"},
		{message:"{}", params:null, expectedMessage:"{}"},
		{message:"{}", params:[], expectedMessage:"null"},
		{message:"{}", params:["a"], expectedMessage:"a"},
		{message:"{}", params:[null], expectedMessage:"null"},
		{message:"{           }", params:["a"], expectedMessage:"a"},
		{message:"Test message {}{} {}", params:["a", "b", "c"], expectedMessage:"Test message ab c"},
		{message:"Test message {}{} {}", params:[null, null, null], expectedMessage:"Test message nullnull null"},
		{message:"Test message {}{} {}", params:[null, "b", null], expectedMessage:"Test message nullb null"},
		{message:"Test message {} {} {} {} {}", params:["a", null, "c", null, null], expectedMessage:"Test message a null c null null"},
		{message:"Test message {}{} {}Text", params:["a", "b", "c"], expectedMessage:"Test message ab cText"},
		{message:"Test message {}{} {}", params:["a", "b", "c", "unnecessary", "superfluous"], expectedMessage:"Test message ab c"},
		{message:"Test message {}{} {}", params:["a", "b"], expectedMessage:"Test message ab null"}
	];
	
	@Test("Test parameters replacement")
	@DataProvider("parameters")
	public function testParameters(o:{message:String, params:Array<Dynamic>, expectedMessage:String})
	{
		var msg = new ParameterizedMessage(o.message, o.params);
		var result = msg.getFormattedMessage();
		Assert.equals(o.expectedMessage, result, "Messages must be the same");
	}
}