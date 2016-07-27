package ;

import flash.geom.Point;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.effects.FlxFlicker;

class Shop extends FlxSprite implements Buildable
{
	public static inline var SCYTHES:Int = 1;
	public static inline var BOWS:Int = 2;

	public var type:Int;
	public var supply:Int;

	public function new(X:Float, Y:Float)
	{
		supply = 0;

		super(X, Y + 2);
		if (X > PlayState.GAME_WIDTH / 2)
		{
			type = BOWS;
		}
		else
		{
			type = SCYTHES;
		}
		loadGraphic("assets/gfx/shop.png", true);
		width = 56;
		offset.x = 4;
		x += 4;
		height = 46;
		offset.y = 18;
		y += 18;
		moves = false;
		updateAppearance();
	}

	override public function update(elapsed:Float):Void
	{
		if (supply > 0)
		{
			FlxG.overlap(this, cast(FlxG.state, PlayState).characters, equip);
		}
	}

	public function equip(shop:FlxObject, char:FlxObject):Void
	{
		if (supply <= 0) return;
		var cit:Citizen = cast(char, Citizen);
		if (cit.occupation == Citizen.POOR)
		{
			supply--;
			if (type == BOWS)
			{
				cit.morph(Citizen.HUNTER);
			}
			else
			{
				cit.morph(Citizen.FARMER);
			}
			updateAppearance();
		}
	}

	public function setSupply(s:Int):Void
	{
		supply = s;
		updateAppearance();
	}

	public function updateAppearance():Void
	{
		animation.frameIndex = supply;
		if (type == BOWS) {
			animation.frameIndex += 5;
		}
	}

	public function canBuild():Bool
	{
		return (supply < 4);
	}

	public function build():Void
	{
		cast(FlxG.state, PlayState).boughtItem = true;
		supply += 1;
		FlxFlicker.flicker(this, 0.3);
		updateAppearance();
	}

}
