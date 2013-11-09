package;

import flixel.util.FlxRandom;
import flash.geom.Point;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxPoint;
import flixel.group.FlxGroup;
import flixel.system.FlxSound;

class Citizen extends FlxSprite
{

	public static var shootSound:FlxSound;
	
	public static inline var BASE_COLOR:UInt = 0xFF567271;
	public static inline var BASE_SHADE:UInt = 0xFF394B4A;
	public static inline var BASE_SKIN:UInt  = 0xFFEDBEBF;
	public static inline var BASE_DARK:UInt  = 0xFFBD9898;
	public static inline var BASE_EYES:UInt  = 0xFFA18383;
	
	public static inline var BEGGAR:Int = 0;
	public static inline var POOR:Int	= 1;
	public static inline var FARMER:Int = 2;
	public static inline var HUNTER:Int = 3;
	
	// Behaviours
	public static inline var IDLE:Int		 = 0;
	public static inline var SHOOT:Int		 = 1;
	public static inline var JUST_SHOT:Int   = 2;
	public static inline var SHOVEL:Int		 = 3;
	public static inline var GIVE:Int 		 = 4;
	public static inline var JUST_HACKED:Int = 5;
	public static inline var COWER:Int 		 = 6;
	
	// Behaviour times
	public static inline var SHOOT_COOLDOWN_GUARD:Float	= 1.4;
	public static inline var SHOOT_COOLDOWN:Float		= 2.0;
	public static inline var HACK_COOLDOWN:Float		= 4.0;
	public static inline var SHOVEL_PERIOD:Float		= 4.0;
	public static inline var SHOVEL_TIME:Float			= 1.0;
	public static inline var SHOVEL_GOAL_DIST:Float		= 600;
	public static inline var GIVE_COOLDOWN:Float		= 10.0;
	public static inline var COWER_COOLDOWN:Float		= 5.0;
	
	// Other consts
	public static inline var HUNTER_BORDER_RANGE:Float = 256;
	public static inline var MAX_HUNGRY:Float = 5;
	
	// Variables
	public var occupation:Int;
	public var action:Int;
	public var guarding:Bool;
	public var t:Float;
	public var goal:Float;
	public var myColor:UInt;
	public var skin:UInt;
	public var coins:Int;
	public var giveCooldown:Float;
	public var shovelCooldown:Float;
	public var target:FlxObject;
	public var guardLeftBorder:Bool;
	public var hungry:Int = 0;
	
	public var playstate:PlayState;
	public var castle:Castle;
	private var utils:Utils;
	
	public function new(X:Float, Y:Float) 
	{
		occupation = BEGGAR;
		action = IDLE;
		guarding = false;
		t = 0;
		coins = 0;
		giveCooldown = 0;
		shovelCooldown = 0;
		
		
		super(X, Y);
		goal = FlxG.worldBounds.width / 2;
		drag.x = 500;
		guardLeftBorder = (FlxRandom.float() > 0.5);
		myColor = utils.HSVtoRGB(FlxRandom.float() * 360, 0.1 + FlxRandom.float() * 0.2, 0.6);
		var d:Float = Math.random() * 20;
		skin = utils.HSVtoRGB(d, 0.19 + (d / 100), 0.97 - (d / 33));
		
		playstate = cast(FlxG.state, PlayState);
		castle = playstate.castle;
		animation.callback = this.animationFrame;
		morph(BEGGAR);
		
		shootSound = FlxG.sound.load("ShootSound");
	}
	
	public function morph(occ:Int):Citizen
	{
		action = IDLE;
		animation.destroyAnimations();
		if (occ != BEGGAR && coins <= 0)
		{
			coins++;
		}
		switch (occ)
		{
			case BEGGAR:
				if (occupation != BEGGAR)
				{
					playstate.beggars.add(playstate.characters.remove(this, true));
				}
				loadGraphic("assets/gfx/beggar.png", true, true, 32, 32, true);
				animation.add("walk", [0, 1, 2, 3, 4, 5], 5, true);
				animation.add("idle", [7, 8, 7, 8, 7, 6], 2, true);
				animation.add("cower", [9, 10], 2, false);
				maxVelocity.x = 15;
				hungry = 0;
			case POOR:
				if (occupation == BEGGAR)
				{
					playstate.characters.add(playstate.beggars.remove(this, true));
				}
				loadGraphic("assets/gfx/citizen.png", true, true, 32, 32, true);
				utils.replaceColor(pixels, BASE_COLOR, myColor);
				utils.replaceColor(pixels, BASE_SHADE, utils.interpolateColor(myColor, 0xFF000000, 0.2));
				maxVelocity.x = 17;
				animation.add("walk", [0, 1, 2, 3, 4, 5], 10, true);
				animation.add("idle", [0, 6, 0, 6, 0, 7], 2, true);
			case HUNTER:
				if (guardLeftBorder)
				{
					myColor = utils.HSVtoRGB(220 + FlxRandom.float() * 20, 0.2 + FlxRandom.float() * 0.3, 0.7);
				}
				else
				{
					myColor = utils.HSVtoRGB(0 + FlxRandom.float() * 20, 0.2 + FlxRandom.float() * 0.3, 0.7);
				}
				loadGraphic("assets/gfx/hunter.png", true, true, 32, 32, true);
				utils.replaceColor(pixels, BASE_COLOR, myColor);
				utils.replaceColor(pixels, BASE_SHADE, utils.interpolateColor(myColor, 0xFF000000, 0.2));
				maxVelocity.x = 18;
				animation.add("walk", [0, 1, 2, 3, 4, 5], 10, true);
				animation.add("idle", [6, 7, 6, 7, 6, 8], 2, true);
				animation.add("shoot", [9, 10, 0], 6, false);
				animation.add("give", [11, 12, 13], 15, false);
			case FARMER:
				loadGraphic("assets/gfx/farmer.png", true, true, 32, 32, true);
				utils.replaceColor(pixels, BASE_COLOR, myColor);
				utils.replaceColor(pixels, BASE_SHADE, utils.interpolateColor(myColor, 0xFF000000, 0.2));
				maxVelocity.x = 21 + Math.random() * 3;
				animation.add("walk", [0, 1, 2, 3, 4, 5], 12, true);
				animation.add("idle", [6, 7, 6, 7, 6, 8], 2, true);
				animation.add("shovel", [8, 9, 10, 9], 6, true);
				animation.add("give", [11, 12, 13], 15, false);
				animation.add("hack", [14], 15, false);
		}
		
		utils.replaceColor(pixels, BASE_SKIN, skin);
		utils.replaceColor(pixels, BASE_DARK, utils.interpolateColor(skin, 0xFF000000, 0.2));
		utils.replaceColor(pixels, BASE_EYES, utils.interpolateColor(skin, 0xFF000000, 0.5));
		drawFrame(true);
		occupation = occ;
		offset.x = 12;
		offset.y = 8;
		width = 8;
		height = 24;
		pickNewGoal();
		return this;
	}
	
	public function pickup(coin:FlxObject):Void
	{
		if (!coin.alive) return;
		var c:Coin = cast(coin, Coin);
		// Return if the coin doesn't belong to me.
		if (c.owner != null && c.owner != this) return;
		c.kill();
		
		var s:Sparkle = cast(cast(FlxG.state, PlayState).fx.recycle(Sparkle), Sparkle);
		s.reset(x - 4, y + 8);
		if (occupation == BEGGAR)
		{
			playstate.recruitedCitizen = true;
			morph(POOR);
			FlxG.sound.play("PowerupSound").proximity(x, y, playstate.player, FlxG.width * 0.75);
		}
		coins++;
	}
	
	public function giveTaxes(p:Player):Void
	{
		if (occupation == HUNTER || occupation == FARMER)
		{
			if (action == IDLE && coins > 3 && giveCooldown <= 0)
			{
				action = GIVE;
				coins -= 2;
				animation.play("give");
				p.changeCoins(1);
				giveCooldown = GIVE_COOLDOWN;
			}
		}
	}
	
	public function hitByTroll(troll:Troll):Void
	{
		// Farmers can defend.
		if (occupation == FARMER && action != JUST_HACKED)
		{
			action = JUST_HACKED;
			animation.play("hack");
			t = 0;
			troll.getShot();
		}
		else if (coins > 0 && !troll.hasCoin)
		{
			cast(playstate.coins.recycle(Coin), Coin).drop(this, playstate.player);
			coins = (coins > 1) ? 1 : 0;
			utils.explode(this, playstate.gibs);
			if (coins == 0)
			{
				morph(BEGGAR);
			}
			else if (coins == 1)
			{
				morph(POOR);
			}
		}
		if (occupation == BEGGAR && action == IDLE)
		{
			action = COWER;
			animation.play("cower", true);
		}
	}
	
	public function checkShootable(group:FlxGroup):Void
	{
		var c:FlxObject;
		for (i in 0...group.length)
		{
			c = cast(group.members[i], FlxObject);
			if (c != null && c.alive && c.exists && Math.abs(c.x - x) < 96)
			{
				animation.play("shoot", true);
				shootSound.play(false);
				shootSound.proximity(x, y, playstate.player, FlxG.width);
				// walk 1 pixel towards goal, just to get facing right
				goal = (c.x > x) ? x + 1 : x - 1;
				facing = (goal > x) ? FlxObject.RIGHT : FlxObject.LEFT;
				target = c;
				action = SHOOT;
				t = 0;
				break;
			}
		}
	}
	
	public function checkWork(group:FlxGroup):Void
	{
		var c:FlxObject;
		for (i in 0...group.length)
		{
			c = cast(group.members[i], FlxObject);
			if (c != null)
			{
				if (x > c.x && x+width < c.x + c.width)
				{
					if (cast(c, Workable).needsWork())
					{
						cast(c, Workable).work(this);
						animation.play("shovel", true);
						action = SHOVEL;
						shovelCooldown = SHOVEL_PERIOD;
						t = 0;
					}
				}
			}
		}
	}
	
	public function checkGuard():Void
	{
		if (action == IDLE && castle.archer_positions.length > 0)
		{
			if (Math.abs(castle.x - x) < 192)
			{
				for (i in 0...castle.archer_positions.length)
				{
					var pos:FlxPoint = castle.archer_positions[i];
					if (Math.abs(castle.x + pos.x - x) < 4)
					{
						x = castle.x + pos.x;
						y = castle.y + pos.y;
						guarding = true;
						playstate.archers.add(playstate.characters.remove(this, true));
						castle.archer_positions.splice(i, 1);
						break;
					}
				}
			}
		}
	}
	
	public function leaveGuard():Void
	{
		castle.archer_positions.push(new FlxPoint(x, y));
		playstate.characters.add(playstate.archers.remove(this));
		action = IDLE;
		guarding = false;
	}
	
	public function pickNewGoal(?preset:Float):Void
	{
		// TODO !!! Hunters don't target well at night
		var a:Attention = cast(playstate.fx.recycle(Attention), Attention);
		a.appearAt(this);
		if (preset != null)
		{
			goal = preset;
			return;
		}
		if (occupation == POOR)
		{
			var shop:Shop = cast(playstate.shops.getRandom(), Shop);
			goal = shop.x + shop.width / 2;
			return;
		}
		if (coins > 4)
		{
			goal = playstate.player.x;
			return;
		}
		if (occupation == FARMER)
		{
			// Otherwise check for a wall to work on
			var needWork:Array<Dynamic> = new Array();
			var dist:Float = Math.POSITIVE_INFINITY;
			var wall:Wall, closestWall:Wall = null;
			for (i in 0...playstate.walls.length)
			{
				wall = cast(playstate.walls.members[i], Wall);
				if (wall != null && wall.needsWork() && (Math.abs(wall.x - x) < dist))
				{
					closestWall = wall;
					dist = Math.abs(wall.x - x);
				}
			}
			if (closestWall != null)
			{
				goal = closestWall.x + closestWall.width / 2;
				return;
			}
		}
		
		var l:Float, r:Float;
		
		if (occupation == HUNTER)
		{
			// Hunters gather around borders at night
			if (playstate.weather.timeOfDay >= 0.65 || playstate.weather.timeOfDay < 0.20)
			{
				if (guardLeftBorder)
				{
					l = playstate.kingdomLeft;
					r = playstate.kingdomLeft + 32;
				}
				else
				{
					l = playstate.kingdomRight - 32;
					r = playstate.kingdomRight;
				}
			}
			else
			{
				l = playstate.kingdomLeft - HUNTER_BORDER_RANGE;
				r = playstate.kingdomRight + HUNTER_BORDER_RANGE;
			}
		}
		else if (occupation == BEGGAR)
		{
			// Beggars gather outside borders
			if (playstate.beggars.countLiving() > playstate.minBeggars)
			{
				hungry++;
				if (hungry > MAX_HUNGRY)
				{
					utils.explode(this, playstate.gibs, 1.0);
					kill();
				}
			}
			if (x < PlayState.GAME_WIDTH / 2)
			{
				l = playstate.kingdomLeft - 256;
				r = playstate.kingdomLeft;
			}
			else
			{
				l = playstate.kingdomRight;
				r = playstate.kingdomRight + 256;
			}
		}
		else
		{
			// Move anywhere within the kingdom
			l = playstate.kingdomLeft;
			r = playstate.kingdomRight;
		}
		goal = Std.int(FlxRandom.float() * (r - l) + l);
	}
	
	public function animationFrame(animName:String, frameNum:UInt, frameIndex:UInt):Void
	{
		if (animName == 'give' && frameNum == 2)
		{
			action = IDLE;
			animation.play("idle");
		}
		
		if (animName == "shovel")
		{
			var d:Dust = cast(playstate.fx.recycle(Dust), Dust);
			d.reset(x + ((facing == FlxObject.RIGHT) ? 14: -6), y + 19);
		}
	}
	
	override public function update():Void
	{
		acceleration.x = 0;
		t += FlxG.elapsed;
		shovelCooldown -= FlxG.elapsed;
		giveCooldown -= FlxG.elapsed;
		
		// IDLE MOVING AROUND
		
		if (guarding && occupation == HUNTER)
		{
			animation.play("idle");
			facing = (goal > x) ? FlxObject.RIGHT : FlxObject.LEFT;
		}
		else if (action == IDLE)
		{
			facing = (goal > x) ? FlxObject.RIGHT : FlxObject.LEFT;
			// Near goal
			if (Math.abs(goal -x) < 2)
			{
				if (t > 2.0 && FlxRandom.float() < 0.3)
				{
					t = 0;
					pickNewGoal();
				}
				else
				{
					animation.play("idle");
				}
			}
			// Far away from goal
			else
			{
				animation.play("walk");
				acceleration.x = (facing == FlxObject.RIGHT) ? maxVelocity.x * 10 : -maxVelocity.x * 10;
				y = playstate.groundHeight - height;
			}
		}
		
		// Specific behaviour
		if (occupation == HUNTER)
		{
			//Shooting cycle
			if (action == SHOOT && t > 0.16)
			{
				cast(playstate.arrows.recycle(Arrow), Arrow).shotFrom(this, target);
				t = 0;
				action = JUST_SHOT;
			}
			else if (action == JUST_SHOT && t > (guarding ? SHOOT_COOLDOWN_GUARD : SHOOT_COOLDOWN))
			{
				t = 0;
				action = IDLE;
			}
			else if (action == IDLE)
			{
				checkShootable(playstate.trolls);
				// Check for idle again since we could be shooting a Troll.
				if (action == IDLE)
				{
					checkShootable(playstate.bunnies);
				}
			}
			// Check if we need to take up a guard post.
			checkGuard();
		}
		else if (occupation == FARMER)
		{
			if (action == JUST_HACKED && t > HACK_COOLDOWN)
			{
				t = 0;
				action = IDLE;
			}
			if (shovelCooldown <= 0 && action == IDLE)
			{
				checkWork(playstate.walls);
				checkWork(playstate.farmlands);
			}
			else if (action == SHOVEL && t > SHOVEL_TIME)
			{
				t = 0;
				action = IDLE;
			}
		}
		else if (occupation == BEGGAR)
		{
			if (action == COWER && t > COWER_COOLDOWN)
			{
				t = 0;
				action = IDLE;
			}
		}
		super.update();
	}
}