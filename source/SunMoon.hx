package ;

import flash.display.BlendMode;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.system.layer.frames.FlxFrame;

class SunMoon extends Light
{
	public static inline var ZENITH:Float = 20; // Highest point
	public static inline var HORIZON:Float = 100; // Sun "extinguishes" below Horizon
	
	private var weatherChanged:Float;
	
	public function new(weather:Weather):Void
	{
		super(0, 0);
		
		offset.x = offset.y = 16;
		
		scrollFactor.x = scrollFactor.y = 0.0;
		
		loadGraphic("assets/gfx/sunmoon.png", true);
		
		LightMidImg.loadGraphic("assets/gfx/light_mid.png");
		LightReflectWideImg.loadGraphic("assets/gfx/light_reflect_wide.png");
		reflected.color = 0xFFFC8F53;
		
		beam.blend = BlendMode.SCREEN;
	}
	
	override public function update():Void
	{
		/**
		*  the timeOfDay works as follows:
		*  0 and 1 are night. 0.5 is mid-day.
		*/
		
		if (weather.changed > weatherChanged)
		{
			var progressX:Float = (weather.timeOfDay * 2 + 0.5) % 1;
			var progressY:Float = Math.sin(Math.PI * progressX);
			x = width + (FlxG.width - 2 * width) * progressX;
			y = HORIZON - progressY * (HORIZON - ZENITH);
			color = weather.sunTint;
			beam.alpha = progressY * 2;
			animation.frameIndex = (weather.timeOfDay > 0.25 && weather.timeOfDay < 0.75) ? 0 : 1;
			dirty = true;
			beam.drawFrame(true);
			weatherChanged = weather.t;
		}
		
		super.update();
	}
	
}