package ;

/**
 * ...
 * @author 
 */
class WPNode
{
	public var saturation:Float;	//0
	public var darkness:Float;	 	//1
	public var sky:UInt;			//2
	public var haze:UInt;			//3
	public var sunTint:UInt;		//4
	public var fog:Float;			//5
	public var contrast:Float;		//6
	public var horizon:UInt;		//7
	public var ambient:UInt;		//8
	public var timeOfDay:Float;		//9
	public var wind:Float;			//10
	public var darknessColor:UInt;	//11
	
	public var arr:Array<Dynamic>;
	
	public function new(saturation_:Float, darkness_:Float, sky_:UInt, haze_:UInt, sunTint_:UInt, fog_:Float, contrast_:Float, horizon_:UInt, ambient_:UInt, timeOfDay_:Float, wind_:Float, darknessColor_:UInt) {
		saturation = saturation_;
		darkness = darkness_;
		sky = sky_;
		haze = haze_;
		sunTint = sunTint_;
		fog = fog_;
		horizon = horizon_;
		ambient = ambient_;
		timeOfDay = timeOfDay_;
		contrast = contrast_;
		wind = wind_;
		darknessColor = darknessColor_;
		
		arr.push(saturation); 		// 0
		arr.push(darkness);			// 1
		arr.push(sky);				// 2
		arr.push(haze);				// 3
		arr.push(sunTint);			// 4
		arr.push(fog);				// 5
		arr.push(contrast);			// 6
		arr.push(horizon);			// 7
		arr.push(ambient);			// 8
		arr.push(timeOfDay);		// 9
		arr.push(wind);				// 10
		arr.push(darknessColor);	// 11
	}
}