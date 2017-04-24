# Messages

## Message

Internally every log statement that is allowed to enter the system (passes initial Logger filtering) is a IMessage implementation.

## MessageFactory

Every Logger can be instantiated with a specific MessageFactory which will take care of creating internal message used by the system. For example if you're logging na *Orange* object often you might consider creating your own message factory implementation which will produce *OrangeMessage*s where you can control exactly how the *Orange* object will be serialized to the output.


## IMessage Implementations

### ExpressionMessage

Message takes `Expr` in constructor and uses `Printer` to output pretty printed expression.
