package hex.log.target;
import hex.log.layout.ILayout;
import hex.log.LogEvent;

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