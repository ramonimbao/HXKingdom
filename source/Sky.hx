package ;

import flixel.FlxSprite;
import flixel.FlxG;

/**
 * ...
 * @author
 */

class Sky extends FlxSprite
{
	private var weather:Weather;
	private var weatherChanged:Float = 0;

	public var utils:Utils = new Utils();

	public function new(weather:Weather):Void
	{
		super();

		this.weather = weather;
		scrollFactor.x = scrollFactor.y = 0;
		makeGraphic(FlxG.width, FlxG.height, 0x00000000, true);
	}

	override public function update():Void
	{
		if (weather.changed > weatherChanged) {
			utils.gradientOverlay(pixels, [weather.sky, weather.horizon, weather.haze], 90, 1);
			dirty = true;
			weatherChanged = weather.t;
		}
	}

}
