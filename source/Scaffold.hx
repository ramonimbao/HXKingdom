package ;

import flash.geom.Point;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxPoint;

class Scaffold extends FlxSprite
{

	public function new() 
	{
		super(0, 0);
		loadGraphic("assets/gfx/scaffold.png");
		offset.x = 4;
		width = 24;
	}
	
	public function build(over:FlxSprite):Scaffold
	{
		revive();
		x = over.x;
		y = over.y;
		return this;
	}
	
}