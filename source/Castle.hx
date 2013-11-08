package ;

import flash.geom.Point;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxPoint;

class Castle extends FlxSprite implements Buildable
{

	public static inline var POST:Int = 0;
	public static inline var PLATFORM:Int = 1;
	public static inline var WATCHTOWER:Int = 2;
	public static inline var STONETOWER:Int = 3;
	public static inline var CASTLE:Int = 4;
	
	public var BUILD_COOLDOWN:Float;
	public var ARCHER_POSITIONS:Array < Array<FlxPoint>>;
	public var ARCHER_POSITION_INDEX:Array<Int>;
	
	private var playstate:PlayState;
	
	private var light:Light;
	private var lights:FlxGroup;
	
	public var t:Float;
	public var stage:Int;
	public var archers:FlxGroup;
	public var archer_positions:Array<Dynamic>;
	public var capacity:Int;
	public var baseY:Float;
	
	private var utils:Utils;
	
	public function new(X:Float, Y:Float) 
	{
		t = 0;
		archer_positions = [];
		capacity = 0;
		
		super(X, Y);
		
		BUILD_COOLDOWN = PlayState.CHEATS ? 1 : 15;
		ARCHER_POSITIONS = [[new FlxPoint(26, 60)],
							[new FlxPoint(16, 47), new FlxPoint(104, 47)],
							[new FlxPoint(16, 47), new FlxPoint(104, 47), new FlxPoint(60, 2)],
							[new FlxPoint(16, 47), new FlxPoint(104, 47), new FlxPoint(60, 2), new FlxPoint(75, 2)],
							[new FlxPoint(16, 47), new FlxPoint(104, 47), new FlxPoint(38, 2), new FlxPoint(83, 2), new FlxPoint(27, 20), new FlxPoint(93, 20)]];
		ARCHER_POSITION_INDEX = [0, 0, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4];
		
		baseY = Y + 1;
		moves = false;
		playstate = cast(FlxG.state, PlayState);
		lights = playstate.lights;
		archers = playstate.archers;
		playstate.castle = this;
		
		loadGraphic("assets/gfx/castle.png", true, true, 128, 96);
		animation.add("stages", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], 1);
		
		morph(POST);
		
		light = new Campfire(x + width / 2, y + height);
		lights.add(light);
	}
	
	public function morph(stage:Int):Void
	{
		//archer_position = ARCHER_POSITIONS[ARCHER_POSITION_INDEX[stage]].slice();
		//archer_position = ARCHER_POSITIONS.slice(
		archer_positions = ARCHER_POSITIONS.slice(ARCHER_POSITION_INDEX[stage], 1);
		for (archer in archers.members)
		{
			if (archer != null)
			{
				cast(archer, Citizen).leaveGuard();
			}
		}
		animation.frameIndex = stage;
		
		this.stage = stage;
		height = 84;
		y = baseY + 96 - height;
		offset.y = 96 - height;
	}
	
	public function build():Void
	{
		if (stage < ARCHER_POSITION_INDEX.length)
		{
			t = 0;
			utils.explode(this, playstate.gibs, 0.4);
			morph(stage + 1);
		}
	}
	
	public function canBuild():Bool
	{
		return (t > BUILD_COOLDOWN && stage < 14);
	}
	
	override public function update():Void
	{
		t += FlxG.elapsed;
		playstate.kingdomRight = Math.max(playstate.kingdomRight, x + width);
		playstate.kingdomLeft = Math.min(playstate.kingdomLeft, x);
	}
}