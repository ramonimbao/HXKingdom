package mochi.haxe;

/* So far this appears to be the only MochiService
 * used by the game. Porting of the other mochi.haxe
 * packages may not be necessary.
 * 
 * And what is this used for? Encoding the day so it's
 * anti-cheat? idk
 * 
 * UPDATE: Yes. It's for encryption.
 * "MochiDigits provides a quick, and easy way for
 * developers to encode their sensitive numbers in memory."
 * --from http://www.mochimedia.com/support/dev_docs#digits_ov
*/

class MochiDigits
{
	private var Fragment:Int;
	private var Sibling:MochiDigits;
	private var Encoder:Float;
	
	public function new(digit:Float = 0, index:UInt=0):Void
	{
		Encoder = 0;
		setValue(digit, index);
	}
	
	public var value(get, set):Float;
	
	function get_value():Float
	{
		return Std.parseFloat(this.toString());
	}
	
	function set_value(v:Float):Float
	{
		setValue(v);
		return null;
	}
	
	public function addValue(inc:Float):Void
	{
		value += inc;
	}
	
	public function setValue(digit:Float = 0, index:UInt = 0):Void
	{
		var s:String = Std.string(digit);
		Fragment = s.charCodeAt(index++) ^ Std.int(Encoder);
		
		if (index < s.length)
		{
			Sibling = new MochiDigits(digit, index);
		}
		else
		{
			Sibling = null;
		}
		
		reencode();
	}
	
	public function reencode():Void
	{
		var newEncode:UInt = Std.int(0x7FFFFFFF * Math.random());
		
		Fragment ^= newEncode ^ Std.int(Encoder);
		Encoder = newEncode;
	}
	
	public function toString():String
	{
		var s:String = String.fromCharCode(Fragment ^ Std.int(Encoder));
		
		if (Sibling != null)
		{
			s += Sibling.toString();
		}
		
		return s;
	}
	
}