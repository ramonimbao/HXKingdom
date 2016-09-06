package ;

import flash.display.BitmapData;
import flash.display.BitmapDataChannel;
#if flash
import flash.filters.DisplacementMapFilter;
import flash.filters.DisplacementMapFilterMode;
#end
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.FlxG;

class Water extends FlxSprite
{

	public static inline var NOISE_BIAS:Int = 100;
	public static inline var WIND_RIPPLE_MULTIPLIER:Float = 25;

	private var rect:Rectangle;
	private var zeroPoint:Point;
	private var perlinOffset:Point;
	private var matrix:Matrix;
	private var transform:ColorTransform;
	private var noiseRange:ColorTransform;
	#if flash
	private var displacementFilter:DisplacementMapFilter;
	private var displacementBitmap:BitmapData;
	#end
	private var baseColor:UInt;
	private var currentBase:UInt;
	private var timer:Float;
	private var lights:FlxGroup;
	private var weather:Weather;
	private var weatherChanged:Float;

	public static var utils:Utils = new Utils();

	public function new(x:Float, y:Float, width:Int, height:Int, lights:FlxGroup, weather:Weather, baseColor:UInt = 0xFF686C53, reflectivity:Float = 0.3)
	{
		super(x, y);

		timer = 0;
		weatherChanged = -1;

		rect = new Rectangle(0, 0, 480, 160);
		zeroPoint = new Point(0, 0);
		perlinOffset = new Point(0, 0);
		matrix = new Matrix();

		// set height/width/x/y
		this.x = x;
		this.y = y;
		moves = false;
		scrollFactor.x = 0;

		transform			= new ColorTransform(1, 1, 1, reflectivity);
		rect				= new Rectangle(0, 0, width, height);
		#if flash
		displacementBitmap	= new BitmapData(width, height, false, 0);
		#end
		makeGraphic(width, height, baseColor);

		this.lights = lights;
		this.weather = weather;
		this.baseColor = baseColor;

		#if flash
		// This is the filter that makes the reflection ripple
		displacementFilter = new DisplacementMapFilter(displacementBitmap, zeroPoint, 1, 2, 256, 56, DisplacementMapFilterMode.COLOR, baseColor, 0.5);
		#end

		// Reduce the range of perlin transform
	}

	override public function update(elapsed:Float):Void
	{
		timer += elapsed;
		if (weather.changed > weatherChanged)
		{
			currentBase = 0xFF000000 | utils.interpolateColor(baseColor, weather.darknessColor, weather.darkness);

			var rippleScale:Int = Std.int(weather.wind * WIND_RIPPLE_MULTIPLIER);
			var xscale:Int = Std.int(rippleScale / 2);
			var yscale:Int = rippleScale;
			noiseRange = new ColorTransform(xscale / 128, yscale / 128, 1, 1, (128 - xscale + (NOISE_BIAS * xscale / 128)), (128 - yscale + (NOISE_BIAS * yscale / 128)), 1, 1);
			weatherChanged = weather.t;
		}
	}

	override public function draw():Void
	{
		if (timer > 0.1)
		{ // Update the water ripple
			perlinOffset.y += 1 / 5;
			perlinOffset.x += FlxG.camera.scroll.x * 1.5;
			#if flash
			displacementBitmap.perlinNoise(32, 4, 1, 12312, false, false, 1 | 2, true, [perlinOffset]);
			displacementBitmap.colorTransform(rect, noiseRange);
			//Adjust the base color according to the weather.
			displacementFilter.color = currentBase;
			#end
			timer = 0;
		}
		var px:BitmapData = pixels;
		matrix.identity();
		matrix.scale(1, -1);
		getScreenPosition(_point);
		matrix.translate( -_point.x, _point.y);
		// Clear the reflection
		px.fillRect(rect, currentBase);
		utils.gradientOverlay(px, [0x00000000, 0x66000000], 90, 4);
		// Flip the screen and copy it to the reflection
		#if (flash || js)
		px.draw(FlxG.camera.buffer, matrix, transform);
		#else
		px.draw(FlxG.camera.canvas, matrix, transform);
		#end

		// Draw the lights
		var l:Light;
		for (i in 0...lights.length)
		{
			l = cast(lights.members[i], Light);
			l.getScreenPosition(_point);
			if (l.visible && -64 < _point.x && _point.x < FlxG.width + 64)
			{
				l.reflected.alpha = weather.darkness * 0.8;
				l.reflected.alpha *= Math.min(1.0, (weather.wind * 10));
				l.reflected.drawFrame();
				//stamp(l.reflected, _point.x - l.reflected.width / 2 + 4, (y - l.y) * 0.3);
				stamp(l.reflected, Std.int(_point.x - l.reflected.width / 2 +4), Std.int((y - l.y) * 0.3));
			}
		}

		// Apply the ripple filter
		#if flash
		px.applyFilter(px, rect, zeroPoint, displacementFilter);
		#end
		dirty = true;
		super.draw();
	}
}
