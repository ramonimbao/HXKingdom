package ;

import flixel.FlxG;

import com.quasimondo.geom.ColorMatrix;

/**
 * ...
 * @author 
 */
class Weather
{
	public var sky:UInt 			= 0xFF8C8CA6;
	public var horizon:UInt 		= 0xFFCF7968;
	public var haze:UInt 			= 0xAAF3F1E8;
	public var darknessColor:UInt 	= 0x88111114;
	public var darkness:Float 		= 1.0;
	public var contrast:Float 		= 0.3;
	public var saturation:Float		= 1.0;
	public var ambient:UInt 		= 0x11FF0000;
	public var wind:Float			= 0.0;
	public var fog:Float			= 0.5;
	public var rain:Float			= 0.5;
	public var timeOfDay:Float		= 0.5;
	public var sunTint:UInt			= 0xFFFFFF;
	
	public var ambientTransform:ColorMatrix;
	
	public var t:Float			= 0;
	public var changed:Float	= 0;
	public var progress:Float	= 0;
	public var ambientAmount:Float = 0;
	
	public var tweenStart:Float 		= 0.0;
	public var tweenDuration:Float		= 0.0;
	public var previousState:Dynamic;
	public var targetState:Dynamic;
	
	public static var weatherPresets:WeatherPresets;
	public static var utils:Utils;

	public function new() 
	{
		ambientTransform = new ColorMatrix();
		
		weatherPresets = new WeatherPresets();
		
		previousState = weatherPresets.SUNNY;
		targetState = weatherPresets.SUNNY;
		
		setVariables(weatherPresets.SUNNY);
	}
	
	public function update():Void
	{
		t += FlxG.elapsed;
		if (t - changed > 1 / 30) {
			updateTween();
			changed = t;
		}
	}
	
	public function tweenTo(state:Dynamic, d:Float = 30):Void
	{
		targetState = state;
		if (d == 0)
		{
			setVariables(state);
			previousState = state;
		}
		else
		{
			tweenDuration = d;
			tweenStart = d;
		}
	}
	
	public function updateTween():Void
	{
		if (targetState == previousState) return;
		// Compute the tween factor
		progress = (t - tweenStart) / tweenDuration;
		if (tweenDuration == 0 || progress >= 1)
		{
			previousState = targetState;
			progress = 1;
		}
		setVariables(targetState, previousState, progress);
	}
	
	private function setVariables(target:WPNode, previous:WPNode = null, f:Float = 1):Void
	{
		if (previous == null)
		{
			previous = target;
		}
		
		var fi:Float = 1 - f;
		// Loop through variables and tween them
		for (v in 0...target.arr.length)
		{
			if (v == 0)
			{
				this.saturation = (fi * previous.saturation) + (f * target.saturation);
			}
			else if (v == 1)
			{
				this.darkness = (fi * previous.darkness) + (f * target.darkness);
			}
			else if (v == 5)
			{
				this.fog = (fi * previous.fog) + (f * target.fog);
			}
			else if (v == 6)
			{
				this.contrast = (fi * previous.contrast) + (f * target.contrast);
			}
			else if (v == 10)
			{
				this.wind = (fi * previous.wind) + (f * target.wind);
			}
			// timeOfDay is weird and circular
			else if (v == 9)
			{
				if (target.timeOfDay > previous.timeOfDay)
				{
					this.timeOfDay = (previous.timeOfDay + (target.timeOfDay - previous.timeOfDay) * f) % 1;
				}
				else
				{
					this.timeOfDay = (previous.timeOfDay + (target.timeOfDay + 1 - previous.timeOfDay) * f) % 1;
				}
			}
			// Start handling UInt's (2,3,4,7,8)
			/*else
			{
				// Interpolate a color.
				this[v] = Utils.interpolateColor(previous[v], target[v], f);
			}*/
			else if (v == 2)
			{
				this.sky = utils.interpolateColor(previous.sky, target.sky, f);
			}
			else if (v == 3)
			{
				//this.
			}
		}
		
		// Set the other vars
		ambientTransform.reset();
		
		ambientTransform.colorize(ambient, ambientAmount);
		ambientTransform.adjustContrast(contrast);
		ambientTransform.adjustSaturation(saturation);
		
		// Set opacity of the darknessColor to darkness.
		darknessColor = (darknessColor * 0x00FFFFFF) | (cast(0xFF * darkness, UInt) << 24);
	}
	
}