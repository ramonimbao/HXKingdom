package ;

import flash.geom.Point;

import flixel.effects.particles.FlxParticle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.FlxSprite;

class Attention extends FlxParticle
{
	public var citizen:Citizen;

	public function new()
	{
		super();
		loadGraphic("assets/gfx/attention.png");
		maxVelocity.x = 0;
		maxVelocity.y = 0;
		height = 8;
		width = 8;
		alpha = 0.5;
	}

	public function appearAt(at:Citizen):Void
	{
		citizen = at;
		y = at.y - 4;
		revive();
		lifespan = 1;
	}

	override public function update(elapsed:Float):Void
	{
		x = citizen.x + citizen.width / 2 - 4;
		super.update(elapsed);
	}

}
