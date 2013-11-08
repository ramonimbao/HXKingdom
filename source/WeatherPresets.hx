/*package;

class WeatherPresets {
	
	public static var NIGHTGREEN:Dynamic = {
		'saturation': 0.7,
		'darkness': 0.45,
		'sky': 0xFF005EA5,
		'haze': 0xFFB8F2BB,
		'sunTint': 0xDDDDFF,
		'fog': 0.4,
		'contrast': 0.0,
		'horizon': 0xFF002E80,
		'ambient': 0x2254FFAF,
		'timeOfDay': 0.85,
		'wind': 0.1,
		'darknessColor': 0x88263529
	}
	public static var NIGHTFOGGY:Dynamic = {
		'saturation': 0.7,
		'darkness': 0.7,
		'sky': 0xFF25229d,
		'haze': 0xFFd5d9ff,
		'sunTint': 0xffd9c8,
		'fog': 1.0,
		'contrast': -0.1,
		'horizon': 0xFF6a6d55,
		'ambient': 0x7763709d,
		'timeOfDay': 0.8,
		'wind': 0.2,
		'darknessColor': 0x88111114
	}
	public static var NIGHTLONG:Dynamic = {
		'saturation': 1.0,
		'darkness': 0.4,
		'sky': 0xFF7399c8,
		'sunTint': 0x162039,
		'haze': 0xFF000000,
		'fog': 0.0,
		'wind': 0.1,
		'horizon': 0xFF7399c8,
		'ambient': 0x55acc857,
		'timeOfDay': 0.9,
		'contrast': 0.3,
		'darknessColor': 0x88000000
	}
	public static var DAYCLEARCOLD:Dynamic = {
		'saturation': 0.7,
		'darkness': 0.0,
		'sky': 0xFFC9E3EA,
		'haze': 0x33C9E3EA,
		'sunTint': 0xF7E9AA,
		'fog': 0.0,
		'contrast': 0.2,
		'horizon': 0xFFC9E3EA,
		'ambient': 0x33F7E0C3,
		'timeOfDay': 0.45,
		'wind': 0.5,
		'darknessColor': 0x88111114
	}
	public static var DAWNBLEAK:Dynamic = {
		'saturation': 0.9,
		'darkness': 0.2,
		'sky': 0xFFC4AD99,
		'haze': 0xAAf3f1e8,
		'sunTint': 0xF9B340,
		'fog': 0.5,
		'contrast': 0.5,
		'horizon': 0xFFCECECE,
		'ambient': 0x22FF84DA,
		'timeOfDay': 0.31,
		'wind': 0.1,
		'darknessColor': 0x88111114
	}
	public static var DAYORANGESKY:Dynamic = {
		'saturation': 0.7,
		'darkness': 0.1,
		'sky': 0xFFADA290,
		'haze': 0x445A432C,
		'sunTint': 0xF9F8E6,
		'fog': 0.3,
		'contrast': 0.2,
		'horizon': 0xFFDCAB4F,
		'ambient': 0x110E0B22,
		'timeOfDay': 0.4,
		'wind': 0.7,
		'darknessColor': 0x880E0B62
	}
	public static var DAYPASTEL:Dynamic = {
		'saturation': 1.0,
		'darkness': 0.0,
		'sky': 0xFF3090F6,
		'sunTint': 0xF9F8E6,
		'haze': 0xDD657A8F,
		'fog': 0.0,
		'wind': 0.3,
		'horizon': 0xFFEEEE88,
		'ambient': 0x44886A00,
		'timeOfDay': 0.55,
		'contrast': 1.0,
		'darknessColor': 0x88000BBB
	}
	public static var DUSKPINK:Dynamic = {
		'saturation': 0.9,
		'darkness': 0.0,
		'sky': 0xFF8C8CA6,
		'haze': 0xAAf3c1e8,
		'sunTint': 0xF9B340,
		'fog': 0.0,
		'contrast': 0.8,
		'horizon': 0xFFEDC99A,
		'ambient': 0x44F79A42,
		'timeOfDay': 0.651,
		'wind': 0.1,
		'darknessColor': 0x88111114
	}
	public static var DAWNCLEARORANGE:Dynamic = {
		'saturation': 0.8,
		'darkness': 0.2,
		'sky': 0xFF97A7B4,
		'haze': 0x88FDB24C,
		'sunTint': 0xFAFDC9,
		'fog': 0.0,
		'contrast': 0.5,
		'horizon': 0xFFF9A04F,
		'ambient': 0x11FF0000,
		'timeOfDay': 0.28,
		'wind': 0.1,
		'darknessColor': 0x88111114
	}
	public static var EVENINGORANGE:Dynamic = {
		'saturation': 0.8,
		'darkness': 0.1,
		'sky': 0xFF8BB8E8,
		'haze': 0xFFFF9068,
		'sunTint': 0xFFFF7038,
		'fog': 0.0,
		'contrast': 0.7,
		'horizon': 0xFFEDC99A,
		'ambient': 0x33DE5E37,
		'timeOfDay': 0.70,
		'wind': 0.1,
		'darknessColor': 0x88111114
	}
	public static var NIGHTSHINE:Dynamic = {
		'saturation': 0.5,
		'darkness': 0.35,
		'sky': 0xFF000000,
		'sunTint': 0xF9F8E6,
		'haze': 0x00886AAA,
		'fog': 0.0,
		'wind': 0.2,
		'horizon': 0xFFAAAAFF,
		'ambient': 0x00000000,
		'timeOfDay': 0.9,
		'contrast': 4.0,
		'darknessColor': 0x88222255
	}
	public static var EVENINGFOGGY:Dynamic = {
		'saturation': 0.7,
		'darkness': 0.3,
		'sky': 0xFFd56c47,
		'haze': 0xFFd5d9ff,
		'sunTint': 0xffd9c8,
		'fog': 1.0,
		'contrast': -0.1,
		'horizon': 0xFF6a6d55,
		'ambient': 0x440000FF,
		'timeOfDay': 0.7,
		'wind': 0.2,
		'darknessColor': 0x88111114
	}
	public static var NIGHTPURPLE:Dynamic = {
		'saturation': 0.8,
		'darkness': 0.3,
		'sky': 0xFF57577D,
		'sunTint': 0xF9F8E6,
		'haze': 0x88886AAA,
		'fog': 0.0,
		'wind': 0.2,
		'horizon': 0xFF4D4658,
		'ambient': 0x33886AAA,
		'timeOfDay': 0.9,
		'contrast': 1.4,
		'darknessColor': 0x88990BBB
	}
	public static var EVENINGBLACK:Dynamic = {
		'saturation': 0.7,
		'darkness': 0.3,
		'sky': 0xFF333333,
		'haze': 0xFFFF9090,
		'sunTint': 0xFFFF7038,
		'fog': 0.0,
		'contrast': 0.0,
		'horizon': 0xFFEDC99A,
		'ambient': 0x339f6b5c,
		'timeOfDay': 0.70,
		'wind': 0.1,
		'darknessColor': 0x88111114
	}
	public static var EVENINGMONOTONE:Dynamic = {
		'saturation': 0.7,
		'darkness': 0.3,
		'sky': 0xFF333333,
		'haze': 0xFFFF9090,
		'sunTint': 0xAAAAAA,
		'fog': 0.0,
		'contrast': 0.0,
		'horizon': 0xFFEDEDED,
		'ambient': 0x33666666,
		'timeOfDay': 0.70,
		'wind': 0.1,
		'darknessColor': 0x88111114
	}
	public static var NIGHTCLEAR:Dynamic = {
		'saturation': 0.8,
		'darkness': 0.4,
		'sky': 0xFF005EA5,
		'haze': 0x44434e87,
		'sunTint': 0xDDDDFF,
		'fog': 0.1,
		'contrast': -0.1,
		'horizon': 0xFF002E80,
		'ambient': 0x110000FF,
		'timeOfDay': 0.1,
		'wind': 0.3,
		'darknessColor': 0x88111114
	}
	public static var SUNNY:Dynamic = {
		'saturation': 0.8,
		'darkness': 0.0,
		'sky': 0xFF98BEEC,
		'haze': 0xCCf3f1e8,
		'sunTint': 0xfff766,
		'fog': 0.0,
		'contrast': 0.8,
		'horizon': 0xFFC4DAF1,
		'ambient': 0x44FFBB7F,
		'timeOfDay': 0.6,
		'wind': 1.0,
		'darknessColor': 0x88111114
	}
	public static var DAYBLEAK:Dynamic = {
		'saturation': 0.7,
		'darkness': 0.0,
		'sky': 0xFFA0C2E8,
		'haze': 0xFFf3f1e8,
		'sunTint': 0xF7E9AA,
		'fog': 1.0,
		'contrast': 0.0,
		'horizon': 0xFFA6C9ED,
		'ambient': 0x33F7E0C3,
		'timeOfDay': 0.45,
		'wind': 0.5,
		'darknessColor': 0x88111114
	}
	public static var NIGHTREDMOON:Dynamic = {
		'saturation': 0.9,
		'darkness': 0.4,
		'sky': 0xFF142744,
		'haze': 0x665C5D9E,
		'sunTint': 0xC73800,
		'fog': 0.1,
		'contrast': 0.2,
		'horizon': 0xFFAD2E21,
		'ambient': 0x220E0B62,
		'timeOfDay': 0.1,
		'wind': 0.1,
		'darknessColor': 0x880E0B62
	}
	public static var DAYTEMP:Dynamic = {
		'saturation': 0.0,
		'darkness': 0.2,
		'sky': 0xFF6a6d55,
		'haze': 0xFF999d7c,
		'sunTint': 0xffffff,
		'fog': 1.0,
		'contrast': -0.2,
		'horizon': 0xFF6a6d55,
		'ambient': 0xFFFF0000,
		'timeOfDay': 0.5,
		'wind': 0.2,
		'darknessColor': 0x88111114
	}
	public static var FOGGY:Dynamic = {
		'saturation': 0.7,
		'darkness': 0.2,
		'sky': 0xFF6a6d55,
		'haze': 0xFF999d7c,
		'sunTint': 0xffffff,
		'fog': 1.0,
		'contrast': -0.2,
		'horizon': 0xFF6a6d55,
		'ambient': 0x330000FF,
		'timeOfDay': 0.25,
		'wind': 0.2,
		'darknessColor': 0x88111114
	}
	public static var DAWNBROWN:Dynamic = {
		'saturation': 0.8,
		'darkness': 0.0,
		'sky': 0xFFC0AFBD,
		'sunTint': 0xF9F8E6,
		'haze': 0x99AAAAAA,
		'fog': 0.2,
		'wind': 0.2,
		'horizon': 0xFF94A9B6,
		'ambient': 0x55AD3200,
		'timeOfDay': 0.28,
		'contrast': 0.7,
		'darknessColor': 0x88222255
	}
	public static var DUSKFOGGY:Dynamic = {
		'saturation': 0.6,
		'darkness': 0.25,
		'sky': 0xFFB29C8F,
		'sunTint': 0xF9F8E6,
		'haze': 0x00000000,
		'fog': 0.8,
		'wind': 0.4,
		'horizon': 0xFF3D6BCD,
		'ambient': 0x330E0B22,
		'timeOfDay': 0.75,
		'contrast': 0.1,
		'darknessColor': 0x880E0B62
	}
	public static var DAWNLIGHTPINK:Dynamic = {
		'saturation': 0.8,
		'darkness': 0.1,
		'sky': 0xFF8C8CA6,
		'haze': 0xAAf3f1e8,
		'sunTint': 0xF9B340,
		'fog': 0.5,
		'contrast': 0.5,
		'horizon': 0xFFCF7968,
		'ambient': 0x22FF84DA,
		'timeOfDay': 0.28,
		'wind': 0.1,
		'darknessColor': 0x88111114
	}
	public static var NIGHTDARK:Dynamic = {
		'saturation': 0.7,
		'darkness': 0.75,
		'sky': 0xFF002E33,
		'haze': 0xFF555555,
		'sunTint': 0x65a2cb,
		'fog': 0.0,
		'contrast': 0.4,
		'horizon': 0xFF002E80,
		'ambient': 0x4454AACF,
		'timeOfDay': 0.85,
		'wind': 0.1,
		'darknessColor': 0xFF263529
	}
	public static var DUSKWARM:Dynamic = {
		'saturation': 0.9,
		'darkness': 0.0,
		'sky': 0xFF8BB8E8,
		'haze': 0x88f3f1e8,
		'sunTint': 0xF4EED0,
		'fog': 0.0,
		'contrast': 0.8,
		'horizon': 0xFFEDC99A,
		'ambient': 0x44F79A42,
		'timeOfDay': 0.651,
		'wind': 0.1,
		'darknessColor': 0x88111114
	}
	public static var DAWNEARLY:Dynamic = {
		'saturation': 0.9,
		'darkness': 0.2,
		'sky': 0xFFC4AD99,
		'haze': 0xAAf3f1e8,
		'sunTint': 0xF9B340,
		'fog': 0.5,
		'contrast': 0.5,
		'horizon': 0xFFCECECE,
		'ambient': 0x22FF84DA,
		'timeOfDay': 0.19,
		'wind': 0.1,
		'darknessColor': 0x88111114
	}
	public static var DAWNBRIGHT:Dynamic = {
		'saturation': 0.8,
		'darkness': 0.15,
		'sky': 0xFF57577D,
		'sunTint': 0xF9F8E6,
		'haze': 0x00886AAA,
		'fog': 0.0,
		'wind': 0.2,
		'horizon': 0xFFEEEE88,
		'ambient': 0xff886A00,
		'timeOfDay': 0.3,
		'contrast': 1.4,
		'darknessColor': 0x88000BBB
	}
	public static var DAWNGREY:Dynamic = {
		'saturation': 0.5,
		'darkness': 0.2,
		'sky': 0xFFC4AD99,
		'haze': 0xAAf3f1e8,
		'sunTint': 0xF9B340,
		'fog': 0.5,
		'contrast': 0.5,
		'horizon': 0xFFCECECE,
		'ambient': 0x22FF84DA,
		'timeOfDay': 0.31,
		'wind': 0.1,
		'darknessColor': 0x88111114
	}
	public static var NIGHTSUPERDARK:Dynamic = {
		'saturation': 0.7,
		'darkness': 0.7,
		'sky': 0xFF000000,
		'haze': 0xFFFFFFFF,
		'sunTint': 0x65a2cb,
		'fog': 0.0,
		'contrast': 0.4,
		'horizon': 0xFF002E80,
		'ambient': 0x4454AACF,
		'timeOfDay': 0.85,
		'wind': 0.1,
		'darknessColor': 0xFF263529
	}
	public static var DUSKCLEAR:Dynamic = {
		'saturation': 0.9,
		'darkness': 0.2,
		'sky': 0xFF513744,
		'haze': 0xAAC9976D,
		'sunTint': 0xF9B340,
		'fog': 0.0,
		'contrast': 0.45,
		'horizon': 0xFFC69875,
		'ambient': 0x22360A00,
		'timeOfDay': 0.651,
		'wind': 0.1,
		'darknessColor': 0x88111114
	}
	public static var NIGHT:Dynamic = {
		'saturation': 0.8,
		'darkness': 0.4,
		'sky': 0xFF005EA5,
		'haze': 0xFF333333,
		'sunTint': 0xDDDDFF,
		'fog': 0.2,
		'contrast': 0.5,
		'horizon': 0xFF002E80,
		'ambient': 0x110000FF,
		'timeOfDay': 0,
		'wind': 0.2,
		'darknessColor': 0x88111114
	}
	public static var DAWNTEMP:Dynamic = {
		'saturation': 0.0,
		'darkness': 0.2,
		'sky': 0xFF6a6d55,
		'haze': 0xFF999d7c,
		'sunTint': 0xffffff,
		'fog': 1.0,
		'contrast': -0.2,
		'horizon': 0xFF6a6d55,
		'ambient': 0xFFFF0000,
		'timeOfDay': 0.25,
		'wind': 0.2,
		'darknessColor': 0x88111114
	}
	public static var DAYWINDYCLEAR:Dynamic = {
		'saturation': 1.0,
		'darkness': 0.0,
		'sky': 0xFF64A3EA,
		'haze': 0x22f3f1e8,
		'sunTint': 0xF7E9AA,
		'fog': 0.0,
		'contrast': 1.0,
		'horizon': 0xFF86BAEF,
		'ambient': 0x33F99100,
		'timeOfDay': 0.45,
		'wind': 0.5,
		'darknessColor': 0x88111114
	}
	public static var DAWN:Dynamic = {
		'saturation': 0.8,
		'darkness': 0.2,
		'sky': 0xFF8C8CA6,
		'haze': 0x66f3f1e8,
		'sunTint': 0xff6d40,
		'fog': 0.0,
		'contrast': 0.5,
		'horizon': 0xFFCF7968,
		'ambient': 0x11FF0000,
		'timeOfDay': 0.28,
		'wind': 0.1,
		'darknessColor': 0x88111114
	}
	public static var DAYSOFT:Dynamic = {
		'saturation': 0.7,
		'darkness': 0.0,
		'sky': 0xFFA0C2E8,
		'haze': 0x22f3f1e8,
		'sunTint': 0xF7E9AA,
		'fog': 0.0,
		'contrast': 0.0,
		'horizon': 0xFFA6C9ED,
		'ambient': 0x33F7E0C3,
		'timeOfDay': 0.45,
		'wind': 0.1,
		'darknessColor': 0x88111114
	}
	public static var EVENING:Dynamic = {
		'saturation': 0.8,
		'darkness': 0.1,
		'sky': 0xFFFF7F51,
		'haze': 0x99FF9068,
		'sunTint': 0xFFFF7038,
		'fog': 0.0,
		'contrast': 0.7,
		'horizon': 0xFFFFDF54,
		'ambient': 0x33DE5E37,
		'timeOfDay': 0.70,
		'wind': 0.1,
		'darknessColor': 0x88111114
	}
	public static var DAYMONOCHROME:Dynamic = {
		'saturation': 0.25,
		'darkness': 0.0,
		'sky': 0xFF80A2C8,
		'haze': 0xFFf3f1e8,
		'sunTint': 0xF7E9AA,
		'fog': 1.0,
		'contrast': 0.4,
		'horizon': 0xFFA6C9ED,
		'ambient': 0x33F7E0C3,
		'timeOfDay': 0.45,
		'wind': 0.5,
		'darknessColor': 0x88111114
	}
	public static var DAWNREDMOON:Dynamic = {
		'saturation': 0.9,
		'darkness': 0.2,
		'sky': 0xFF16549F,
		'haze': 0xbb5C5D9E,
		'sunTint': 0xE76833,
		'fog': 0.1,
		'contrast': 0.0,
		'horizon': 0xFFFF9286,
		'ambient': 0x110E0B22,
		'timeOfDay': 0.2,
		'wind': 0.1,
		'darknessColor': 0x880E0B62
	}
	public static var DUSKTAN:Dynamic = {
		'saturation': 0.8,
		'darkness': 0.1,
		'sky': 0xFF52424C,
		'sunTint': 0xF9F8E6,
		'haze': 0x55C18F90,
		'fog': 0.0,
		'wind': 0.3,
		'horizon': 0xFFFFBA3B,
		'ambient': 0xFF886A00,
		'timeOfDay': 0.7,
		'contrast': 0.5,
		'darknessColor': 0x88330B33
	}
	public static var DUSKTEMP:Dynamic = {
		'saturation': 0.0,
		'darkness': 0.2,
		'sky': 0xFF6a6d55,
		'haze': 0xFF999d7c,
		'sunTint': 0xffffff,
		'fog': 1.0,
		'contrast': -0.2,
		'horizon': 0xFF6a6d55,
		'ambient': 0xFFFF0000,
		'timeOfDay': 0.75,
		'wind': 0.2,
		'darknessColor': 0x88111114
	}
	public static var DUSKYELLOW:Dynamic = {
		'saturation': 0.9,
		'darkness': 0.0,
		'sky': 0xFF8BB8E8,
		'haze': 0x88f3f1e8,
		'sunTint': 0xF4EED0,
		'fog': 0.0,
		'contrast': 0.8,
		'horizon': 0xFFEDC99A,
		'ambient': 0x44F79A42,
		'timeOfDay': 0.651,
		'wind': 0.1,
		'darknessColor': 0x88111114
	}
	public static var NIGHTTEMP:Dynamic = {
		'saturation': 0.0,
		'darkness': 0.2,
		'sky': 0xFF6a6d55,
		'haze': 0xFF999d7c,
		'sunTint': 0xffffff,
		'fog': 1.0,
		'contrast': -0.2,
		'horizon': 0xFF6a6d55,
		'ambient': 0xFFFF0000,
		'timeOfDay': 0.0,
		'wind': 0.2,
		'darknessColor': 0x88111114
	}
	public static var DAYDUSTY:Dynamic = {
		'saturation': 0.8,
		'darkness': 0.0,
		'sky': 0xFF5d9df5,
		'sunTint': 0xF9F8E6,
		'haze': 0x99AAAAAA,
		'fog': 0.2,
		'wind': 0.2,
		'horizon': 0xFF94A9B6,
		'ambient': 0x55f5db04,
		'timeOfDay': 0.4,
		'contrast': 0.2,
		'darknessColor': 0x88222255
	}
	public static var DUSKRED:Dynamic = {
		'saturation': 0.8,
		'darkness': 0.2,
		'sky': 0xFFd06219,
		'sunTint': 0xf27612,
		'haze': 0x99AAAAAA,
		'fog': 0.2,
		'wind': 0.2,
		'horizon': 0xFFf2d407,
		'ambient': 0x55f5db04,
		'timeOfDay': 0.651,
		'contrast': 0.1,
		'darknessColor': 0x88000000
	}
}*/

package;

class WeatherPresets
{
	public var NIGHTGREEN:WPNode;
	public var NIGHTFOGGY:WPNode;
	public var NIGHTLONG:WPNode;
	public var DAYCLEARCOLD:WPNode;
	public var DAWNBLEAK:WPNode;
	public var DAYORANGESKY:WPNode;
	public var DAYPASTEL:WPNode;
	public var DUSKPINK:WPNode;
	public var DAWNCLEARORANGE:WPNode;
	public var EVENINGORANGE:WPNode;
	public var NIGHTSHINE:WPNode;
	public var EVENINGFOGGY:WPNode;
	public var NIGHTPURPLE:WPNode;
	public var EVENINGBLACK:WPNode;
	public var EVENINGMONOTONE:WPNode;
	public var NIGHTCLEAR:WPNode;
	public var SUNNY:WPNode;
	public var DAYBLEAK:WPNode;
	public var NIGHTREDMOON:WPNode;
	public var DAYTEMP:WPNode;
	public var FOGGY:WPNode;
	public var DAWNBROWN:WPNode;
	public var DUSKFOGGY:WPNode;
	public var DAWNLIGHTPINK:WPNode;
	public var NIGHTDARK:WPNode;
	public var DUSKWARM:WPNode;
	public var DAWNEARLY:WPNode;
	public var DAWNBRIGHT:WPNode;
	public var DAWNGREY:WPNode;
	public var NIGHTSUPERDARK:WPNode;
	public var DUSKCLEAR:WPNode;
	public var NIGHT:WPNode;
	public var DAWNTEMP:WPNode;
	public var DAYWINDYCLEAR:WPNode;
	public var DAWN:WPNode;
	public var DAYSOFT:WPNode;
	public var EVENING:WPNode;
	public var DAYMONOCHROME:WPNode;
	public var DAWNREDMOON:WPNode;
	public var DUSKTAN:WPNode;
	public var DUSKTEMP:WPNode;
	public var DUSKYELLOW:WPNode;
	public var NIGHTTEMP:WPNode;
	public var DAYDUSTY:WPNode;
	public var DUSKRED:WPNode;
	
	public function new()
	{
		NIGHTGREEN = new WPNode(0.7, 0.45, 0xFF005EA5, 0xFFB8F2BB, 0xDDDDFF, 0.4, 0.0, 0xFF002E80, 0x2254FFAF, 0.85, 0.1, 0x88263529);
		NIGHTFOGGY = new WPNode(0.7, 0.7, 0xFF25229D, 0xFFD5D9FF, 0xFF9DC8, 1.0, -0.1, 0xFF6A6D55, 0x7763709D, 0.8, 0.2, 0x88111114);
		NIGHTLONG = new WPNode(1.0, 0.4, 0xFF7399C8, 0xFF000000, 0x162039, 0.0, 0.3, 0xFF7399C8, 0x55ACC857, 0.9, 0.1, 0x88000000);
		DAYCLEARCOLD = new WPNode(0.7, 0.0, 0xFFC9E3EA, 0x33C9E3EA, 0xF7E9AA, 0.0, 0.2, 0xFFC9E3EA, 0x33F7E0C3, 0.45, 0.5, 0x88111114);
		DAWNBLEAK = new WPNode(0.9, 0.2, 0xFFC4AD99, 0xAAF3F1E8, 0xF9B340, 0.5, 0.5, 0xFFCECECE, 0x22FF84DA, 0.31, 0.1, 0x88111114);
		DAYORANGESKY = new WPNode(0.7, 0.1, 0xFFDA290, 0x445A432C, 0xF9F8E6, 0.3, 0.2, 0xFFDCAB4F, 0x110E0B22, 0.4, 0.7, 0x880E0B62);
		DAYPASTEL = new WPNode(1.0, 0.0, 0xFF3090F6, 0xDD657A8F, 0xF9F8E6, 0.0, 1.0, 0xFFEEEE88, 0x44886A00, 0.55, 0.3, 0x88000BBB);
		DUSKPINK = new WPNode(0.9, 0.0, 0xFF8C8CA6, 0xAAF3C1E8, 0xF9B340, 0.0, 0.8, 0xFFEDC99A, 0x44F79A42, 0.651, 0.1, 0x88111114);
		DAWNCLEARORANGE = new WPNode(0.8, 0.2, 0xFF97A7B4, 0x88FDB24C, 0xFAFDC9, 0.0, 0.5, 0xFFF9A04F, 0x11FF0000, 0.28, 0.1, 0x88111114);
		EVENINGORANGE = new WPNode(0.8, 0.1, 0xFF8BB8E8, 0xFFFF9068, 0xFFFF7038, 0.0, 0.7, 0xFFEDC99A, 0x33DE5E37, 0.70, 0.1, 0x88111114);
		NIGHTSHINE = new WPNode(0.5, 0.35, 0xFF000000, 0x00886AAA, 0xF9F8E6, 0.0, 4.0, 0xFFAAAAFF, 0x00000000, 0.9, 0.2, 0x88222255);
		EVENINGFOGGY = new WPNode(0.7, 0.3, 0xFFD56C47, 0xFFD5D9FF, 0xFFD9C8, 1.0, -0.1, 0xFF6A6D55, 0x440000FF, 0.7, 0.2, 0x88111114);
		NIGHTPURPLE = new WPNode(0.8, 0.3, 0xFF57577D, 0x88886AAA, 0xF9F8E6, 0.0, 1.4, 0xFF4D4658, 0x33886AAA, 0.9, 0.2, 0x88990BBB);
		EVENINGBLACK = new WPNode(0.7, 0.3, 0xFF333333, 0xFFFF9090, 0xFFFF7038, 0.0, 0.0, 0xFFEDC99A, 0x339F6B5C, 0.70, 0.1, 0x88111114);
		EVENINGMONOTONE = new WPNode(0.7, 0.3, 0xFF333333, 0xFFFF9090, 0xAAAAAA, 0.0, 0.0, 0xFFEDEDED, 0x33666666, 0.70, 0.1, 0x88111114);
		NIGHTCLEAR = new WPNode(0.8, 0.4, 0xFF005EA5, 0x44434E87, 0xDDDDFF, 0.1, -0.1, 0xFF002E80, 0x110000FF, 0.1, 0.3, 0x88111114);
		SUNNY = new WPNode(0.8, 0.0, 0xFF98BEEC, 0xCCF3F1E8, 0xFFF766, 0.0, 0.8, 0xFFC4DAF1, 0x44FFBB7F, 0.6, 1.0, 0x88111114);
		DAYBLEAK = new WPNode(0.7, 0.0, 0xFFA0C2E8, 0xFFF3F1E8, 0xF7E9AA, 1.0, 0.0, 0xFFA6C9ED, 0x33F7E0C3, 0.45, 0.5, 0x88111114);
		NIGHTREDMOON = new WPNode(0.9, 0.4, 0xFF142744, 0x665C5D9E, 0xC73800, 0.1, 0.2, 0xFFAD2E21, 0x220E0B62, 0.1, 0.1, 0x880E0B62);
		DAYTEMP = new WPNode(0.0, 0.2, 0xFF6a6d55, 0xFF999d7c, 0xffffff, 1.0, -0.2, 0xFF6a6d55, 0xFFFF0000, 0.5, 0.2, 0x88111114);
		FOGGY = new WPNode(0.7, 0.2, 0xFF6a6d55, 0xFF999d7c, 0xffffff, 1.0, -0.2, 0xFF6a6d55, 0x330000FF, 0.25, 0.2, 0x88111114);
		DAWNBROWN = new WPNode(0.8, 0.0, 0xFFC0AFBD, 0xF9F8E6, 0x99AAAAAA, 0.2, 0.7, 0xFF94A9B6, 0x55AD3200, 0.28, 0.2, 0x88222255);
		DUSKFOGGY = new WPNode(0.6, 0.25, 0xFFB29C8F, 0xF9F8E6, 0x00000000, 0.8, 0.1, 0xFF3D6BCD, 0x330E0B22, 0.75, 0.4, 0x880E0B62);
		DAWNLIGHTPINK = new WPNode(0.8, 0.1, 0xFF8C8CA6, 0xAAf3f1e8, 0xF9B340, 0.5, 0.5, 0xFFCF7968, 0x22FF84DA, 0.28, 0.1, 0x88111114);
		NIGHTDARK = new WPNode(0.7, 0.75, 0xFF002E33, 0xFF555555, 0x65a2cb, 0.0, 0.4, 0xFF002E80, 0x4454AACF, 0.85, 0.1, 0xFF263529);
		DUSKWARM = new WPNode(0.9, 0.0, 0xFF8BB8E8, 0x88f3f1e8, 0xF4EED0, 0.0, 0.8, 0xFFEDC99A, 0x44F79A42, 0.651, 0.1, 0x88111114);
		DAWNEARLY = new WPNode(0.9, 0.2, 0xFFC4AD99, 0xAAf3f1e8, 0xF9B340, 0.5, 0.5, 0xFFCECECE, 0x22FF84DA, 0.19, 0.1, 0x88111114);
		DAWNBRIGHT = new WPNode(0.8, 0.15, 0xFF57577D, 0xF9F8E6, 0x00886AAA, 0.0, 1.4, 0xFFEEEE88, 0xff886A00, 0.3, 0.2, 0x88000BBB);
		DAWNGREY = new WPNode(0.5, 0.2, 0xFFC4AD99, 0xAAf3f1e8, 0xF9B340, 0.5, 0.5, 0xFFCECECE, 0x22FF84DA, 0.31, 0.1, 0x88111114);
		NIGHTSUPERDARK = new WPNode(0.7, 0.7, 0xFF000000, 0xFFFFFFFF, 0x65a2cb, 0.0, 0.4, 0xFF002E80, 0x4454AACF, 0.85, 0.1, 0xFF263529);
		DUSKCLEAR = new WPNode(0.9, 0.2, 0xFF513744, 0xAAC9976D, 0xF9B340, 0.0, 0.45, 0xFFC69875, 0x22360A00, 0.651, 0.1, 0x88111114);
		NIGHT = new WPNode(0.8, 0.4, 0xFF005EA5, 0xFF333333, 0xDDDDFF, 0.2, 0.5, 0xFF002E80, 0x110000FF, 0, 0.2, 0x88111114);
		DAWNTEMP = new WPNode(0.0, 0.2, 0xFF6a6d55, 0xFF999d7c, 0xffffff, 1.0, -0.2, 0xFF6a6d55, 0xFFFF0000, 0.25, 0.2, 0x88111114);
		DAYWINDYCLEAR = new WPNode(1.0, 0.0, 0xFF64A3EA, 0x22f3f1e8, 0xF7E9AA, 0.0, 1.0, 0xFF86BAEF, 0x33F99100, 0.45, 0.5, 0x88111114);
		DAWN = new WPNode(0.8, 0.2, 0xFF8C8CA6, 0x66f3f1e8, 0xff6d40, 0.0, 0.5, 0xFFCF7968, 0x11FF0000, 0.28, 0.1, 0x88111114);
		DAYSOFT = new WPNode(0.7, 0.0, 0xFFA0C2E8, 0x22f3f1e8, 0xF7E9AA, 0.0, 0.0, 0xFFA6C9ED, 0x33F7E0C3, 0.45, 0.1, 0x88111114);
		EVENING = new WPNode(0.8, 0.1, 0xFFFF7F51, 0x99FF9068, 0xFFFF7038, 0.0, 0.7, 0xFFFFDF54, 0x33DE5E37, 0.70, 0.1, 0x88111114);
		DAYMONOCHROME = new WPNode(0.25, 0.0, 0xFF80A2C8, 0xFFf3f1e8, 0xF7E9AA, 1.0, 0.4, 0xFFA6C9ED, 0x33F7E0C3, 0.45, 0.5, 0x88111114);
		DAWNREDMOON = new WPNode(0.9, 0.2, 0xFF16549F, 0xbb5C5D9E, 0xE76833, 0.1, 0.0, 0xFFFF9286, 0x110E0B22, 0.2, 0.1, 0x880E0B62);
		DUSKTAN = new WPNode(0.8, 0.1, 0xFF52424C, 0x55C18F90, 0xF9F8E6, 0.0, 0.3, 0xFFFFBA3B, 0xFF886A00, 0.7, 0.5, 0x88330B33);
		DUSKTEMP = new WPNode(0.0, 0.2, 0xFF6a6d55, 0xFF999d7c, 0xffffff, 1.0, -0.2, 0xFF6a6d55, 0xFFFF0000, 0.75, 0.2, 0x88111114);
		DUSKYELLOW = new WPNode(0.9, 0.0, 0xFF8BB8E8, 0x88f3f1e8, 0xF4EED0, 0.0, 0.8, 0xFFEDC99A, 0x44F79A42, 0.651, 0.1, 0x88111114);
		NIGHTTEMP = new WPNode(0.0, 0.2, 0xFF6a6d55, 0xFF999d7c, 0xffffff, 1.0, -0.2, 0xFF6a6d55, 0xFFFF0000, 0.0, 0.2, 0x88111114);
		DAYDUSTY = new WPNode(0.8, 0.0, 0xFF5d9df5, 0x99AAAAAA, 0xF9F8E6, 0.2, 0.2, 0xFF94A9B6, 0x55f5db04, 0.4, 0.2, 0x88222255);
		DUSKRED = new WPNode(0.8, 0.2, 0xFFd06219, 0x99AAAAAA, 0xf27612, 0.2, 0.1, 0xFFf2d407, 0x55f5db04, 0.651, 0.2, 0x88000000);
		
	}
}