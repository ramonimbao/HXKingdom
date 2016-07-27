package ;

import flixel.math.FlxRandom;
import flash.geom.Point;

import flixel.effects.particles.FlxParticle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.FlxSprite;

class Arrow extends FlxSprite
{
	public var shooter:Citizen;

	public function new()
	{
		super();
		loadRotatedGraphic("assets/gfx/arrow.png");
		maxVelocity.x = 200;
		maxVelocity.y = 275;
		acceleration.y = 500;
		offset.x = 3;
		offset.y = 3;
		height = 2;
		width = 2;
		elasticity = 0.5;
	}

	public function shotFrom(from:Citizen, at:FlxObject):Void
	{
		x = from.x + from.width / 2 + (from.facing == FlxObject.RIGHT ? 6 : -6);
		y = from.y + 10;
		revive();
		velocity.x = (from.facing == FlxObject.RIGHT ? maxVelocity.x : -maxVelocity.x);
		velocity.y = - Math.abs(at.x - from.x) + FlxRandom.float() * 40;
		//lifespan = 10;
		shooter = from;
	}

	override public function update(elapsed:Float):Void
	{
		if (y > cast(FlxG.state, PlayState).water.y)
		{
			kill();
			var s:Splash = cast(cast(FlxG.state, PlayState).fx.recycle(Splash), Splash);
			s.reset(x, y);
		}
		angle = (180 / Math.PI) * Math.atan2(velocity.y, velocity.x);
	}

}
