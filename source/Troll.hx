package ;

import flixel.util.FlxRandom;
import flash.geom.Point;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxPoint;
import flixel.FlxCamera;

class Troll extends FlxSprite
{
	public var t:Float;
	public var goal:Float;
	public var hasCoin:Bool;
	public var hasCrown:Bool;
	public var wait:Bool;
	public var retreating:Bool;
	public var maxSpeed:Float;
	public var jumpHeight:Float;
	public var jumpiness:Float;
	public var confusion:Float;
	public var big:Bool;
	public var safeDistance:Float;
	public var maxHeightReached:Float;
	public var jumpCooldown:Float;
	public var confuseCooldown:Float;
	
	private var playstate:PlayState;
	private var utils:Utils;
	
	public function new()
	{
		t = 0;
		goal = 1600;
		hasCoin = false;
		hasCrown = false;
		wait = false;
		retreating = false;
		maxSpeed = 20;
		jumpHeight = 100;
		jumpiness = 0.01;
		confusion = 0.01;
		big = false;
		safeDistance = 200;
		maxHeightReached = 0;
		jumpCooldown = 0;
		confuseCooldown = 0;
		
		super(0, 0);
		maxVelocity.y = 275;
		maxVelocity.x = 60;
		acceleration.y = 900;
		loadAnims();
		
		playstate = cast(FlxG.state, PlayState);
	}
	
	override public function reset(X:Float, Y:Float):Void
	{
		retreating = false;
		hasCoin = false;
		wait = true;
		visible = false;
		velocity.x = velocity.y = 0;
		if (!big == playstate.trollBig)
		{
			big = playstate.trollBig;
			loadAnims();
		}
		X -= width / 2;
		super.reset(X - width / 2, Y);
		health = playstate.trollHealth;
		maxSpeed = playstate.trollMaxSpeed;
		jumpHeight = playstate.trollJumpHeight;
		jumpiness = playstate.trollJumpiness;
		jumpCooldown = jumpiness + Math.random() * 2 * jumpiness;
		confusion = playstate.trollConfusion;
		confuseCooldown = confusion + Math.random() * 2 * confusion;
		t = 1;
		
		if (playstate.trollsNoCollide.remove(this) != null)
		{
			playstate.trolls.add(this);
		}
	}
	
	private function loadAnims():Void {
		if (big)
		{
			loadGraphic("assets/gfx/trollbig.png", true, true, 64, 64);
			offset.x = 24;
			offset.y = 24;
			width = 16;
			height = 40;
			animation.add("walk", [0, 1, 2, 3, 4, 5, 6, 7, 8], 7, true);
			animation.add("walk_crown", [9, 10, 11, 12, 13, 14, 15, 16, 17], 7, true);
			animation.add("stand", [0], 10, true);
		}
		else
		{
			loadGraphic("assets/gfx/troll.png", true, true, 32, 32);
			offset.x = 12;
			offset.y = 12;
			width = 8;
			height = 20;
			animation.add("walk", [0, 1, 2, 3, 4, 5, 6, 7, 8], Std.int(10+FlxRandom.float()*5), true);
			animation.add("walk_crown", [9, 10, 11, 12, 13, 14, 15, 16, 17], Std.int(10 + FlxRandom.float() * 5), true);
			animation.add("walk_coin", [18, 19, 20, 21, 22, 23, 24, 25, 26], Std.int(10 + FlxRandom.float() * 5), true);
			animation.add("stand", [0], 10, true);
		}
	}
	
	public function getsCoin():Void
	{
		hasCoin = true;
		retreat();
	}
	
	public function pickup(coin:FlxObject):Void
	{
		if (!hasCoin && coin.alive && !retreating && !big)
		{
			coin.kill();
			hasCoin = true;
			retreat();
		}
	}
	
	public function stealCrown():Void
	{
		hasCrown = true;
		playstate.panTo(this, 20);
		retreat();
	}
	
	public function getShot():Void
	{
		if (hasCrown) return;
		health--;
		if (health > 0) {
			//flicker();
		}
		else
		{
			utils.explode(this, playstate.gibs, 1.0);
			if (hasCoin)
			{
				cast(playstate.coins.recycle(Coin), Coin).drop(this);
			}
			kill();
		}
	}
	
	override public function kill():Void
	{
		playstate.trollsNoCollide.remove(this);
		playstate.trolls.add(this);
		super.kill();
	}
	
	public function retreat():Void
	{
		retreating = true;
		goal = (x < playstate.player.x) ? 0 : FlxG.worldBounds.width;
		wait = false;
		playstate.trolls.remove(this);
		playstate.trollsNoCollide.add(this);
	}
	
	public function go():Void
	{
		wait = false;
		visible = true;
		goal = playstate.player.x;
		if (big) {
			playstate.trolls.remove(this);
			playstate.trollsNoCollide.add(this);
		}
	}
	
	override public function update():Void
	{
		if (wait) {
			acceleration.x = 0;
			velocity.x = 0;
			return;
		}
		confuseCooldown -= FlxG.elapsed;
		jumpCooldown -= FlxG.elapsed;
		// Check for movement input
		acceleration.x = 0;
		t += FlxG.elapsed;
		if (!hasCoin && t > 1.8)
		{
			if (retreating || confuseCooldown < 0)
			{
				goal = (x < playstate.player.x) ? 0 : FlxG.worldBounds.width;
				confuseCooldown = confusion + Math.random() * 2 * confusion;
			}
			else
			{
				goal = playstate.player.x;
			}
			t = 0;
		}
		
		// I don't know why I need this, but apparently trolls can fall off the world.
		if (x <= 24 || x + width >= FlxG.worldBounds.width - 24)
		{
			if (retreating) kill();
		}
		if (y > 200)
		{
			// throw new Error("TROLL FELL OFF :(");
			trace("TROLL FELL" + x + " , " + y);
			trace("Retreating: " + retreating);
			trace("Big: " + big);
			trace("Wait: " + wait);
			kill();
		}
		
		facing = (goal > x) ? FlxObject.RIGHT : FlxObject.LEFT;
		
		if ((touching & FlxObject.FLOOR) != 0)
		{
			maxVelocity.x = maxSpeed;
			// Sprint outside of kingdom.
			if (x > playstate.kingdomRight + safeDistance || x < playstate.kingdomLeft - safeDistance)
			{
				maxVelocity.x += 40;
			}
			drag.x = maxVelocity.x * 10;
			if (facing == FlxObject.LEFT)
			{
				acceleration.x = -maxVelocity.x * 4;
			}
			else
			{
				acceleration.x = maxVelocity.x * 4;
			}
			if (hasCrown)
				animation.play("walk_crown");
			else if (hasCoin)
				animation.play("walk_coin");
			else
				animation.play("walk");	
			// Jump
			if (jumpCooldown < 0)
			{
				maxHeightReached = 0;
				var v:Float = Math.sqrt(jumpHeight * 2 * acceleration.y);
				velocity.y = -v;
				maxVelocity.x = maxSpeed * 2;
				velocity.x *= 2;
				jumpCooldown = jumpiness + Math.random() * 2 * jumpiness;
			}
			else
			{
				maxHeightReached = Math.max(112 - y, maxHeightReached);
				drag.x = maxVelocity.x * 0.1;
				maxVelocity.x = maxSpeed * 2;
				if (facing == FlxObject.LEFT)
					acceleration.x = -maxVelocity.x;
				else
					acceleration.x = maxVelocity.x;
			}
			
			super.update();
		}
	}
	
	
}