package;

import openfl.Assets;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxMisc;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	
	private var TitleImg:FlxSprite;
	private var NoioImg:FlxSprite;
	private var PezImg:FlxSprite;
	
	override public function create():Void
	{
		TitleImg = new FlxSprite();
		NoioImg = new FlxSprite(228, 123);
		PezImg = new FlxSprite(258, 123);
		
		TitleImg.loadGraphic("assets/gfx/title.png");
		NoioImg.loadGraphic("assets/gfx/outline_noio.png");
		PezImg.loadGraphic("assets/gfx/outline_pez.png");
		
		add(TitleImg);
		add(NoioImg);
		add(PezImg);
		
		NoioImg.width = 30;
		NoioImg.visible = false;
		PezImg.visible = false;
		
		// Set a background color
		FlxG.cameras.bgColor = 0xff000000;
		// Show the mouse (in case it hasn't been disabled)
		#if !FLX_NO_MOUSE
		FlxG.mouse.show();
		#end
		
		super.create();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		
		if (FlxG.mouse.x > NoioImg.x && FlxG.mouse.x < NoioImg.x + NoioImg.width &&
			FlxG.mouse.y > NoioImg.y && FlxG.mouse.y < NoioImg.y + NoioImg.height)
		{
			NoioImg.visible = true;
			if (FlxG.mouse.justPressed)
			{
				FlxMisc.openURL("http://www.noio.nl");
			}
		}
		else
		{
			NoioImg.visible = false;
		}
		
		if (FlxG.mouse.x > PezImg.x && FlxG.mouse.x < PezImg.x + PezImg.width &&
		    FlxG.mouse.y > PezImg.y && FlxG.mouse.y < PezImg.y + PezImg.height)
		{
				PezImg.visible = true;
				if (FlxG.mouse.justPressed)
				{
					FlxMisc.openURL("http://www.soundcloud.com/pez_pez");
				}
		}
		else
		{
			PezImg.visible = false;
		}
		
		if (!NoioImg.visible && !PezImg.visible && FlxG.mouse.justPressed)
		{
			FlxG.mouse.useSystemCursor = false;
			FlxG.switchState(new PlayState());
		}
	}	
}