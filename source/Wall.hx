package ;

import flash.geom.Point;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxPoint;

class Wall extends FlxSprite implements Workable implements Buildable
{
	public var HEIGHT:Array<Int>;
	public var HEALTH:Array<Int>;
	public var HURT_COOLDOWN:Float;
	public var WORK_BUILD_HEIGHT:Int;
	public var WORK_HEAL_AMOUNT:Int;

	private var playstate:PlayState;
	public var scaffold:Scaffold;

	public var building:Bool;
	public var heightToBuild:Int;
	public var baseY:Float;
	public var stage:Int;
	private var t:Float;

	private var utils:Utils = new Utils();

	public function new(X:Float, Y:Float)
	{
		HURT_COOLDOWN = 1;
		WORK_BUILD_HEIGHT = 10;
		WORK_HEAL_AMOUNT = 4;
		scaffold = null;
		building = false;
		heightToBuild = 0;
		stage = 0;

		baseY = Y;
		super(X, Y);
		immovable = true;
		moves = false;
		solid = false;
		loadGraphic("assets/gfx/wall.png", true, 32, 64);
		animation.add("grow", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 1);
		if (X > 1920) {
			facing = FlxObject.LEFT;
		}
		offset.x = 4;
		width = 24;
		health = HEALTH[stage];
		updateAppearance();
		playstate = cast(FlxG.state, PlayState);

		HEIGHT = [11, 38, 46, 54, 59];
		HEALTH = [2, 38, 50, 60, 75];
	}

	public function build():Void
	{
		buildTo(stage + 1);
	}

	public function buildTo(s:Int, instant:Bool = false):Void
	{
		if (!instant && s < stage) return;
		building = true;
		stage = s;
		heightToBuild = HEIGHT[stage];
		health = HEALTH[stage];
		updateAppearance();
		if (scaffold != null)
		{
			scaffold.kill();
		}
		scaffold = cast(playstate.indicators.recycle(Scaffold), Scaffold).build(this);
		scaffold.y = y - HEIGHT[stage];
		solid = false;
		// Kind of hacky this.
		/*if (instance) {
			heightToBuild = 1;
			work(null);
		}*/
	}

	public function work(citizen:Citizen = null):Void
	{
		if (heightToBuild > 0)
		{
			heightToBuild -= WORK_BUILD_HEIGHT;
			if (heightToBuild <= 0)
			{
				heightToBuild = 0;
				building = false;
				solid = true;
				utils.explode(scaffold, playstate.gibs, 1);
				scaffold.kill();
				scaffold = null;
			}
			updateAppearance();
		}
		else
		{
			if (health < HEALTH[stage])
			{
				health += Math.min(WORK_HEAL_AMOUNT, HEALTH[stage] - health);
			}
		}
	}

	override public function hurt(Damage:Float):Void
	{
		if (t > HURT_COOLDOWN)
		{
			health -= Damage;
			FlxG.sound.play("HitwallSound").proximity(x, y, playstate.player, FlxG.width);
			utils.explode(this, playstate.gibs, 0.1);
			t = 0;
		}
		if (health <= 0 && stage > 0)
		{
			utils.explode(this, playstate.gibs, 1.0);
			stage = 0;
			health = HEALTH[stage];
		}
		updateAppearance();
	}

	public function needsWork():Bool
	{
		return (building || health < HEALTH[stage]);
	}

	public function canBuild():Bool
	{
		return (!building && stage < 4);
	}

	private function updateAppearance():Void
	{
		height = HEIGHT[stage] - heightToBuild;
		y = baseY + 64 - height;
		offset.y = 64 - HEIGHT[stage];
		if (health < HEALTH[stage] / 2)
		{
			animation.frameIndex = stage + 5;
		}
		else
		{
			animation.frameIndex = stage;
		}
	}

	override public function update():Void
	{
		t += FlxG.elapsed;
		if (this.stage > 0 && !building)
		{
			if (this.x > PlayState.GAME_WIDTH / 2)
			{
				playstate.kingdomRight = Math.max(playstate.kingdomRight, x);
			}
			else
			{
				playstate.kingdomLeft = Math.min(playstate.kingdomLeft, x+width);
			}
		}
	}

}
