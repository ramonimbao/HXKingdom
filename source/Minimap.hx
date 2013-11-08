package ;

import flash.geom.Point;
import flash.geom.Rectangle;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxBasic;
import flixel.group.FlxGroup;

class Minimap extends FlxSprite
{
	public var members:Array<FlxBasic>;
	public var colors:Array<UInt>;
	
	public function new(X:Float = 0, Y:Float = 0, w:Int = 100, h:Int = 10)
	{
		members = [];
		colors = [];
		
		super(X, Y);
		scrollFactor.x = scrollFactor.y = 0;
		makeGraphic(w, h, 0, true);
	}
	
	public function add(member:FlxBasic, color:UInt = 0xFFFF0000):Void
	{
		members.push(member);
		colors.push(color);
	}
	
	override public function draw():Void
	{
		//fill(0x55000000);
		pixels.fillRect(new Rectangle(0, 0, width, height), 0x55000000);
		
		for (i in 0...members.length)
		{
			drawDot(members[i], colors[i]);
		}
		dirty = true;
		super.draw();
	}
	
	public function drawDot(m:FlxBasic, color:UInt):Void
	{
		if (Std.is(m, FlxGroup))
		{
			var group:FlxGroup = cast(m, FlxGroup);
			for ( i in 0...group.length)
			{
				drawDot(group.members[i], color);
			}
		}
		else if (Std.is(m, FlxSprite))
		{
			if (!m.alive || !m.visible) return;
			if (Std.is(m, Wall) && cast(m, Wall).stage == 0) return;
			var sprite:FlxSprite = cast(m, FlxSprite);
			var ex:Int = Std.int((sprite.x / FlxG.worldBounds.width) * this.width);
			var ey:Int = Std.int((sprite.y / FlxG.worldBounds.height) * this.height);
			this.pixels.setPixel32(ex, ey, color);
		}
	}
	
}