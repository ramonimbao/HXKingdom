package ;

import flixel.util.FlxRandom;
import flash.geom.Point;

import flixel.effects.particles.FlxParticle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxPoint;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;

class Coin extends FlxParticle
{
	public static inline var TOTAL_LIFESPAN:Float = 25;
	public static inline var OWNER_LIFESPAN:Float = 4;
	public var owner:FlxObject;
	public var justThrown:Bool;
	public var called:Bool;

	public function new()
	{
		owner = null;
		justThrown = false;
		called = false;

		super();

		loadGraphic("assets/gfx/coin.png", false, 10, 10);
		maxVelocity.x = 20;
		maxVelocity.y = 275;
		acceleration.y = 900;
		animation.add("spin", [0, 1, 2, 3, 4, 5, 6, 7], 10, true);
		animation.play("spin");
		elasticity = 0.5;
	}

	public function drop(from:FlxSprite, owner:FlxObject = null, far:Bool = false):Coin
	{
		reset(from.x + from.width / 2 - 5, Math.max(40, from.y - 10));
		lifespan = TOTAL_LIFESPAN;
		if (far)
		{
			velocity.x = FlxRandom.float() * 140 - 70;
			velocity.y = -180;
		}
		else
		{
			velocity.x = FlxRandom.float() * 60 - 30;
			velocity.y = -180;
		}
		called = false;
		this.owner = owner;
		if (owner != null && Std.is(owner, Citizen))
		{
			cast(owner, Citizen).pickNewGoal(this.x + this.width / 2 + this.velocity.x);
		}
		return this;
	}

	override public function update():Void
	{
		if (!called && lifespan <= TOTAL_LIFESPAN - OWNER_LIFESPAN / 2)
		{
			justThrown = false;
			var cit:Citizen = cast(owner, Citizen);
			if (cit != null)
			{
				called = true;
				justThrown = false;
				FlxFlicker.flicker(this);
				cit.pickNewGoal(x + width / 2);
			}
		}
		if (owner != null && lifespan <= TOTAL_LIFESPAN - OWNER_LIFESPAN)
		{
			FlxFlicker.flicker(this);
			owner = null;
		}
		super.update();
	}
}
