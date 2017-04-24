package hex.log.helper;
import haxe.macro.Expr;
import haxe.macro.Expr.ExprOf;
import hex.log.LogEvent;
import hex.log.MacroLoggerContext;
import hex.log.configuration.MacroConfiguration;
import hex.log.layout.MacroLogLayout;
import hex.log.message.ExpressionMessage;
import hex.log.message.ExpressionMessageFactory;
import hex.log.message.IMessage;
import hex.log.message.ObjectMessage;
import hex.log.message.ParameterizedMessage;

/**
 * ...
 * @author ...
 */
class MacroContextTester 
{

	public function new() 
	{
	}
	
	public static macro function getLayoutTest():Expr
	{
		var exprs = [];
		
		var layout = new MacroLogLayout();
		
		var message1 = new ObjectMessage({});
		exprs.push(macro hex.unittest.assertion.Assert.equals("DEBUG : {}", $v{layout.toString(getEvent(message1))}, "ObjectMessage must be properly formatted" ));
		
		var message2 = new ParameterizedMessage("Hello", null);
		exprs.push(macro hex.unittest.assertion.Assert.equals("DEBUG : Hello", $v{layout.toString(getEvent(message2))}, "ParameterizedMessage must be properly formatted" ));
		
		var message3 = new ParameterizedMessage("Hello {}", ["World"]);
		exprs.push(macro hex.unittest.assertion.Assert.equals("DEBUG : Hello World", $v{layout.toString(getEvent(message3))}, "ParameterizedMessage with parameters must be properly formatted" ));
		
		var message4 = new ExpressionMessage(macro true == false);
		exprs.push(macro hex.unittest.assertion.Assert.equals("true == false", $v{layout.toString(getEvent(message4))}, "ExpressionMessage must be properly formatted" ));
		
		return macro $a{exprs};
	}
	
	static function getEvent(message:IMessage)
	{
		return new LogEvent(null, message, LogLevel.DEBUG);
	}
	
	public static macro function getMessageFactoryTest():Expr
	{
		var exprs = [];
		
		var factory = ExpressionMessageFactory.instance;
		
		var message1 = factory.newObjectMessage("hello");
		exprs.push(macro hex.unittest.assertion.Assert.isTrue($v{Std.is(message1, ObjectMessage)}, "Factory must create ObjectMessage" ));
		
		var message2 = factory.newObjectMessage(macro true == false);
		exprs.push(macro hex.unittest.assertion.Assert.isTrue($v{Std.is(message2, ExpressionMessage)}, "Factory must create ExpressionMessage" ));
		
		var message3 = factory.newObjectMessage({});
		exprs.push(macro hex.unittest.assertion.Assert.isTrue($v{Std.is(message3, ObjectMessage)}, "Factory must create ObjectMessage" ));
		
		var message4 = factory.newMessage("hello");
		exprs.push(macro hex.unittest.assertion.Assert.isTrue($v{Std.is(message4, ParameterizedMessage)}, "Factory must create ParameterizedMessage" ));
		
		return macro $a{exprs};
	}
	
	public static macro function getContextTest():Expr
	{
		var exprs = [];
		var context = new MacroLoggerContext();
		exprs.push(macro hex.unittest.assertion.Assert.isTrue($v{Std.is(context.getConfiguration(), MacroConfiguration)}, "MacroLoggerContext must contain MacroConfiguration" ));
		return macro $a{exprs};
	}
	
}