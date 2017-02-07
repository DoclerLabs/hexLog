package hex.log2.util;

/**
 * ...
 * @author ...
 */
class NameUtil 
{
	public static function getSubName(name:String):String
	{
		if (name == null || name == "") {
			return null;
		}
		var i = name.lastIndexOf(".");
		return i > 0 ? name.substring(0, i) : "";
	}
}