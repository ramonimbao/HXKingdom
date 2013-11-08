package ;

import flash.geom.Point;

import flixel.effects.particles.FlxParticle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxPoint;
import flixel.FlxSprite;

class Dust extends FlxParticle
{

	public function new() 
	{
		super();
		loadGraphic("assets/gfx/dust.png", true);
		animation.add("fade", [0, 1, 2, 3], 5, false);
		drag.x = drag.y = 20;
	}
	
	override public function reset(X:Float, Y:Float):Void
	{
		super.reset(X, Y);
		x += (Math.random() < 0.5) ? 4 : -4;
		velocity.x = Math.random() * 40 - 20;
		velocity.y = -Math.random() * 20 - 4;
		//lifespan = 1.0;
		animation.play("fade", true);
	}
	
}