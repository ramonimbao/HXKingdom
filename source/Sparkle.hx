package ;

import flash.geom.Point;

import flixel.effects.particles.FlxParticle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.FlxSprite;

class Sparkle extends FlxParticle
{

	public function new()
	{
		super();
		loadGraphic("assets/gfx/sparkle.png", true);
		animation.add("splash", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], 30, false);
	}

	override public function reset(X:Float, Y:Float):Void
	{
		super.reset(X, Y);
		lifespan = 1.0;
		animation.play("splash", true);
	}

}
