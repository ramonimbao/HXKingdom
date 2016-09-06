package ;

import flash.geom.Point;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.FlxSprite;

class CoinFloat extends FlxSprite
{

	public function new()
	{
		super();

		loadGraphic("assets/gfx/coin_drop.png", false, 10, 24);
		animation.add("spin", [0, 1, 2, 3, 4, 5, 6, 7], 10, true);
		animation.play("spin");
	}

	public function float(above:FlxSprite):Void
	{
		acceleration.y = 0;
		x = above.x + above.width / 2 - width / 2;
		y = Math.max(above.y - height - 4, 40);
		above.color = 0xCCCC00;
	}

}
