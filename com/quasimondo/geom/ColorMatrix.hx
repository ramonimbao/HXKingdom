/*

	ColorMatrix Class v2.41

	released under MIT License (X11)
	http://www.opensource.org/licenses/mit-license.php

	Author: Mario Klingemann
	http://www.quasimondo.com
	
	
	Big parts of this class are based on information found in
	"Matrix Operations for Image Processing"
	by Paul Haeberli
	http://web.archive.org/web/20060110044204/http://www.sgi.com/misc/grafica/matrix/
	
	Matrix factors for the applyColorDeficiency() method
	have been copied from http://www.nofunc.com/Color_Matrix_Library/ 
			
	
	Copyright (c) 2006-2010 Mario Klingemann

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.
*/
	
/*
 Ported to Haxe+OpenFL by Ramon Imbao.
*/

package com.quasimondo.geom;

import flash.Vector;
import flash.display.BitmapData;
import flash.filters.ColorMatrixFilter;
import flash.geom.Matrix3D;
import flash.geom.Point;

class ColorMatrix
{
	// INITIALIZATION OF VARIABLES
	public static var COLOR_DEFICIENCY_TYPES:Array<Dynamic>;
	
	private static inline var LUMA_R:Float = 0.0212;
	private static inline var LUMA_G:Float = 0.71516;
	private static inline var LUMA_B:Float = 0.72169;
	
	private static inline var LUMA_R2:Float = 0.3086;
	private static inline var LUMA_G2:Float = 0.6094;
	private static inline var LUMA_B2:Float = 0.0820;
	
	private static inline var ONETHIRD:Float = 0.33333333333333333333333333333333;
	
	private static var IDENTITY:Array<Float>;
	
	private static inline var RAD:Float = 0.01745329251994329576923690768489; // PI / 180
	
	public function new(mat:Dynamic = null)
	{
		COLOR_DEFICIENCY_TYPES = ['Protanopia',
								'Protanomaly',
								'Deuteronapoia',
								'Deuteranomaly',
								'Tritanopia',
								'Tritanomaly',
								'Achromatopsia',
								'Ahcromatomaly'];
		
		IDENTITY = [1, 0, 0, 0, 0,
					0, 1, 0, 0, 0,
					0, 0, 1, 0, 0,
					0, 0, 0, 1, 0,
					0, 0, 0, 0, 1];
		
		if (Std.is(mat, ColorMatrix))
		{
			matrix = mat.matrix.concat();
		}
		else if (Std.is(mat, Array))
		{
			matrix = mat.concat();
		}
		else
		{
			reset();
		}
	}
	
	public var matrix:Array<Float>;
	
	private var preHue:ColorMatrix;
	private var postHue:ColorMatrix;
	private var hueInitialized:Bool;
	
	public function reset():Void
	{
		matrix = IDENTITY.concat(null);
	}
	
	public function clone():ColorMatrix
	{
		return new ColorMatrix(matrix);
	}
	
	public function invert():Void
	{
		concat([ -1, 0, 0, 0, 255,
						0, -1, 0, 0, 255,
						0, 0, -1, 0, 255,
						0, 0, 0, 1, 0]);
	}
	
	public function adjustSaturation(s:Float = 1):Void
	{
		var sInv:Float;
		var irlum:Float;
		var iglum:Float;
		var iblum:Float;
		
		sInv = (1 - s);
		irlum = (sInv * LUMA_R);
		iglum = (sInv * LUMA_G);
		iblum = (sInv * LUMA_B);
		
		concat([(irlum + s), iglum, iblum, 0, 0,
				irlum, (iglum + s), iblum, 0, 0,
				irlum, iglum, (iblum + s), 0, 0,
				0, 0, 0, 1, 0]);
		
	}
	
	public function adjustContrast(r:Float = 0, g:Dynamic = null, b:Dynamic = null):Void
	{
		if (g == null) g = r;
		if (b == null) b = r;
		r += 1;
		g += 1;
		b += 1;
		
		concat([r, 0, 0, 0, (128 * (1 - r)),
				0, g, 0, 0, (128 * (1 - g)),
				0, 0, b, 0, (128 * (1 - b)),
				0, 0, 0, 1, 0]);
	}
	
	public function adjustBrightness(r:Float = 0, g:Dynamic = null, b:Dynamic = null):Void
	{
		if (g == null) g = r;
		if (b == null) b = r;
		concat([1, 0, 0, 0, r,
				0, 1, 0, 0, g,
				0, 0, 1, 0, b,
				0, 0, 0, 1, 0]);
	}
	
	public function toGreyscale(r:Float = LUMA_R, g:Float = LUMA_G, b:Float = LUMA_B):Void
	{
		concat([r, g, b, 0, 0,
				r, g, b, 0, 0,
				r, g, b, 0, 0,
				0, 0, 0, 1, 0]);
	}
	
	public function adjustHue(degrees:Float = 0):Void
	{
		degrees *= RAD;
		var cos:Float = Math.cos(degrees);
		var sin:Float = Math.sin(degrees);
		concat([((LUMA_R + (cos * (1 - LUMA_R))) + (sin * -(LUMA_R))), ((LUMA_G + (cos * -(LUMA_G))) + (sin * -(LUMA_G))), ((LUMA_B + (cos * -(LUMA_B))) + (sin * (1 - LUMA_B))), 0, 0, 
            	((LUMA_R + (cos * -(LUMA_R))) + (sin * 0.143)), ((LUMA_G + (cos * (1 - LUMA_G))) + (sin * 0.14)), ((LUMA_B + (cos * -(LUMA_B))) + (sin * -0.283)), 0, 0, 
            	((LUMA_R + (cos * -(LUMA_R))) + (sin * -((1 - LUMA_R)))), ((LUMA_G + (cos * -(LUMA_G))) + (sin * LUMA_G)), ((LUMA_B + (cos * (1 - LUMA_B))) + (sin * LUMA_B)), 0, 0, 
            	0, 0, 0, 1, 0]);
	}
	
	public function rotateHue(degrees:Float = 0):Void
	{
		initHue();
		
		matrix.concat(preHue.matrix);
		rotateBlue(degrees);
		concat(postHue.matrix);
	}
	
	public function luminance2Alpha():Void
	{
		concat([0, 0, 0, 0, 255,
				0, 0, 0, 0, 255,
				0, 0, 0, 0, 255,
				LUMA_R, LUMA_G, LUMA_B, 0, 0]);
	}
	
	public function adjustAlphaContrast(amount:Float = 0):Void
	{
		amount += 1;
		concat([1, 0, 0, 0, 0,
				0, 1, 0, 0, 0,
				0, 0, 1, 0, 0,
				0, 0, 0, amount, (128 * (1 - amount))]);
	}
	
	public function colorize(rgb:UInt, amount:Float = -1):Void
	{
		var a:Float;
		var r:Float;
		var g:Float;
		var b:Float;
		var inv_amount:Float;
		
		a = ((rgb >> 24) / 0xFF);
		r = (((rgb >> 16) & 0xFF) / 0xFF);
		g = (((rgb >> 8) & 0xFF) / 0xFF);
		b = ((rgb & 0xFF) / 0xFF);
		
		if (amount == -1) {
			amount = a;
		}
		inv_amount = (1 - amount);
		
		concat([(inv_amount + ((amount * r) * LUMA_R)), ((amount * r) * LUMA_G), ((amount * r) * LUMA_B), 0, 0, 
            		((amount * g) * LUMA_R), (inv_amount + ((amount * g) * LUMA_G)), ((amount * g) * LUMA_B), 0, 0, 
            		((amount * b) * LUMA_R), ((amount * b) * LUMA_G), (inv_amount + ((amount * b) * LUMA_B)), 0, 0, 
            		0, 0, 0, 1, 0]);
	}
	
	private function Bool2Int(x:Bool)
	{
		if (x == true)
		return 1;
		else
		return 0;
	}
	
	public function setChannels(r:Int = 1, g:Int = 2, b:Int = 4, a:Int = 8):Void
	{
		var rf:Float = 0;
		rf += ((r & 1) == 1) ? 1 : 0;
		rf += ((r & 2) == 2) ? 1 : 0;
		rf += ((r & 4) == 4) ? 1 : 0;
		rf += ((r & 8) == 8) ? 1 : 0;
		if (rf > 0)
		{
            rf = (1 / rf);
        }
		
		var gf:Float = 0;
		gf += ((g & 1) == 1) ? 1 : 0;
		gf += ((g & 2) == 2) ? 1 : 0;
		gf += ((g & 4) == 4) ? 1 : 0;
		gf += ((g & 8) == 8) ? 1 : 0;
		if (gf > 0)
		{
			gf = (1 / gf);
		}
		
		var bf:Float = 0;
		bf += ((b & 1) == 1) ? 1 : 0;
		bf += ((b & 2) == 2) ? 1 : 0;
		bf += ((b & 4) == 4) ? 1 : 0;
		bf += ((b & 8) == 8) ? 1 : 0;
		if (bf > 0)
		{
            bf = (1 / bf);
        }
		
		var af:Float = 0;
		af += ((a & 1) == 1) ? 1 : 0;
		af += ((a & 2) == 2) ? 1 : 0;
		af += ((a & 4) == 4) ? 1 : 0;
		af += ((a & 8) == 8) ? 1 : 0;
		if (af > 0)
		{
			af = (1 / af);
		}
		
		concat([((r & 1) == 1) ? rf : 0, ((r & 2) == 2) ? rf : 0, ((r & 4) == 4) ? rf : 0, ((r & 8) == 8) ? rf : 0,
				((g & 1) == 1) ? gf : 0, ((g & 2) == 2) ? gf : 0, ((g & 4) == 4) ? gf : 0, ((g & 8) == 8) ? gf : 0,
				((b & 1) == 1) ? bf : 0, ((b & 2) == 2) ? bf : 0, ((b & 4) == 4) ? bf : 0, ((b & 8) == 8) ? bf : 0,
				((a & 1) == 1) ? af : 0, ((a & 2) == 2) ? af : 0, ((a & 4) == 4) ? af : 0, ((a & 8) == 8) ? af : 0]);
	}
	
	public function blend(mat:ColorMatrix, amount:Float):Void
	{
		var inv_amount:Float = (1 - amount);
		var i:Int = 0;
		while (i < 20)
		{
			matrix[i] = ((inv_amount * cast(matrix[i], Float)) + (amount * cast(mat.matrix[i], Float)));
			i++;
		}
	}
	
	public function average(r:Float = ONETHIRD, g:Float = ONETHIRD, b:Float = ONETHIRD):Void
	{
		concat([r, g, b, 0, 0,
				r, g, b, 0, 0,
				r, g, b, 0, 0,
				0, 0, 0, 1, 0]);
	}
	
	public function threshold(threshold:Float, factor:Float = 256):Void
	{
		concat([(LUMA_R * factor), (LUMA_G * factor), (LUMA_B * factor), 0, ( -(factor - 1) * threshold),
				(LUMA_R * factor), (LUMA_G * factor), (LUMA_B * factor), 0, ( -(factor - 1) * threshold),
				(LUMA_R * factor), (LUMA_G * factor), (LUMA_B * factor), 0, ( -(factor - 1) * threshold),
				0, 0, 0, 1, 0]);
	}
	
	public function threshold_rgb(threshold:Float, factor:Float = 256):Void
	{
		concat([factor, 0, 0, 0, ( -(factor - 1) * threshold),
				0, factor, 0, 0, ( -(factor - 1) * threshold),
				0, 0, factor, 0, ( -(factor - 1) * threshold),
				0, 0, 0, 1, 0]);
	}
	
	public function desaturate():Void
	{
		concat([LUMA_R, LUMA_G, LUMA_B, 0, 0,
				LUMA_R, LUMA_G, LUMA_B, 0, 0,
				LUMA_R, LUMA_G, LUMA_B, 0, 0,
				0, 0, 0, 1, 0]);
	}
	
	public function randomize(amount:Float = 1, normalize:Bool = false):Void
	{
		var inv_amount:Float = (1 - amount);
		var r1:Float = (inv_amount + (amount * (Math.random() - Math.random())));
        var g1:Float = (amount * (Math.random() - Math.random()));
        var b1:Float = (amount * (Math.random() - Math.random()));
        var o1:Float = ((amount * 0xFF) * (Math.random() - Math.random()));
        var r2:Float = (amount * (Math.random() - Math.random()));
        var g2:Float = (inv_amount + (amount * (Math.random() - Math.random())));
        var b2:Float = (amount * (Math.random() - Math.random()));
        var o2:Float = ((amount * 0xFF) * (Math.random() - Math.random()));
        var r3:Float = (amount * (Math.random() - Math.random()));
        var g3:Float = (amount * (Math.random() - Math.random()));
        var b3:Float = (inv_amount + (amount * (Math.random() - Math.random())));
        var o3:Float = ((amount * 0xFF) * (Math.random() - Math.random()));
		
		concat([r1, g1, b1, 0, o1,
				r2, g2, b2, 0, o2,
				r3, g3, b3, 0, o3,
				0, 0, 0, 1, 0]);
				
		if (normalize) this.normalize();
	}
	
	public function setMultiplicators(red:Float = 1, green:Float = 1, blue:Float = 1, alpha:Float = 1):Void
	{
		var mat:Array<Dynamic> = [red, 0, 0, 0, 0,
						0, green, 0, 0, 0,
						0, 0, blue, 0, 0,
						0, 0, 0, alpha, 0];
											
		concat(mat);
	}
	
	public function clearChannels(red:Bool = false, green:Bool = false, blue:Bool = false, alpha:Bool = false):Void
	{
		if (red)
		{
			matrix[0] = matrix[1] = matrix[2] = matrix[3] = matrix[4] = 0;
		}
		if (green)
		{
			matrix[5] = matrix[6] = matrix[7] = matrix[8] = matrix[9] = 0;
		}
		if (blue)
		{
			matrix[10] = matrix[11] = matrix[12] = matrix[13] = matrix[14] = 0;
		}
		if (alpha)
		{
			matrix[15] = matrix[16] = matrix[17] = matrix[18] = matrix[19] = 0;
		}
	}
	
	public function thresholdAlpha(threshold:Float = 0.5, factor:Float = 256):Void
	{
		concat([1, 0, 0, 0, 0,
				0, 1, 0, 0, 0,
				0, 0, 1, 0, 0,
				0, 0, 1, 0, 0,
				0, 0, 0, factor, ( -factor * threshold)]);
	}
	
	public function averageRGB2Alpha():Void
	{
		concat([0, 0, 0, 0, 255,
				0, 0, 0, 0, 255,
				0, 0, 0, 0, 255,
				ONETHIRD, ONETHIRD, ONETHIRD, 0, 0]);
	}
	
	public function invertAlpha():Void
	{
		concat([1, 0, 0, 0, 0,
				0, 1, 0, 0, 0,
				0, 0, 1, 0, 0,
				0, 0, 0, -1, 255]);
	}
	
	public function rgb2Alpha(r:Float = ONETHIRD, g:Float = ONETHIRD, b:Float = ONETHIRD):Void
	{
		concat([0, 0, 0, 0, 255,
				0, 0, 0, 0, 255,
				0, 0, 0, 0, 255,
				r, g, b, 0, 0, ]);
	}
	
	public function setAlpha(alpha:Float = 1):Void
	{
		concat([1, 0, 0, 0, 0,
				0, 1, 0, 0, 0,
				0, 0, 1, 0, 0,
				0, 0, 0, alpha, 0]);
	}
	
	public var filter(get, null):ColorMatrixFilter;
	public function get_filter()
	{
		return new ColorMatrixFilter(matrix);
	}
	
	public function applyFilter(bitmapData:BitmapData):Void
	{
		bitmapData.applyFilter(bitmapData, bitmapData.rect, new Point(), filter);
	}
	
	public function concat(mat:Array<Dynamic>):Void
	{
		var temp:Array<Float> = [];
		var i:Int = 0;
		var X:Int, y:Int;
		for (y in 0...4)
		{
			for (x in 0...5)
			{
				temp[Std.int(i + x)] = cast(mat[i], Float) * cast(matrix[x], Float) +
								   cast(mat[Std.int(i + 1)], Float) * cast(matrix[Std.int(x + 5)], Float) +
								   cast(mat[Std.int(i + 2)], Float) * cast(matrix[Std.int(x + 5)], Float) +
								   cast(mat[Std.int(i + 3)], Float) * cast(matrix[Std.int(x + 5)], Float) +
								   (x == 4 ? cast(mat[Std.int(i + 4)], Float) : 0);
			}
			i += 5;
		}
		
		matrix = temp;
	}
	
	public function rotateRed(degrees:Float = 0):Void
	{
		rotateColor(degrees, 2, 1);
	}
	
	public function rotateGreen(degrees:Float = 0):Void
	{
		rotateColor(degrees, 0, 2);
	}
	
	public function rotateBlue(degrees:Float = 0):Void
	{
		rotateColor(degrees, 1, 0);
	}
	
	public function normalize():Void
	{
		for (i in 0...4)
		{
			var sum:Float = 0;
			
			for (j in 0...4)
			{
				sum += matrix[i * 5 + j] * matrix[i * 5 + j];
			}
			
			sum = 1 / Math.sqrt(sum);
			
			if (sum != 1)
			{
				for (j in 0...4)
				{
					matrix[i * 5 + j] *= sum;
				}
			}
		}
	}
	
	public function fitRange():Void
	{
		for (i in 0...4)
		{
			var minFactor:Float = 0;
			var maxFactor:Float = 0;
			
			for (j in 0...4)
			{
				if (matrix[Std.int(i * 5 + j)] < 0) minFactor += matrix[Std.int(i * 5 + j)];
				else maxFactor += matrix[Std.int(i * 5 + j)];
			}
			
			var range:Float = maxFactor * 255 - minFactor * 255;
			var rangeCorrection:Float = 255 / range;
			
			if (rangeCorrection != 1)
			{
				for (j in 0...4)
				{
					matrix[Std.int(i * 5 + j)] *= rangeCorrection;
				}
			}
			
			minFactor = 0;
			maxFactor = 0;
			
			for (j in 0...4)
			{
				if (matrix[Std.int(i * 5 + j)] < 0) minFactor += matrix[Std.int(i * 5 + j)];
				else maxFactor += matrix[Std.int(i * 5 + j)];
			}
			
			var worstMin:Float = minFactor * 255;
			var worstMax:Float = maxFactor * 255;
			
			matrix[Std.int(i * 5 + 4)] = - ( worstMin + (worstMax - worstMin) * 0.5 - 127.5 );
		}
	}
	
	public function shearRed(green:Float, blue:Float):Void
	{
		shearColor(0, 1, green, 2, blue);
	}
	
	public function shearGreen(red:Float, blue:Float):Void
	{
		shearColor(1, 0, red, 2, blue);
	}
	
	public function shearBlue(red:Float, green:Float):Void
	{
		shearColor(2, 0, red, 1, green);
	}
	
	public function applyColorDeficiency(type:String):Void
	{
		switch(type)
		{
			case 'Protanopia':
       			concat([0.567,0.433,0,0,0, 0.558,0.442,0,0,0, 0,0.242,0.758,0,0, 0,0,0,1,0]);
            case 'Protanomaly':
                concat([0.817,0.183,0,0,0, 0.333,0.667,0,0,0, 0,0.125,0.875,0,0, 0,0,0,1,0]);	
            case 'Deuteranopia':
             	concat([0.625,0.375,0,0,0, 0.7,0.3,0,0,0, 0,0.3,0.7,0,0, 0,0,0,1,0]);
            case 'Deuteranomaly':
                concat([0.8,0.2,0,0,0, 0.258,0.742,0,0,0, 0,0.142,0.858,0,0, 0,0,0,1,0]);
            case 'Tritanopia':
                concat([0.95,0.05,0,0,0, 0,0.433,0.567,0,0, 0,0.475,0.525,0,0, 0,0,0,1,0]);
            case 'Tritanomaly':
                concat([0.967,0.033,0,0,0, 0,0.733,0.267,0,0, 0,0.183,0.817,0,0, 0,0,0,1,0]);
            case 'Achromatopsia':
               	concat([0.299,0.587,0.114,0,0, 0.299,0.587,0.114,0,0, 0.299,0.587,0.114,0,0, 0,0,0,1,0]);   	 	
            case 'Achromatomaly':
				concat([0.618,0.320,0.062,0,0, 0.163,0.775,0.062,0,0, 0.163,0.320,0.516,0,0, 0,0,0,1,0]);
		}
	}
	
	public function RGB2YUV():Void
	{
		concat([ 0.29900,  0.58700,  0.11400, 0, 0,
				-0.16874, -0.33126,  0.50000, 0, 128,
				 0.50000, -0.41869, -0.08131, 0, 128,
				 0      ,  0      ,  0      , 1, 0  ]);
	}
	
	public function YUV2RGB():Void
	{
		concat([ 1                 , -0.000007154783816076815, 1.4019975662231445    , 0, -179.45477266423404,
				 1                 , -0.3441331386566162     , -0.7141380310058594   , 0,  135.45870971679688,
				 1                 ,  1.7720025777816772     , 0.00001542569043522235, 0, -226.8183044444304,
				 0                 ,  0                      , 0                     , 1,    0  ]);
	}
	
	public function RGB2YIQ():Void
	{
		concat([ 0.2990,  0.5870,  0.1140, 0, 0,
				 0.595716, -0.274453, -0.321263, 0, 128,
				 0.211456, -0.522591, -0.311135, 0, 128,
				 0       , 0        ,  0       , 1, 0  ]);
	}
	
	#if flash
	
	public function autoDesaturate(bitmapData:BitmapData, stretchLevels:Bool = false, outputToBlueOnly:Bool = false):Void
	{
		var histogram:Vector<Vector<Float>> = bitmapData.histogram(bitmapData.rect);
		
		var sum_r:Float = 0;
		var sum_g:Float = 0;
		var sum_b:Float = 0;
		var min:Float = 0;
		var max:Float = 0;
		var minFound:Bool = false;
		
		for (i in 0...256)
		{
			sum_r += histogram[0][i] * i;
			sum_g += histogram[1][i] * i;
			sum_b += histogram[2][i] * i;
			
			if (stretchLevels)
			{
				if (histogram[0][i] != 0 || histogram[1][i] != 0 || histogram[2][i] != 0)
				{
					max = i;
					if (!minFound)
					{
						min = i;
						minFound = true;
					}
				}
			}
		}
		
		var total:Float = sum_r + sum_g + sum_b;
		if (total == 0)
		{
			total = 3;
			sum_r = sum_g = sum_b = 3;
		}
		
		sum_r /= total;
		sum_g /= total;
		sum_b /= total;
		
		var offset:Float = 0;
		if (stretchLevels && max - min < 255)
		{
			var f:Float = 256 / ((max - min) + 1);
			sum_r *= f;
			sum_g *= f;
			sum_b *= f;
			offset = -min;
		}
		
		var f:Float = 1 / Math.sqrt(sum_r * sum_r + sum_g * sum_g + sum_b * sum_b);
		sum_r *= f;
		sum_g *= f;
		sum_b *= f;
		
		if (!outputToBlueOnly)
		{
			concat([sum_r, sum_g, sum_b, 0, offset,
					sum_r, sum_g, sum_b, 0, offset,
					sum_r, sum_g, sum_b, 0, offset,
					0, 0, 0, 1, 0]);
		}
		else
		{
			concat([0, 0, 0, 0, 0,
					0, 0, 0, 0, 0,
					sum_r, sum_g, sum_b, 0, offset,
					0, 0, 0, 1, 0]);
		}
	}
	
	#end
	
	public function invertMatrix():Bool
	{
		var coeffs:Matrix3D = new Matrix3D(Vector.ofArray([matrix[0], matrix[1], matrix[2], matrix[3],
											matrix[5], matrix[6], matrix[7], matrix[8],
											matrix[10], matrix[11], matrix[12], matrix[13],
											matrix[15], matrix[16], matrix[17], matrix[18]]));
		/*var coeffs:Matrix3D = [matrix[0], matrix[1], matrix[2], matrix[3],
								matrix[5], matrix[6], matrix[7], matrix[8],
								matrix[10], matrix[11], matrix[12], matrix[13],
								matrix[15], matrix[16], matrix[17], matrix[18]];*/
		var check:Bool = coeffs.invert();
		if (!check) return false;
		
		matrix[0] = coeffs.rawData[0];
		matrix[1] = coeffs.rawData[1];
		matrix[2] = coeffs.rawData[2];
		matrix[3] = coeffs.rawData[3];
		var tmp1:Float = -(coeffs.rawData[0] * matrix[4] + coeffs.rawData[1] * matrix[9] + coeffs.rawData[2] * matrix[14] + coeffs.rawData[3] * matrix[15]);
		
		matrix[5] = coeffs.rawData[4]; 
		matrix[6] = coeffs.rawData[5]; 
		matrix[7] = coeffs.rawData[6]; 
		matrix[8] = coeffs.rawData[7]; 
		var tmp2:Float = -( coeffs.rawData[4] * matrix[4] + coeffs.rawData[5] * matrix[9] + coeffs.rawData[6] * matrix[14] + coeffs.rawData[7] * matrix[15] );
		
		matrix[10] = coeffs.rawData[8]; 
		matrix[11] = coeffs.rawData[9]; 
		matrix[12] = coeffs.rawData[10]; 
		matrix[13] = coeffs.rawData[11]; 
		var tmp3:Float = -( coeffs.rawData[8] * matrix[4] + coeffs.rawData[9] * matrix[9] + coeffs.rawData[10] * matrix[14] + coeffs.rawData[11] * matrix[15] );
		
		matrix[15] = coeffs.rawData[12]; 
		matrix[16] = coeffs.rawData[13]; 
		matrix[17] = coeffs.rawData[14]; 
		matrix[18] = coeffs.rawData[15]; 
		var tmp4:Float = -( coeffs.rawData[12] * matrix[4] + coeffs.rawData[13] * matrix[9] + coeffs.rawData[14] * matrix[14] + coeffs.rawData[15] * matrix[15] );
		
		matrix[4] = tmp1;
		matrix[9] = tmp2;
		matrix[14] = tmp3;
		matrix[19] = tmp4;
		
		return true;
	}
	
	public function applyMatrix(rgba:UInt):UInt
	{
		var a:Float = (rgba >>> 24) & 0xFF;
		var r:Float = (rgba >>> 16) & 0xFF;
		var g:Float = (rgba >>> 8) & 0xFF;
		var b:Float = rgba & 0xFF;
		
		var r2:Float = 0.5 + r * matrix[0] + g * matrix[1] + b * matrix[2] + a * matrix[3] + matrix[4];
		var g2:Float = 0.5 + r * matrix[5] + g * matrix[6] + b * matrix[7] + a * matrix[8] + matrix[9];
		var b2:Float = 0.5 + r * matrix[10] + g * matrix[11] + b * matrix[12] + a * matrix[13] + matrix[14];
		var a2:Float = 0.5 + r * matrix[15] + g * matrix[16] + b * matrix[17] + a * matrix[18] + matrix[19];
		
		if ( a2 < 0 ) a2 = 0;
       	if ( a2 > 255 ) a2 = 255;
       	if ( r2 < 0 ) r2 = 0;
       	if ( r2 > 255 ) r2 = 255;
       	if ( g2 < 0 ) g2 = 0;
       	if ( g2 > 255 ) g2 = 255;
       	if ( b2 < 0 ) b2 = 0;
       	if ( b2 > 255 ) b2 = 255;
		
		return Std.int(a2)<<24 | Std.int(r2)<<16 | Std.int(g2)<<8 | Std.int(b2);
	}
	
	public function transformVector(values:Array<Float>):Void
	{
		if (values.length != 4) return;
		
		var r:Float = values[0] * matrix[0] + values[1] * matrix[1] + values[2] * matrix[2] + values[3] * matrix[3] + matrix[4];
       	var g:Float = values[0] * matrix[5] + values[1] * matrix[6] + values[2] * matrix[7] + values[3] * matrix[8] + matrix[9];
       	var b:Float = values[0] * matrix[10] + values[1] * matrix[11] + values[2] * matrix[12] + values[3] * matrix[13] + matrix[14];
       	var a:Float = values[0] * matrix[15] + values[1] * matrix[16] + values[2] * matrix[17] + values[3] * matrix[18] + matrix[19];
		
		values[0] = r;
		values[1] = g;
		values[2] = b;
		values[3] = a;
	}
	
	private function initHue():Void
	{
		var greenRotation:Float = 39.182655;
		
		if (!hueInitialized)
		{
			hueInitialized = true;
			preHue = new ColorMatrix();
			preHue.rotateRed(45);
			preHue.rotateGreen( -greenRotation);
			
			var lum:Array<Float> = [LUMA_R2, LUMA_G2, LUMA_B2, 1.0];
			
			preHue.transformVector(lum);
			
			var red:Float = lum[0] / lum[2];
			var green:Float = lum[1] / lum[2];
			
			preHue.shearBlue(red, green);
			
			postHue = new ColorMatrix();
			postHue.shearBlue( -red, -green);
			postHue.rotateGreen(greenRotation);
			postHue.rotateRed( -45.0);
		}
	}
	
	private function rotateColor(degrees:Float, x:Int, y:Int):Void
	{
		degrees *= RAD;
		var mat:Array<Float> = IDENTITY.concat([]);
		mat[x + x * 5] = mat[y + y * 5] = Math.cos(degrees);
		mat[y + x * 5] = Math.sin(degrees);
		mat[x + y * 5] = -Math.sin(degrees);
		concat(mat);
	}
	
	private function shearColor(x:Int, y1:Int, d1:Float, y2:Int, d2:Float):Void
	{
		var mat:Array<Float> = IDENTITY.concat([]);
		mat[y1 + x * 5] = d1;
		mat[y2 + x * 5] = d2;
		concat(mat);
	}
	
	public function toString():String
	{
		return matrix.toString();
	}
}