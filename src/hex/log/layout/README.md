# Layouts

More often than not, users wish to customize not only the output destination but also the output format. This is accomplished by associating a Layout with a LogTarget. The Layout is responsible for formatting the LogEvent to the user's wishes, whereas a log target takes care of sending the formatted output to its destination.


### AbstractLayout

Every layout should extend this class which currently provides `haxe.PosInfos` formatting.

### MacroLogLayout

Differentiates between ExpressionMessage and every other message where for expressions it doesn't print any additional information except the expression itself. Particularly useful in macro context.
