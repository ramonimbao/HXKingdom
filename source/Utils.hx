package ;

import flixel.util.FlxRandom;
import flash.display.BitmapData;
import flash.display.GradientType;
import flash.display.InterpolationMethod;
import flash.display.Shape;
import flash.display.SpreadMethod;
import flash.geom.Rectangle;
import flash.geom.Matrix;
import flash.Vector.Vector;
import flash.Vector.Vector;
import flash.Vector.Vector;
import flash.Vector.Vector;
import flash.Vector.Vector;
import flash.Vector.Vector;
import flixel.util.FlxPoint;
import flixel.FlxSprite;
import flixel.effects.particles.FlxParticle;
import flixel.group.FlxGroup;
import flixel.FlxG;

/**
 * ...
 * @author 
 */
class Utils
{
	public static inline var DEG_TO_RAD:Float = 0.01745329251994329576923690768489; // Math.PI / 180
	
	public static var ROMAN_VALUES:Array<Int>;
	public static var ROMAN_LETTERS:Array<String>;
	
	public function new()
	{
		ROMAN_VALUES = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
		ROMAN_LETTERS = ['M', 'CM', 'D', 'CD', 'C', 'XC', 'L', 'XL', 'X', 'IX', 'V' , 'IV', 'I'];
	}

	public function shrinkHitbox(sprite:FlxSprite, minXCover:Float = 0, minYCover:Float = 0.5):Void
	{
		var pix:BitmapData = sprite.pixels;
		var x:Int, y:Int, sum:Int = 0;
		var minx:Int = pix.width;
		var maxx:Int = 0;
		var miny:Int = pix.height;
		var maxy:Int = 0;
		for (x in 0...pix.width)
		{
			sum = 0;
			for (y in 0...pix.height)
			{
				if (pix.getPixel32(x, y) > 0x00FFFFFF) sum++;
			}
			if (sum >= minXCover * pix.height)
			{
				minx = Std.int(Math.min(minx, x));
				maxx = Std.int(Math.max(maxx, x));
			}
		}
		for (y in 0...pix.height)
		{
			sum = 0;
			for (x in 0...pix.width)
			{
				if (pix.getPixel32(x, y) > 0x00FFFFFF) sum++;
			}
			if (sum >= minYCover * pix.width)
			{
				miny = Std.int(Math.min(miny, y));
				maxy = Std.int(Math.max(maxy, y));
			}
		}
		
		sprite.width = maxx - minx;
		sprite.height = maxy - miny;
		sprite.offset.x = minx;
		sprite.offset.y = miny;
		sprite.x += minx / 2;
		sprite.y += miny / 2;
	}
	
	public function findRectanglesWithColor(bitmap:BitmapData, color:UInt):Vector<Rectangle>
	{
		var cur:Rectangle;
		var rects:Vector<Rectangle> = new Vector<Rectangle>();
		var i:Int = 0;
		var j:Int = 0;
		var k:Int = 0;
		while (i < bitmap.height)
		{
			while (j < bitmap.width)
			{
				while (k < rects.length)
				{
					cur = rects[k];
					// If we are in a rect, skip to the right side.
					if (cur.contains(j, i))
					{
						j = Std.int(cur.right);
						// If we are outside the image, next line.
						if (j >= bitmap.width)
						{
							j = 0;
							i++;
						}
					}
					k++;
				}
				if (bitmap.getPixel32(j, i) == color)
				{
					rects.push(cur = new Rectangle(j, i, 1, 1));
					// Traverse to right
					while (bitmap.getPixel32(j, i) == color)
					{
						j++;
					}
					cur.width = j - cur.x;
					// Traverse down
					while (bitmap.getPixel32(j - 1, i) == color)
					{
						i++;
					}
					cur.height = i - cur.y;
					// Reset I and J
					j = Std.int(cur.right);
					i = Std.int(cur.y);
				}
				j++;
			}
			i++;
		}
		
		return rects;
	}
	
	public function replaceColor(bitmap:BitmapData, fromColor:UInt, toColor:UInt):Void
	{
		for (i in 0...bitmap.height)
		{
			for (j in 0...bitmap.width)
			{
				if (bitmap.getPixel32(j, i) == fromColor)
				{
					bitmap.setPixel32(j, i, toColor);
				}
			}
		}
	}
	
	public function gradientOverlay(bitmap:BitmapData, colors:Array<Int>, rotation:Float = 90, chunks:Int = 1):Void
	{
		var matrix = new Matrix();
		matrix.createGradientBox(bitmap.width / chunks, bitmap.height / chunks, rotation * DEG_TO_RAD);
		var s:Shape = new Shape();
		var ratios:Array<Int> = new Array<Int>();
		var alphas:Array<Int> = new Array<Int>();
		
		
		for (i in 0...colors.length)
		{
			alphas[i] = Std.int((colors[i] >>> 24) / 255);
			ratios[i] = Std.int((i * (1 / (colors.length - 1))) * 255);
		}
		
		s.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix, SpreadMethod.PAD, InterpolationMethod.RGB);
		
		s.graphics.drawRect(0, 0, bitmap.width / chunks, bitmap.height / chunks);
		
		if (chunks == 1)
		{
			bitmap.draw(s);
		}
		else
		{
			var transform:Matrix = new Matrix();
			var tempBitmap:BitmapData = new BitmapData(Std.int(bitmap.width / chunks), Std.int(bitmap.height / chunks), true, 0x000000);
			tempBitmap.draw(s);
			transform.scale(bitmap.width / tempBitmap.width, bitmap.height / tempBitmap.height);
			bitmap.draw(tempBitmap, transform);
		}
	}
	
	public function HSVtoRGB(h:Float, s:Float, v:Float):UInt
	{
		var result:UInt = 0x00000000;
		if (s == 0.0)
		{
			result = getColor32(255, v * 255, v * 255, v * 255);
		}
		else
		{
			h = h / 60.0;
			var f:Float = h - Std.int(h);
			var p:Float = v * (1.0 - s);
			var q:Float = v * (1.0 - s * f);
			var t:Float = v * (1.0 -s * (1.0 -f));
			
			switch(Std.int(h))
			{
				case 0:
					result = getColor32(255, v * 255, t * 255, p * 255);
					
				case 1:
					result = getColor32(255, q * 255, v * 255, p * 255);
					
				case 2:
					result = getColor32(255, p * 255, v * 255, t * 255);
					
				case 3:
					result = getColor32(255, p * 255, q * 255, v * 255);
					
				case 4:
					result = getColor32(255, t * 255, p * 255, v * 255);
					
				case 5:
					result = getColor32(255, v * 255, p * 255, q * 255);
					
				default:
					trace("FlxColor Error: HSVtoRGB : Unknown color");
			}
		}
		
		return result;
	}
	
	public function RGBtoHSV(color:UInt):HSV
	{
		var rgb:ARGB = getRGB(color);
		
		var red:Float = rgb.red / 255;
		var green:Float = rgb.green / 255;
		var blue:Float = rgb.blue / 255;
		
		var min:Float = Math.min(red, Math.min(green, blue));
		var max:Float = Math.min(red, Math.min(green, blue));
		var delta:Float = max - min;
		var lightness:Float = (max + min) / 2;
		var hue:Float = 0;
		var saturation:Float = 0;
		
		// Grey color, no chroma
		if (delta == 0)
		{
			hue = 0;
			saturation = 0;
		}
		else
		{
			if (lightness < 0.5)
			{
				saturation = delta / (max + min);
			}
			else
			{
				saturation = delta / (2 - max - min);
			}
			
			var delta_r:Float = (((max - red) / 6) + (delta / 2)) / delta;
			var delta_g:Float = (((max - green) / 6) + (delta / 2)) / delta;
			var delta_b:Float = (((max - blue) / 6) + (delta / 2)) / delta;
			
			if (red == max)
			{
				hue = delta_b - delta_g;
			}
			else if (green == max)
			{
				hue = (1 / 3) + delta_r - delta_b;
			}
			else if (blue == max)
			{
				hue = (2 / 3) + delta_g - delta_r;
			}
			if (hue < 0)
			{
				hue += 1;
			}
			if (hue > 1)
			{
				hue -= 1;
			}
		}
		
		// Keep the value with 0 to 359
		hue *= 360;
		hue = Math.round(hue);
		
		return new HSV(hue, saturation, lightness, lightness);
	}
	
	public function interpolateColor(color1:UInt, color2:UInt, f:Float):UInt
	{
		var a1:UInt = color1 >>> 24;
		var r1:UInt = color1 >> 16 & 0xFF;
		var g1:UInt = color1 >> 8 & 0xFF;
		var b1:UInt = color1 & 0xFF;
		
		var a2:UInt = color2 >>> 24;
		var r2:UInt = color2 >> 16 & 0xFF;
		var g2:UInt = color2 >> 8 & 0xFF;
		var b2:UInt = color2 & 0xFF;
		
		var fi:Float = 1 - f;
		
		var a = Std.int((fi * a1) + (f * a2));
		var r = Std.int((fi * r1) + (f * r2));
		var g = Std.int((fi * g1) + (f * g2));
		var b = Std.int((fi * b1) + (f * b2));
		
		return a << 24 | r << 16 | g << 8 | b;
	}
	
	public function interpolateColorAndAlpha(color1:UInt, color2:UInt, steps:UInt, currentStep:UInt):UInt
	{
		var src1:ARGB = getRGB(color1);
		var src2:ARGB = getRGB(color2);
		
		var a = (((src2.alpha - src1.alpha) * currentStep) / steps) + src1.alpha;
		var r = (((src2.red - src1.red) * currentStep) / steps) + src1.red;
		var g = (((src2.green - src1.green) * currentStep) / steps) + src1.green;
		var b = (((src2.blue - src1.blue) * currentStep) / steps) + src1.blue;
		
		return getColor32(a, r, g, b);
	}
	
	public function getRGB(color:UInt):ARGB
	{
		var alpha:UInt = color >>> 24;
		var red:UInt = color >> 16 & 0xFF;
		var green:UInt = color >> 8 & 0xFF;
		var blue:UInt = color & 0xFF;
		
		return new ARGB(alpha, red, green, blue);
	}
	
	public function getColor32(alpha:Dynamic, red:Dynamic, green:Dynamic, blue:Dynamic):UInt
	{
		return alpha << 24 | red << 16 | green << 18 | blue;
	}
	
	public function explode(object:FlxSprite, group:FlxGroup, portion:Float = 1, gibSize:Int = 4, rounded:Bool = true):Vector<FlxParticle>
	{
		var gibs:Vector<FlxParticle> = new Vector<FlxParticle>();
		var gib:FlxParticle;
		
		var x:Int = 0;
		var y:Int = 0;
		while (x < object.framePixels.width)
		{
			while (y < object.framePixels.height)
			{
				if ((object.framePixels.getPixel32(x + Std.int(gibSize / 2), y + Std.int(gibSize / 2)) >>> 24) > 0)
				{
					if (FlxRandom.float() < portion)
					{
						gib = cast(group.recycle(FlxParticle), FlxParticle);
						if (gib.frameWidth != gibSize || gib.frameHeight != gibSize)
						{
							gib.makeGraphic(gibSize, gibSize, 0, true);
						}
						gib.revive();
						
						gib.stamp(object, -x, -y);
						if (rounded)
						{
							gib.framePixels.setPixel32(0, 0, 0);
							gib.framePixels.setPixel32(0, gibSize-1, 0);
							gib.framePixels.setPixel32(gibSize-1, 0, 0);
							gib.framePixels.setPixel32(gibSize-1, gibSize-1, 0);
						}
						gibs.push(gib);
						gib.elasticity = 0.5;
						gib.lifespan = 7;
						gib.x = object.x - object.offset.x + x;
						gib.y = object.y - object.offset.y + y;
						gib.acceleration.y = 900;
						gib.velocity.x = FlxRandom.float() * 80 - 40;
						gib.velocity.y = -130 - FlxRandom.float() * 30;
					}
				}
				
				y += gibSize;
			}
			x += gibSize;
		}
		
		return gibs;
	}
	
	public function toRoman(n:Int):String
	{
		var s:String = '';
		for (i in 0...ROMAN_LETTERS.length)
		{
			var c:Int = Math.floor(n / ROMAN_VALUES[i]);
			n -= c * ROMAN_VALUES[i];
			while (c > 0)
			{
				s += ROMAN_LETTERS[i];
				c = c - 1;
			}
		}
		return s;
	}
}

class HSV
{
	public var hue:Float;
	public var saturation:Float;
	public var lightness:Float;
	public var value:Float;
	
	public function new(H:Float, S:Float, V:Float, L:Float)
	{
		hue = H;
		saturation = S;
		lightness = V;
		value = V;
	}
}

class ARGB
{
	public var alpha:Int;
	public var red:Int;
	public var green:Int;
	public var blue:Int;
	
	public function new(A:Int, R:Int, G:Int, B:Int)
	{
		alpha = A;
		red = R;
		green = G;
		blue = B;
	}
}