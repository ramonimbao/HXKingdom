package ;

import flixel.FlxSprite;
import flixel.FlxG;

class Coinsack extends FlxSprite
{

	public static inline var FADE_TIME:Float = 20;
	public var t:Float;
	
	public function new(X:Float = 0, Y:Float = 0)
	{
		super(X, Y);
		
		loadGraphic("assets/gfx/sack.png", true, false, 16, 16);
		scrollFactor.x = scrollFactor.y = 0;
		animation.add('blink', [8, 0, 8, 0, 8, 0, 8, 0, 8, 0], 5, false);
		
	}
	
	public function show(c:Int):Void
	{
		if (c == 0)
		{
			animation.play('blink', true);
		}
		else if (c == 1)
		{
			animation.frameIndex = 1;
		}
		else if (c >= 2 && c <= 3)
		{
			animation.frameIndex = 2;
		}
		else if (c >= 4 && c <= 5)
		{
			animation.frameIndex = 3;
		}
		else if (c >= 6 && c <= 8)
		{
			animation.frameIndex = 4;
		}
		else if (c >= 9 && c <= 11)
		{
			animation.frameIndex = 5;
		}
		else if (c >= 12 && c <= 15)
		{
			animation.frameIndex = 6;
		}
		else if (c >= 15)
		{
			animation.frameIndex = 7;
		}
		t = 0;
	}
	
	override public function update():Void
	{
		t += FlxG.elapsed;
		alpha = FADE_TIME - t;
	}
}