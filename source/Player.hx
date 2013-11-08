package ;

import flash.geom.Point;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxCamera;
import flixel.group.FlxGroup;
import flixel.FlxObject;
import flixel.util.FlxPoint;
import flixel.system.FlxSound;

class Player extends FlxSprite
{
	public static var pickupSound:FlxSound;
	
	public static inline var BASE_SKIN:UInt = 0xFFEDBEBF;
	public static inline var BASE_DARK:UInt = 0xFFBD9898;
	public static inline var BASE_EYES:UInt = 0xFFA18383;
	
	public static inline var MAX_SPEED:Float = 80;
	public static inline var MIN_SPEED:Float = 25;
	public static inline var MAX_FOOD_BONUS:Float = 50;
	public static inline var MAX_FOOD:Float = 100;
	public static inline var HIT_RATE:Float = 0.2;
	public static inline var SELECT_DISTANCE:Float = 10;
	
	private var playstate:PlayState;
	
	private var selectedBuilding:FlxSprite;
	private var floatCoin:CoinFloat;
	private var lastMoved:Float;
	public var food:Float;
	
	public var hasCrown:Bool;
	public var lastTrollHit:Float;
	public var coins:Int;
	
	private var utils:Utils;
	

	public function new(X:Float, Y:Float) 
	{
		selectedBuilding = null;
		floatCoin = null;
		lastMoved = 0;
		food = 100;
		hasCrown = true;
		lastTrollHit = 0;
		coins = 7;
		
		super(X, Y);
		y = 100;
		
		loadGraphic("assets/gfx/king.png", true, true, 64, 64);
		width = 20;
		height = 32;
		offset.x = 22;
		offset.y = 32;
		
		maxVelocity.x = MAX_SPEED;
		drag.x = maxVelocity.x * 5;
		
		playstate = cast(FlxG.state, PlayState);
		
		animation.add("walk_slow", [0, 1, 2, 3, 4, 5, 6, 7], 10, true);
		animation.add("walk_fast", [0, 1, 2, 3, 4, 5, 6, 7], 15, true);
		animation.add("stand", [8], 10, true);
		animation.add("eat", [9, 10], 5, true);
		animation.add("nocrown", [11], 10, true);
		animation.play("stand");
		playstate.player = this;
		
		var d:Float = Math.random() * 20;
		var skin:UInt = utils.HSVtoRGB(d, 0.19 + (d / 100), 0.97 - (d / 33));
		utils.replaceColor(pixels, BASE_SKIN, skin);
		utils.replaceColor(pixels, BASE_DARK, utils.interpolateColor(skin, 0xFF000000, 0.2));
		utils.replaceColor(pixels, BASE_EYES, utils.interpolateColor(skin, 0xFF000000, 0.5));
		
		pickupSound = FlxG.sound.load("PickupSound");
	}
	
	public function changeCoins(amt:Int):Void
	{
		if (amt > 0)
		{
			pickupSound.play(false);
			pickupSound.proximity(x, y, this, FlxG.width);
		}
		coins += amt;
		playstate.showCoins();
	}
	
	public function hitByTroll(troll:Troll):Void
	{
		if (troll.hasCoin) return;
		
		if (lastTrollHit < HIT_RATE) return;
		lastTrollHit = 0;
		
		// If the player has coins, lose one and return.
		if (coins > 0)
		{
			var c:Coin = cast(playstate.coins.recycle(Coin), Coin);
			c.drop(this, troll, true);
			c.justThrown = true;
			FlxG.sound.play("StolenSound").proximity(x, y, this, FlxG.width);
			changeCoins( -1);
			FlxG.cameras.shake();
			return;
		}
		
		if (hasCrown)
		{
			FlxG.cameras.flash(0xFFFFFFFF, 0.1);
			troll.stealCrown();
			lostCrown(troll);
			playstate.crownStolen();
		}
	}
	
	public function lostCrown(troll:FlxObject):Void
	{
		hasCrown = false;
		facing = troll.x > x ? FlxObject.RIGHT : FlxObject.LEFT;
		animation.play("nocrown");
		FlxG.sound.play("StolenSound").proximity(x, y, this, FlxG.width);
		utils.explode(this, playstate.gibs);
	}
	
	public function pickup(coin:FlxObject):Void
	{
		if (!coin.alive) return;
		var c:Coin = cast(coin, Coin);
		// Return if the coin doesn't belong to me.
		if (c.justThrown) return;
		c.kill();
		changeCoins(1);
	}
	
	override public function update():Void
	{
		lastTrollHit += FlxG.elapsed;
		
		// Check for movement input
		acceleration.x = 0;
		if (!hasCrown) return;
		
		if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.RIGHT)
		{
			lastMoved = 0;
			if (food > 0)
			{
				food -= FlxG.elapsed;
			}
			maxVelocity.x = MIN_SPEED + Math.min(1, food / MAX_FOOD_BONUS) * (MAX_SPEED - MIN_SPEED);
			if (!playstate.horseAdvice && food < 10)
			{
				playstate.horseAdvice = true;
				playstate.showText("Horse is tired. Let him rest on the grass.");
			}
		}
		if (FlxG.keys.pressed.LEFT)
		{
			acceleration.x = -maxVelocity.x * 4;
			facing = FlxObject.LEFT;
			if (maxVelocity.x > MIN_SPEED + 15)
			{
				animation.play("walk_fast");
			}
			else
			{
				animation.play("walk_slow");
			}	
		}
		else if (FlxG.keys.pressed.RIGHT)
		{
			acceleration.x = maxVelocity.x * 4;
			facing = FlxObject.RIGHT;
			if (maxVelocity.x > MIN_SPEED + 15)
			{
				animation.play("walk_fast");
			}
			else
			{
				animation.play("walk_slow");
			}
		}
		else
		{
			lastMoved += FlxG.elapsed;
			if (lastMoved > 1 && food < MAX_FOOD)
			{
				// Check if on grass
				var headPos:Float = (x + width / 2) + (facing == FlxObject.RIGHT ? 25 : -25);
				var onTile:Int = playstate.floor.getTile(Std.int(headPos / 32), 4);
				if ((onTile >= 7 && onTile <= 11) || (onTile >= 17 && onTile <= 18))
				{
					animation.play("eat", false);
					food += FlxG.elapsed * 10;
				}
				else
				{
					animation.play("stand");
				}
			}
			else
			{
				animation.play("stand");
			}
		}
		if (FlxG.keys.pressed.SHIFT && PlayState.CHEATS)
		{
			velocity.x *= 10;
		}
		
		if (FlxG.keyboard.justPressed("DOWN"))
		{
			if (coins <= 0)
			{
				playstate.showCoins();
			}
			else
			{
				if (selectedBuilding != null)
				{
					changeCoins( -1);
					giveCoin(selectedBuilding);
				}
				else
				{
					var cit:Citizen;
					var closestCitizen:Citizen = null;
					var closest:Float = 1000000;
					for (i in 0...playstate.beggars.length)
					{
						cit = cast(playstate.beggars.members[i], Citizen);
						if (Math.abs((cit.x + cit.width / 2) - (x + width / 2)) < closest)
						{
							closestCitizen = cit;
							closest = Math.abs((cit.x + cit.width / 2) - (x + width / 2));
						}
					}
					if (playstate.recruitedCitizen || closest < 64)
					{
						var c:Coin = cast(playstate.coins.recycle(Coin), Coin);
						c.drop(this, closestCitizen);
						c.justThrown = true;
						FlxG.sound.play("ThrowSound").proximity(x, y, this, FlxG.width);
						changeCoins( -1);
					}
				}
			}
		}
		super.update();
		
		//Find selected shop/wall
		if (selectedBuilding != null)
		{
			if (Math.abs((selectedBuilding.x + selectedBuilding.width / 2) - (x + width / 2)) > SELECT_DISTANCE * 2)
			{
				deselect(selectedBuilding);
			}
		}
		else if (playstate.recruitedCitizen)
		{
			checkSelectable(playstate.objects);
			checkSelectable(playstate.shops);
			checkSelectable(playstate.walls);
		}
		
		// CAP WALKING AT LEVEL ENDS
		if (x < 0)
		{
			velocity.x = Math.max(velocity.x, 0);
		}
		else if (x + width > PlayState.GAME_WIDTH)
		{
			velocity.x = Math.min(velocity.x, 0);
		}
	}
	
	private function checkSelectable(group:FlxGroup):Void
	{
		for (i in 0...group.length)
		{
			var b:FlxSprite = cast(group.members[i], FlxSprite);
			if (b != null && Math.abs((b.x + b.width / 2) - (x + width / 2)) <= SELECT_DISTANCE)
			{
				if (cast(b, Buildable).canBuild())
				{
					select(b);
				}
			}
		}
	}
	
	private function select(building:FlxSprite):Void
	{
		selectedBuilding = building;
		if (floatCoin == null)
		{
			playstate.add(floatCoin = new CoinFloat());
		}
		floatCoin.visible = true;
		floatCoin.float(selectedBuilding);
	}
	
	private function deselect(building:FlxSprite):Void
	{
		selectedBuilding.color = 0xFFFFFFFF;
		selectedBuilding = null;
		floatCoin.visible = false;
	}
	
	private function giveCoin(building:FlxSprite):Void
	{
		cast(building, Buildable).build();
		FlxG.sound.play("BuildSound").proximity(x, y, this, FlxG.width);
		deselect(building);
	}
}