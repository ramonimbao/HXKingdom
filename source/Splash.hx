package ;

import flash.geom.Point;

import flixel.effects.particles.FlxParticle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxPoint;
import flixel.FlxSprite;

class Splash extends FlxParticle
{

	public function new() 
	{
		super();
		loadGraphic("assets/gfx/splash.png", true);
		animation.add("splash", [0, 1, 2, 3, 4], 10);
	}
	
	override public function reset(X:Float, Y:Float):Void
	{
		super.reset(X, Y);
		lifespan = 0.5;
		animation.play("splash");
	}
	
}