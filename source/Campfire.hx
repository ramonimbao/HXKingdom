package ;

import flixel.FlxSprite;
import flixel.FlxG;

class Campfire extends Light
{

	public function new(X:Float, Y:Float)
	{
		Y -= 12;

		super(X, Y);

		offset.x = 16;
		offset.y = 52;
		loadGraphic("assets/gfx/campfire.png", false, 32, 64);
		beam.loadGraphic("assets/gfx/light_large.png");
		reflected.loadGraphic("assets/gfx/light_reflect_wide.png");
		reflected.color = 0xFFFC8F53;
		animation.add("on", [0, 1, 2, 3, 4, 5, 6, 7], 10, true);
		animation.callback = this.dim;
		animation.play("on");
		setLight();
	}

}
