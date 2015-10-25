package ;

import flixel.FlxSprite;
import flixel.FlxG;

class Haze extends FlxSprite
{
	private var weather:Weather;
	private var weatherChanged:Float = -1;

	public static var utils:Utils = new Utils();

	public function new(X:Float, Y:Float, weather:Weather)
	{
		super(X, Y);
		this.weather = weather;
		makeGraphic(FlxG.width, FlxG.height, 0x00000000);
		scrollFactor.x = 0;
	}

	override public function draw():Void
	{
		if (weather.changed > weatherChanged)
		{
			//fill(0);
			utils.gradientOverlay(pixels, [weather.haze & 0xFFFFFF, weather.haze], 90, 1);
			weatherChanged = weather.t;
			dirty = true;
		}
		super.draw();
	}

}
