package hex.log2.target;
import hex.log2.layout.ILayout;
import hex.log2.LogEvent;

/**
 * ...
 * @author Francis Bourre
 */
interface ILogTarget
{
    /**
	 * Triggered when a Log event is dispatched by the Logging API.
	 * @see Logger
	 */
    function onLog( message : LogEvent ) : Void;
	
	function getLayout():ILayout;
	
	function getName():String;
}