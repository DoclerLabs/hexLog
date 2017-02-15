package hex.log2;

/**
 * ...
 * @author Francis Bourre
 */
class LogLevel
{
    static var _ALL 	= new LogLevel( 9999999 );
    static var _DEBUG 	= new LogLevel( 5000 );
    static var _INFO 	= new LogLevel( 4000 );
    static var _WARN 	= new LogLevel( 3000 );
    static var _ERROR 	= new LogLevel( 2000 );
    static var _FATAL 	= new LogLevel( 1000 );
    static var _OFF 	= new LogLevel( 0 );
	
	@:isVar public static var LEVELS( get, null ) : Array<LogLevel>;
	static function get_LEVELS() : Array<LogLevel>
    {
        return [ LogLevel._ALL, LogLevel._DEBUG, LogLevel._INFO, LogLevel._WARN, LogLevel._ERROR, LogLevel._FATAL, LogLevel._OFF ];
    }

    @:isVar public static var ALL( get, null ) : LogLevel;
    inline static function get_ALL() : LogLevel
    {
        return LogLevel._ALL;
    }

    @:isVar public static var DEBUG( get, null ) : LogLevel;
    inline static function get_DEBUG() : LogLevel
    {
        return LogLevel._DEBUG;
    }

    @:isVar public static var INFO( get, null ) : LogLevel;
    inline static function get_INFO() : LogLevel
    {
        return LogLevel._INFO;
    }

    @:isVar public static var WARN( get, null ) : LogLevel;
    inline static function get_WARN() : LogLevel
    {
        return LogLevel._WARN;
    }

    @:isVar public static var ERROR( get, null ) : LogLevel;
    inline static function get_ERROR() : LogLevel
    {
        return LogLevel._ERROR;
    }

    @:isVar public static var FATAL( get, null ) : LogLevel;
    inline static function get_FATAL() : LogLevel
    {
        return LogLevel._FATAL;
    }

    @:isVar public static var OFF( get, null ) : LogLevel;
    inline static function get_OFF() : LogLevel
    {
        return LogLevel._OFF;
    }

    @:isVar public var value( get, null ) : Int;
    function get_value() : Int
    {
        return this.value;
    }

    public function new( value : Int )
    {
        this.value = value;
    }
	
	public function toString() : String
	{
		switch( this.value )
		{
			case 9999999 :
				return "ALL";
			case 5000 :
				return "DEBUG";
			case 4000 :
				return "INFO";
			case 3000 :
				return "WARN";
			case 2000 :
				return "ERROR";
			case 1000 :
				return "FATAL";
			case 0 :
				return "OFF";
		}
		
		return "";
	}
}