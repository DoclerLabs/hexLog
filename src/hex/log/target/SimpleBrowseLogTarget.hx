package hex.log.target;
import hex.log.filter.IFilter;
import hex.log.layout.ILayout;

#if js
import haxe.PosInfos;
import hex.domain.Domain;
import hex.error.NullPointerException;
import hex.log.LogLevel;
import hex.log.LogEvent;
import js.Browser;
import js.html.Element;
import js.html.SpanElement;

/**
 * ...
 * @author Francis Bourre
 */
class SimpleBrowseLogTarget extends AbstractLogTarget
{
	var _console 		: Element;
	var _levelStyle		: Map<Int, String>;
	
	var _levelDisplay	: Bool = true;
	var _domainDisplay	: Bool = true;
	var _timeDisplay	: Bool = true;
	
	public function new( name:String, filter:IFilter = null, targetID : String = "console", leveldisplay : Bool = true, domainDisplay : Bool = true, timeDisplay : Bool = true ) 
	{
		super(name, filter, null);
		this._setConsole( targetID );
		this.setDomainDisplay( domainDisplay );
		this.setLevelDisplay( leveldisplay );
		this.setDisplayTime( timeDisplay );
		
		this._createLevelStyle();
	}
	
	public function setLevelDisplay( b : Bool ) : Void
	{
		this._levelDisplay = b;
	}
	
	public function setDomainDisplay( b : Bool ) : Void
	{
		this._domainDisplay = b;
	}
	
	public function setDisplayTime( b : Bool ) : Void
	{
		this._timeDisplay = b;
	}
	
	function _createLevelStyle() 
	{
		this._levelStyle = new Map();
		
		this._levelStyle.set( LogLevel.DEBUG, "lightgrey" );
		this._levelStyle.set( LogLevel.INFO, "green" );
		this._levelStyle.set( LogLevel.WARN, "yellow" );
		this._levelStyle.set( LogLevel.ERROR, "orange" );
		this._levelStyle.set( LogLevel.FATAL, "red" );
	}
	
	function _setConsole( targetId : String ) : Void
	{
		this._console = Browser.document.querySelector( targetId );
		
		if ( this._console == null )
		{
			throw new NullPointerException( "Div named '" + targetId + "' was not found in '" + this + "'" );
		}

		this._console.style.whiteSpace 			= "pre";
		this._console.style.fontFamily 			= "Lucida Console";
		this._console.style.fontSize 			= "11px";
	}

	override function logInternal( event : LogEvent ) : Void 
	{
		var message : String = event.message.getFormattedMessage();
		var level : Int = event.level;
		//var eventDomain : Domain = event.domain;
		var posInfos : PosInfos = event.posInfos;
		
		var leftBracket = this._createElement( "[", this._getStyle( level ) );
		var rightBracket = this._createElement( "]", this._getStyle( level ) );
		var time = this._createElement( this._getTime(), this._getStyle( level ) );
		var levelName = this._createElement( event.level.toString(), this._getStyle( level ) + "+bold" );
		//var domainName : String = ( eventDomain != null && eventDomain.getName() != null ) ?  "@" + eventDomain.getName() : "";
		//var domain = this._createElement( domainName, this._getStyle( level ) );
		var message = this._createElement( "\t\t" + message, this._getStyle( level ) );
		var info = this._createElement( posInfos != null ? " at " + posInfos.className + "::" + posInfos.methodName + " line " + posInfos.lineNumber + " in file " + posInfos.fileName : "", this._getStyle( level ) );
		
		this._log( this._getEncapsulateElements( [ leftBracket, levelName, rightBracket, message, info] ) );
	}
	
	public function onClear() : Void 
	{
		this._console.innerHTML = "";
	}
	
	function _getTime() : String
	{
		return "" + Date.now().getTime();
	}
	
	function _getStyle( level : Int ) : String
	{
		return this._levelStyle.get( level );
	}
	
	function _log( element : Element ) : Void
    {
        element.style.marginLeft = "10px";
		element.appendChild( Browser.document.createTextNode("\n") );
		this._console.appendChild( element );
		this._console.scrollTop = this._console.scrollHeight;
    }
	
	function _createElement( message : String, ?color : String ) : Element
    {
		var span : SpanElement = Browser.document.createSpanElement();
		span.innerHTML = message;
		if ( color != null ) this._setAttributes( span, color );
        return span;
    }
	
	function _getEncapsulateElements( elementList : Array<Element> ) : Element
	{
		var container : SpanElement = Browser.document.createSpanElement();
		
		for ( element in elementList )
		{
			container.appendChild( element );
		}
		
		return container;
	}
	
	function _setAttributes( element : Element, color : String ) : Void
	{
		var colorAttributes : Array<String> = color.split( "+" );
        for ( attr in colorAttributes )
        {
            this._setAttribute( element, attr );
        }
	}
	
	function _setAttribute( element:Element, attr:String ) : Void
	{
        switch( attr )
        {
            case "bold":
                element.style.fontWeight = "bold";

            case "red":
                element.style.color = "#e62323"; 
				
			case "orange":
                element.style.color = "#FF8000";
				
			case "yellow":
                element.style.color = "#ffcf18";
				
			case "lightgrey":
				element.style.color = "#d9d9d9";
				
			case "green":
                element.style.color = "#27fe11";
        }
    }
}
#end