package ;

import flixel.math.FlxRandom;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.math.FlxPoint;

class Fog extends FlxGroup
{
	private var FogImg:FlxSprite;

	public static inline var MAXFOG:Int = 5;

	private var weather:Weather;
	private var weatherChanged:Float;
	private var _fg:FlxSprite;
	private var _point:FlxPoint;
	private var random:FlxRandom = new FlxRandom();

	public function new(weather:Weather)
	{
		_point = new FlxPoint();

		weatherChanged = -1;

		super(MAXFOG);
		this.weather = weather;

		for (i in 0...MAXFOG)
		{
			_fg = new FlxSprite(0, 0).loadGraphic("assets/gfx/fog.png", true, 256, 96);
			_fg.scrollFactor.y = 1.2;
			_fg.scrollFactor.x = (random.float() < 0.5) ? 1.5 : 2.5;
			_fg.facing = (random.float() < 0.5) ? FlxObject.LEFT : FlxObject.RIGHT;
			_fg.animation.frameIndex = Std.int(random.float() * 4);
			_fg.kill();
			add(_fg);
		}
	}

	override public function update(elapsed:Float):Void
	{
		for (i in 0...members.length)
		{
			_fg = cast(members[i],FlxSprite);
			if (_fg.exists)
			{
				_fg.getScreenPosition(_point);
				if (_point.x + _fg.width < -100 || _point.x > FlxG.width + 100)
				{
					_fg.kill();
				}
				else
				{
					_fg.velocity.x = -weather.wind * 20;
				}
			}
		}

		if (weather.changed > weatherChanged)
		{
			// TODO: Does this run every frame?
			if (countLiving() < MAXFOG * weather.fog)
			{
				_fg.reset(0, 0);
				if (random.float() < 0.5)
				{
					_fg.x = FlxG.camera.scroll.x * _fg.scrollFactor.x - _fg.width;
				}
				else
				{
					_fg.x = (FlxG.camera.scroll.x) * _fg.scrollFactor.x + FlxG.width;
				}
				_fg.y = 112 + 50 * random.float();
				var comp:Int = Std.int((1 - weather.darkness) * 255);
				var color:UInt = comp << 16 | comp <<  8 | comp;
				_fg.color = color;
				_fg.alpha = weather.fog / 6 + 0.3;
			}
			weatherChanged = weather.t;
		}
		super.update(elapsed);
	}

}
