package hex.log.message;

#if macro
import haxe.macro.Expr;
import haxe.macro.Printer;

class ExpressionMessage implements IMessage 
{
	var expr:Expr;
	var printer:Printer;
	
	public function new(expr:Expr) 
	{
		this.expr = expr;
		printer = new Printer();
	}
	
	public function getFormattedMessage():String 
	{
		return printer.printExpr(expr);
	}
	
	public function getFormat():String 
	{
		return null;
	}
	
	public function getParameters():Array<Dynamic> 
	{
		return null;
	}
}
#end