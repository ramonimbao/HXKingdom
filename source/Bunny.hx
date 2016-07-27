package ;

import flash.geom.Point;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.math.FlxRandom;

class Bunny extends FlxSprite
{
	public static inline var DECAY_TIME:Float = 5;
	public static inline var TURN_TIME:Float = 1;

	private var t:Float;
	private var random:FlxRandom = new FlxRandom();

	public function new(X:Float, Y:Float)
	{
		t = 0;

		super(X, Y);
		loadGraphic("assets/gfx/bunny.png", true, 16, 16);
		offset.y = 4;
		height = 12;
		maxVelocity.y = 100;
		maxVelocity.x = 30;
		drag.x = 1000;
		animation.add("walk", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], Std.int(10 + random.float() * 5), true);
		animation.add("stand", [0], 10, true);
		animation.add("dead", [11], 10, true);
		y = cast(FlxG.state, PlayState).groundHeight - 12;
	}

	public function getShot(arrow:Arrow):Void
	{
		animation.play("dead");
		alive = false;
		velocity.x = 0;
		t = 0;
		cast(cast(FlxG.state, PlayState).coins.recycle(Coin), Coin).drop(this, arrow.shooter);
	}

	override public function update(elapsed:Float):Void
	{
		// Check for movement input
		acceleration.x = 0;
		t += elapsed;
		if (x + width > PlayState.GAME_WIDTH || x < 0)
		{
			kill();
		}
		if (alive)
		{
			if (t > TURN_TIME)
			{
				t = 0;
				if (random.float() < 0.4)
				{
					facing = (facing == FlxObject.LEFT) ? FlxObject.RIGHT : FlxObject.LEFT;
				}
			}
			if (facing == FlxObject.LEFT)
			{
				acceleration.x = -maxVelocity.x * 4;
				animation.play("walk");
			}
			else
			{
				acceleration.x = maxVelocity.x * 4;
				animation.play("walk");
			}

			super.update(elapsed);
		}
		else
		{
			alpha = 1 - (t / DECAY_TIME);
			if (t > DECAY_TIME)
			{
				kill();
			}
		}
	}

}
