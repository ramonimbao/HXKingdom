package ;

import flixel.math.FlxRandom;
import flash.display.BlendMode;
import flixel.FlxSprite;
import flixel.FlxG;

class Light extends FlxSprite
{
	private var CampfireImg:FlxSprite;
	private var TorchImg:FlxSprite;

	private var LightMidImg:FlxSprite;
	private var LightLargeImg:FlxSprite;
	private var LightReflectSmallImg:FlxSprite;
	private var LightReflectWideImg:FlxSprite;

	public var beam:FlxSprite;
	public var reflected:FlxSprite;
	public var darkness:FlxSprite;

	public var burning:Bool;

	public var playstate:PlayState;
	public var weather:Weather;
	private var random:FlxRandom = new FlxRandom();

	public function new(X:Float, Y:Float)
	{
		beam = new FlxSprite();
		reflected = new FlxSprite();
		CampfireImg = new FlxSprite();
		TorchImg = new FlxSprite();

		LightMidImg = new FlxSprite();
		LightLargeImg = new FlxSprite();
		LightReflectSmallImg = new FlxSprite();
		LightReflectWideImg = new FlxSprite();

		CampfireImg.loadGraphic("assets/gfx/campfire.png");
		TorchImg.loadGraphic("assets/gfx/torch.png");

		LightMidImg.loadGraphic("assets/gfx/light_mid.png");
		LightLargeImg.loadGraphic("assets/gfx/light_large.png");
		LightReflectSmallImg.loadGraphic("assets/gfx/light_reflect_small.png");
		LightReflectWideImg.loadGraphic("assets/gfx/light_reflect_wide.png");

		super(X, Y);
		this.playstate = cast(FlxG.state, PlayState);
		this.darkness = this.playstate.darkness;
		this.weather = this.playstate.weather;
	}

	public function setLight():Void
	{
		beam.blend = BlendMode.SCREEN;
	}

	override public function update(elapsed:Float):Void
	{
		getScreenPosition(_point);
		burning = ( -128 < _point.x && _point.x < FlxG.width + 128);
	}

	override public function draw():Void
	{
		if (burning)
		{
			getScreenPosition(_point);
			darkness.stamp(beam, Math.floor(_point.x - beam.width / 2), Math.floor(_point.y - beam.height / 2));
		}
		super.draw();
	}

	public function dim(animName:String, frameNumber:UInt, frameIndex:UInt):Void
	{
		if (burning)
		{
			beam.alpha += random.float() * 0.15 - 0.075;
			if (beam.alpha < 0.3)
			{
				beam.alpha += 0.01;
			}
			beam.drawFrame(true);
		}
	}

}
