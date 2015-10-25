package ;

import flixel.FlxObject;
import flixel.util.FlxRandom;
import flash.display.StageDisplayState;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tile.FlxTilemap;
import flixel.text.FlxText;
import flixel.text.FlxTextField;
import flixel.system.FlxSound;
import flixel.FlxCamera;

import flash.geom.*;
import flash.events.Event;
import flash.filters.BlurFilter;
import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxRect;
import flash.geom.Rectangle;

import openfl.Assets;

import mochi.haxe.MochiDigits;

import flash.display.BlendMode;

class PlayState extends FlxState
{
	// DISPLAY GROUPS
	public var sky:Sky;
	public var sunmoon:SunMoon;
	public var backdropFar:FlxBackdrop;
	public var backdropClose:FlxBackdrop;
	public var backdrop:FlxGroup;
	public var haze:Haze;

	public var player:FlxSprite;
	public var bunnies:FlxGroup = new FlxGroup();
	public var farmland:FlxGroup = new FlxGroup();
	public var coins:FlxGroup = new FlxGroup();
	public var beggars:FlxGroup = new FlxGroup();
	public var characters:FlxGroup = new FlxGroup();
	public var trolls:FlxGroup = new FlxGroup();
	public var trollsNoCollide:FlxGroup = new FlxGroup();
	public var gibs:FlxGroup = new FlxGroup();
	public var indicators:FlxGroup = new FlxGroup();

	public var walls:FlxGroup;
	public var level:FlxGroup;
	public var archers:FlxGroup;
	public var objects:FlxGroup;
	public var shops:FlxGroup;
	public var floor:FlxTilemap;
	public var farmlands:FlxGroup;
	public var props:FlxGroup;
	public var lights:FlxGroup;
	public var darkness:FlxSprite;
	public var water:Water;
	public var arrows:FlxGroup;
	public var fx:FlxGroup;
	public var fog:Fog;
	public var text:FlxText;
	public var centerText:FlxText;
	public var sack:Coinsack;
	public var noise:FlxSprite;

	public var weather:Weather;

	// Extra references
	public var castle:Castle;
	public var minimap:Minimap;

	public var weatherInput:FlxTextField;

	// CONSTANTS
	public static inline var CHEATS:Bool = true; // um, why is this set to true?
	public static inline var WEATHERCONTROLS:Bool = false;

	public static inline var GAME_WIDTH:Int = 3840;
	public static inline var MIN_KINGDOM_WIDTH:Int = 200;

	public static inline var MAX_BUNNIES:Int = 50;
	public static inline var MIN_BUNNY_SPAWNTIME:Float = 6.0;

	public static inline var MIN_TROLL_SPAWNTIME:Float = 1.0;

	public static inline var TEXT_MAX_ALPHA:Float = 0.7;
	public static inline var TEXT_READ_SPEED:Float = 0.20;
	public static inline var TEXT_MIN_TIME:Float = 6;

	// Game vars
	public var kingdomLeft:Float;
	public var kingdomRight:Float;
	public var groundHeight:Int;
	public var phase:Int;
	public var phasesPaused:Bool;
	public var timeToNextPhase:Float;
	public var bunnySpawnTimer:Float;
	public var trollSpawnTimer:Float;
	public var trollsToSpawn:Array<Troll>;
	public var minBeggars:Int;
	public var retreatDelay:Float;
	public var gameOver:Bool;
	public var day:MochiDigits;

	public var trollHealth:Float;
	public var trollMaxSpeed:Float;
	public var trollJumpHeight:Float;
	public var trollJumpiness:Float;
	public var trollConfusion:Float;
	public var trollBig:Bool;

	public var grassTiles:Array<UInt> = new Array<UInt>();

	// Progress variables
	public var reachedVillage:Bool;
	public var recruitedCitizen:Bool;
	public var boughtItem:Bool;
	public var buyBowAdvice:Bool;
	public var buyScytheAdvice:Bool;
	public var expandedKingdomAdvice:Bool;
	public var horseAdvice:Bool;
	public var outOfGoldAdvice:Bool;
	public var savedProgress:String;
	public var restoreProgress:String;

	// Internals
	public var textTimeout:Float;
	public var textQueue:Array<Dynamic>;
	public var cameraTarget:CameraTarget;
	public var cameraTimeout:Float;

	public var music:FlxSound ;
	public var cicada:FlxSound;
	public var owls:FlxSound ;
	public var birds:FlxSound;

	// Cheatvars
	private var cheatNoTrolls:Bool;
	private var untouchable:Bool;

	private var weatherPresets:WeatherPresets;
	private var utils:Utils = new Utils();

	public var PHASES:Array<Array<Dynamic>>;
	public var PHASES_CYCLE:Array<Array<Dynamic>>;

	public function new(progress:String=null)
	{
		// SETTING VARIABLES BECAUSE HAXE!!!
		kingdomLeft = 1720;
		kingdomRight = 2120;
		groundHeight = 132;
		phase = 0;
		phasesPaused = false;
		timeToNextPhase = 0;
		bunnySpawnTimer = 0.0;
		trollSpawnTimer = 0.0;
		trollsToSpawn = [];
		minBeggars = 0;
		retreatDelay = 0;
		gameOver = false;
		day = new MochiDigits(0);

		trollHealth = 1;
		trollMaxSpeed = 20;
		trollJumpHeight = 20;
		trollJumpiness = 30;
		trollConfusion = 30;
		trollBig = false;

		reachedVillage = false;
		recruitedCitizen = false;
		boughtItem = false;
		buyBowAdvice = false;
		buyScytheAdvice = false;
		expandedKingdomAdvice = false;
		horseAdvice = false;
		outOfGoldAdvice = false;
		savedProgress = null;
		restoreProgress = null;

		textTimeout = 0;
		textQueue = [];
		cameraTimeout = 0;

		music = null;
		cicada = null;
		owls = null;
		birds = null;

		cheatNoTrolls = false;
		untouchable = false;

		super();
		restoreProgress = progress;

		weatherPresets = new WeatherPresets();

		PHASES = [
           // INTRO (0-3)
		   [weatherPresets.FOGGY, 10, null, phaseFirst, null],
           // ONE (4-9)
           [weatherPresets.DAWN, 25, null, daybreak, null],
           [weatherPresets.SUNNY, 30, null, null, null],
           [weatherPresets.EVENING, 20, null, null, null],
           [weatherPresets.NIGHT, 20, null, phaseBeforeNightOne, "MusicNight2"],
           [null, 50, null, phaseNightOne, null],
           // TWO (10-14)
           [weatherPresets.DAWNLIGHTPINK, 20, null, daybreak, null],
           [weatherPresets.DAYWINDYCLEAR, 30, null, null, 'MusicDay1'],
           [weatherPresets.DUSKYELLOW, 20, null, null, null],
           [weatherPresets.EVENINGORANGE, 20, null, null, 'MusicNight3'],
           [weatherPresets.NIGHTGREEN, 60, 30, phaseNightTwo, null], // GREEN
           // THREE (15-18)
           [weatherPresets.DAWNGREY, 20, null, daybreak, null],
           [weatherPresets.DAYBLEAK, 50, null, null, 'MusicDay2'],
           [weatherPresets.DUSKWARM, 20, null, null, null],
           [weatherPresets.EVENINGBLACK, 20, null, null, "MusicNight4"],
           [weatherPresets.NIGHTDARK, 60, 30, phaseNightThree, null],
           // FOUR (19-22)
           [weatherPresets.DAWNBLEAK, 20, null, daybreak, null],
           [weatherPresets.DAYSOFT, 40, null, null, null],
           [weatherPresets.EVENINGMONOTONE, 30, null, null, 'MusicNight5'],
           [weatherPresets.NIGHTSUPERDARK, 65, 30, phaseNightFour, null],
           // FIVE (23-26)
           [weatherPresets.DAWNLIGHTPINK, 20, null, daybreak, "MusicDay3"],
           [weatherPresets.DAYBLEAK, 55, null, null, null],
           [weatherPresets.EVENINGFOGGY, 40, null, null, 'MusicNight4'],
           [weatherPresets.NIGHTFOGGY, 60, 30, phaseNightFive, null],
           // SIX (27-30)
           [weatherPresets.DAWNBLEAK, 25, null, daybreak, 'MusicDay4'],
           [weatherPresets.DAYMONOCHROME, 60, null, null, null],
           [weatherPresets.DUSKPINK, 15, null, null, null],
           [weatherPresets.NIGHTCLEAR, 70, 30, phaseNightSix, 'MusicNight4'],
           // SEVEN (31-34)
           [weatherPresets.DAWNCLEARORANGE, 20, null, daybreak, null],
           [weatherPresets.DAYCLEARCOLD, 40, null, null, 'MusicDay3'],
           [weatherPresets.DUSKCLEAR, 20, null, null, null],
           [weatherPresets.NIGHTSHINE, 70, 30, phaseNightSeven, 'MusicNight3'],
           // EIGHT (35-38)
           [weatherPresets.DAWNREDMOON, 40, null, daybreak, 'MusicDay5'],
           [weatherPresets.DAYORANGESKY, 40, null, null, null],
           [weatherPresets.DUSKFOGGY, 20, null, null, null],
           // BIG WAVE
           [weatherPresets.NIGHTPURPLE, 80, 30, phaseNightEight, 'usicNight4'],
           // NINE (39-42)
           [weatherPresets.DAWNBRIGHT, 20, null, daybreak, null],
           [weatherPresets.DAYPASTEL, 75, null, null, 'MusicDay2'],
           [weatherPresets.DUSKTAN, 20, null, null, 'MusicNight4'],
           // SINGLE TROLL, MASSIVE HEALTH
           [weatherPresets.NIGHTREDMOON, 60, 30, phaseNightNine, null],
           // TEN (43)
           [weatherPresets.DAWNBROWN, 20, null, daybreak, null],
           [weatherPresets.DAYDUSTY, 40, null, null, null],
           [weatherPresets.DUSKRED, 20, null, null, 'MusicNight3'],
           // EVERYTHING, YOU DIE HERE.
           [weatherPresets.NIGHTLONG, 60, 30, phaseNightTen, null],
           [weatherPresets.DAWNEARLY, 15, null, trollRetreat, null],
        ];

		PHASES_CYCLE = [
			[weatherPresets.DAWNREDMOON, 20, null, daybreak, null],
			[weatherPresets.DAYPASTEL, 40, null, null, null],
			[weatherPresets.DUSKTAN, 20, null, null, null],
			[weatherPresets.NIGHTLONG, 30, null, null, 'MusicNight5'],
			[null, 55, null, phaseNightCycle, null]
		];
	}

	//=== INITIALIZATION ==//
	override public function create():Void
	{
		FlxG.camera.bgColor = 0xFFAFB4C2;
		FlxG.camera.bounds = new FlxRect(0, 0, GAME_WIDTH, 196);
		FlxG.worldBounds.width = GAME_WIDTH;
		FlxG.worldBounds.height = 300;

		buildLevel(Assets.getText("assets/levels/fields.oel"));
		weather.tweenTo(weatherPresets.FOGGY, 0);

		if (CHEATS)
		{
			add(minimap = new Minimap(0, FlxG.height - 1, 100, 1));
			minimap.add(trolls, 0xFF87B587);
			minimap.add(trollsNoCollide, 0xFF0000FF);
			minimap.add(player, 0xFF765DB3);
			minimap.add(beggars, 0xFF7D6841);
			minimap.add(characters, 0xFFA281F8);
			minimap.add(walls, 0xFF969696);
		}

		showCoins();

		// Load up environment sounds
		cicada = FlxG.sound.play("CicadaSound", 0.0, true);
		owls = FlxG.sound.play("OwlsSound", 0.0, true);
		birds = FlxG.sound.play("BirdsSound", 0.0, true);

		// Camera
		add(cameraTarget = new CameraTarget());
		cameraTarget.target = player;
		cameraTarget.offset.y = -4;
		cameraTarget.snap();
		FlxG.camera.follow(cameraTarget, FlxCamera.STYLE_LOCKON);

		// Set up some debugging
		FlxG.watch.add(this, "timeToNextPhase");
		FlxG.watch.add(weather, "timeOfDay");
		FlxG.watch.add(weather, "progress");
		FlxG.watch.add(weather, "ambient");
		FlxG.watch.add(weather, "ambientAmount");
		FlxG.watch.add(this, "phase");

		// TODO: Set up weathercontrols
		// if (WEATHERCONTROLS)
		// {
		//
		// }
	}

	// TODO: THIS
	// can't access flixel autocomplete stuff after update
	//public function setWeatherFromInput():Void
	//{
	//
	//}

	public function progressAll():Void
	{
		reachedVillage = true;
		recruitedCitizen = true;
		boughtItem = true;
		buyBowAdvice = true;
		buyScytheAdvice = true;
		expandedKingdomAdvice = true;
	}

	public function buildLevel(levelXML:Dynamic):Void
	{
		trace(levelXML);
		// Load XML
		var oel:Xml = Xml.parse(levelXML).firstElement();
		// Variable
		var backdropFarGraphic:String = oel.get("backdropFarImg");
		var backdropCloseGraphic:String = oel.get("backdropCloseImg");
		var waterHeight:Int = Std.parseInt(oel.get("waterHeight"));
		darkness = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0x88000000);

		// Basic setup
		weather = new Weather();
		add(sky = new Sky(weather));
		add(sunmoon = new SunMoon(weather));
		add(backdropFar = new FlxBackdrop(backdropFarGraphic, 0.15, 0.2));
		//backdropFar.color = 0xFF717565;
		add(backdropClose = new FlxBackdrop(backdropCloseGraphic, 0.3, 0.2));
		//backdropClose.color = 0xFF555849;
		backdrop = new FlxGroup();
		for (i in 0...backdrop.members.length)
			add(backdrop.members[i]);

		add(haze = new Haze(0, 0, weather));
		// Movables
		add(archers = new FlxGroup(10));
		add(objects = new FlxGroup());
		add(shops = new FlxGroup());
		add(bunnies = new FlxGroup());
		add(player = new Player(100, 68));
		add(characters = new FlxGroup());

		add(trolls = new FlxGroup());
		add(trollsNoCollide = new FlxGroup());
		add(walls = new FlxGroup());
		add(coins = new FlxGroup(100));
		add(gibs = new FlxGroup(200));
		add(indicators = new FlxGroup());

		// Level
		add(level = new FlxGroup());
		add(floor = new FlxTilemap());
		add(farmlands = new FlxGroup());
		add(props = new FlxGroup());
		// Effects
		add(lights = new FlxGroup());
		darkness.scrollFactor.x = darkness.scrollFactor.y = 0;
		darkness.blend = BlendMode.MULTIPLY;
		add(darkness);

		add(centerText = new FlxText(10, 138, FlxG.width, "TEXT"));
		centerText.setFormat("04b03", 32, 0xFFFFFFFF, "center", 0xAA333333);
		centerText.visible = false;
		centerText.scrollFactor.x = 0;
		centerText.alpha = 1.0;

		add(water = new Water( -4, waterHeight, FlxG.width + 8, 44, lights, weather));
		add(arrows = new FlxGroup());
		add(fx = new FlxGroup());

		add(sack = new Coinsack(270, 2));

		add(fog = new Fog(weather));

		add(noise = new FlxSprite(0, 0));
		noise.scrollFactor.x = noise.scrollFactor.y = 0;
		noise.makeGraphic(FlxG.width, FlxG.height, 0xFFFF00FF);
		noise.pixels.noise(0, 0, 255, 7, true);
		noise.alpha = 0.015;

		/*
		 * TODO LEVEL BUILDING
		 *
		 * SUGGESTION: BRUTE FORCE THIS
		 *
		// Add backdrop objects
		var o:Xml;
		if (backdrop != null)
		{
			buildObjects(backdrop[0], backdrop);
			for (i in 0...backdrop.length)
			{
				backdrop.members[i].scrollFactor.x = 0.5;
			}
		}
		// Add ground tiles*/

	}

	/*
	public function buildObjects(nodes:XMLList, groups:FlxGroup):Void
	{

	}
	*/

	//=== GAME LOGIC ===//
	override public function update():Void
	{
		// Collisions

		if (restoreProgress != "")
		{
			setProgress(restoreProgress);
			restoreProgress = null;
		}

		FlxG.collide(level, coins);
        FlxG.collide(level, trolls);
        FlxG.collide(level, trollsNoCollide);
        FlxG.collide(level, gibs);
        FlxG.collide(trolls, trolls);
        FlxG.overlap(trolls, walls, this.trollWall);
        FlxG.overlap(trollsNoCollide, walls, this.trollWall);
        FlxG.overlap(arrows, trolls, this.trollShot);
        FlxG.overlap(arrows, trollsNoCollide, this.trollShot);
        FlxG.overlap(arrows, bunnies, this.bunnyShot);
        FlxG.overlap(coins, characters,this.pickUpCoin);
        FlxG.overlap(coins, player,this.pickUpCoin);
        FlxG.overlap(coins, beggars, this.pickUpCoin);
        FlxG.overlap(coins, trolls, this.pickUpCoin);
        FlxG.overlap(coins, trollsNoCollide, this.pickUpCoin);
        FlxG.overlap(trolls, characters, this.trollHit);
        FlxG.overlap(trollsNoCollide, characters, this.trollHit);
        FlxG.overlap(trolls, beggars, this.trollHit);
        FlxG.overlap(trollsNoCollide, beggars, this.trollHit);
		if (!(CHEATS && untouchable))
		{
			FlxG.overlap(trolls, player, this.trollHit);
			FlxG.overlap(trollsNoCollide, player, this.trollHit);
		}
		// Update weather
		weather.update();

		// Gamestate
		if (timeToNextPhase <= 0)
		{
			nextPhase();
		}
		else if (!phasesPaused)
		{
			timeToNextPhase -= FlxG.elapsed;
		}
		kingdomRight = Math.max(GAME_WIDTH / 2 + MIN_KINGDOM_WIDTH / 2, kingdomRight - FlxG.elapsed * 4);
		kingdomLeft = Math.min(GAME_WIDTH / 2 + MIN_KINGDOM_WIDTH / 2, kingdomLeft + FlxG.elapsed * 4);

		// Spawn bunnies using logistic growth
		var p:Float = (bunnies.countLiving() + 2) / (MAX_BUNNIES + 2);
		if (bunnySpawnTimer <= 0)
		{
			bunnySpawnTimer = MIN_BUNNY_SPAWNTIME;
			var probAdd:Float = 0.5 + 2 * p * (1 - p);
			if (FlxRandom.float() < probAdd)
			{
				var rx:Int = Std.int(FlxRandom.float() * grassTiles.length);
				bunnies.add(new Bunny(grassTiles[rx] * 32, 0));
			}
		}
		else {
			bunnySpawnTimer -= FlxG.elapsed;
		}

		// Spawn beggars
		if (beggars.countLiving() < minBeggars)
		{
			beggars.add(new Citizen((FlxRandom.float() < 0.5) ? 16 : GAME_WIDTH - 16, 0));
		}

		// Spawn trolls
		updateTrollSpawn();
		trollSpawnTimer -= FlxG.elapsed;
		if (retreatDelay > 0)
		{
			retreatDelay -= FlxG.elapsed;
			if (retreatDelay <= 0)
			{
				trolls.callAll("retreat");
				trollsNoCollide.callAll("retreat");
			}
		}

		// Text update
		if (textTimeout <= 0)
		{
			showText();
		}
		else
		{
			text.alpha = Math.min(TEXT_MAX_ALPHA, textTimeout);
			textTimeout -= FlxG.elapsed;
		}
		if (centerText.visible && centerText.alpha < 0.001)
		{
			centerText.visible = false;
		}
		else
		{
			centerText.alpha -= 0.05 * FlxG.elapsed;
		}

		// Camera follow timeout
		if (cameraTarget.target != player)
		{
			if (cameraTimeout <= 0)
			{
				// Reset the cameratarget.
				cameraTarget.target = player;
				cameraTarget.lead = 48;
			}
			else
			{
				cameraTimeout -= FlxG.elapsed;
			}
		}

		// Progress update
		if (player.x > GAME_WIDTH / 2 && !reachedVillage)
		{
			reachedVillage = true;
			if (beggars.length > 0)
			{
				panTo(cast(beggars.members[0], FlxSprite), 5.0);
				showText("Throw some coins [DOWN] near them.");
			}
		}

		if (recruitedCitizen && !boughtItem && !buyBowAdvice)
		{
			buyBowAdvice = true;
			showText("Buy them bows to defend and hunt for you.");
			panTo(cast(shops.members[1], FlxSprite), 7.5);
		}

		if (buyBowAdvice && !buyScytheAdvice && cameraTarget.target == player)
		{
			buyScytheAdvice = true;
			showText("Buy them scythes to build and farm for you.");
			panTo(cast(shops.members[0], FlxSprite), 7.5);
		}

		if (boughtItem && !expandedKingdomAdvice && characters.length >= 4 && weather.timeOfDay > 0.3 && weather.timeOfDay < 0.6)
		{
			expandedKingdomAdvice = true;
			showText("Expand your kingdom by building a wall here.");
			panTo(cast(walls.members[1], FlxSprite), 5.0, -12);
		}

		this.updateEnvironmentSounds();

		if (gameOver && FlxG.mouse.justPressed)
		{
			FlxG.mouse.visible = false;
			FlxG.switchState(new PlayState(savedProgress));
		}

		super.update();

		if (FlxG.keys.justPressed.S)
		{
			if (FlxG.stage.displayState == StageDisplayState.NORMAL)
			{
				FlxG.stage.displayState = StageDisplayState.FULL_SCREEN;
			}
			else
			{
				FlxG.stage.displayState = StageDisplayState.NORMAL;
			}
		}

		/*
		 * TODO: CHEATS KEY EVENTS
		*/
	}

	public function phaseFirst():Void
	{
		beggars.add(new Citizen(kingdomRight + 580, 0));
		beggars.add(new Citizen(kingdomRight + 600, 0));
	}

	public function phaseBeforeNightOne():Void
	{
		showText("Night comes, be careful.");
	}

	public function phaseNightOne():Void
	{
		trollStats(24, 1, 20, 999999, false, 16.0); // Nojump
		spawnTrolls(2);
		if (player.x < GAME_WIDTH / 2)
		{
			panTo(cast(trolls.members[0], FlxSprite));
		}
		else
		{
			panTo(cast(trolls.members[1], FlxSprite));
		}
		showText("They will noodle your stuff away.");
		showText("They will noodle your stuff away.");
	}

	// These trolls still won't scale your lowest walls
	public function phaseNightTwo():Void
	{
		trollStats(26, 1, 20, 2, false, 12.0); // Jump0
		spawnTrolls(12);
	}

	// These WILL scale the lowest walls
	public function phaseNightThree():Void
	{
		trollStats(26, 1, 30, 2, false, 12.0);
		spawnTrolls(20);
	}

	// The trolls are a little toughter now.
	public function phaseNightFour():Void
	{
		trollStats(26, 3, 30, 2, false, 12.0);
		spawnTrolls(24);
	}

	// They are faster but more chaotic, they might
	// break your walls, which will kill you in the next wave.
	public function phaseNightFive():Void
	{
		trollStats(35, 2, 38, 2, false, 4.0);
		spawnTrolls(36);
	}

	// These trolls will scale the stone walls
	public function phaseNightSix():Void
	{
		trollStats(30, 3, 45, 2, false, 10.0);
		spawnTrolls(8);
	}

	// Boss wave trolls
	public function phaseNightSeven():Void
	{
		trollStats(20, 30, 10, 999999, true, 16.0);
		spawnTrolls(2);
	}

	// Since the boss probably broke your walls
	// these trolls jump very high, there is no
	// disadvantage to not having walls.
	// You will need them back in the next wave though.
	public function phaseNightEight():Void
	{
		trollStats(40, 4, 50, 3, false, 12.0);
		spawnTrolls(16);
	}

	// You need the highest walls here
	public function phaseNightNine():Void
	{
		trollStats(30, 4, 45, 4, false, 8.0);
		spawnTrolls(24);
	}

	// Kill the player off
	public function phaseNightTen():Void
	{
		trollStats(20, 30, 10, 999999, true, 16.0); // Boss
		spawnTrolls(4);
		trollStats(30, 4, 45, 4, false, 8.0); // Strong
		spawnTrolls(20);
		trollStats(40, 2, 50, 3, false, 12.0); // Jumper
		spawnTrolls(10);
		trollStats(26, 1, 30, 2, false, 12.0); // Grunts
		spawnTrolls(40);
	}

	public function phaseNightCycle():Void
	{
		var difficulty:Float = day.value - 10;
		trollStats(30, 4, 45, 4, false, 8.0); // Strong
		spawnTrolls(Std.int(10 * difficulty));
		if (day.value % 2 == 0)
		{
			trollStats(20, 30, 10, 999999, true, 16.0); // Boss
			spawnTrolls(Std.int(2 * difficulty));
		}
	}

	public function nextPhase():Void
	{
		if (phasesPaused) return;

		var currentPhase:Array<Dynamic>;
		if (phase < PHASES.length)
		{
			currentPhase = PHASES[phase];
		}
		else
		{
			var p:Int = (phase - PHASES.length) % 5;
			currentPhase = PHASES_CYCLE[p];
		}
		var weatherTweenTime:Float;
		timeToNextPhase = currentPhase[1];
		// Transform weather
		if (currentPhase[2] == null)
		{
			weatherTweenTime = timeToNextPhase * 0.7;
		}
		else
		{
			weatherTweenTime = currentPhase[2];
		}
		if (currentPhase[0] != null)
		{
			weather.tweenTo(currentPhase[0], weatherTweenTime);
		}
		phase += 1;
		// Call the function to do custom actions if there is one
		if (currentPhase[3] != null)
		{
			currentPhase[3]();
		}

		// Play music
		if (currentPhase[4] != null)
		{
			if (this.music != null)
			{
				this.music.stop();
			}
			this.music = FlxG.sound.play(currentPhase[4]);
			trace("Playing " + currentPhase[4]);
		}
	}

	public function updateEnvironmentSounds():Void
	{
		var v:Float;
		v = 1 - Math.pow(Math.abs(weather.timeOfDay - 0.7) / 0.1, 2);
		this.cicada.volume = v;

		v = 1 - Math.pow(Math.min(weather.timeOfDay, Math.abs(weather.timeOfDay - 1.0)) / 2, 2);
		this.owls.volume = v;

		v = 1 - Math.pow(Math.abs(weather.timeOfDay - 0.4) / 0.25, 2);
		this.birds.volume = v;
	}

	public function trollStats(speed:Float, health:Float, jumpHeight:Float, jumpiness:Float = 2, big:Bool = false, confusion:Float = 3):Void
	{
		trollMaxSpeed = speed;
		trollHealth = health;
		trollJumpHeight = jumpHeight;
		trollJumpiness = jumpiness;
		trollBig = big;
		trollConfusion = confusion;
	}

	public function spawnTrolls(amount:Int):Void
	{
		if (cheatNoTrolls) return;

		while (amount != 0)
		{
			amount -= 2;

			var troll:Troll = cast(trolls.recycle(Troll), Troll);
			troll.reset(64, groundHeight - 40);
			trollsToSpawn.push(troll);

			troll = cast(trolls.recycle(Troll), Troll);
			troll.reset(GAME_WIDTH - 64, groundHeight - 40);
			trollsToSpawn.push(troll);

			updateTrollSpawn();
		}
	}

	public function updateTrollSpawn():Void
	{
		if (trollsToSpawn.length > 0 && trollSpawnTimer <= 0)
		{
			cast(trollsToSpawn.shift(), Troll).go();
			cast(trollsToSpawn.shift(), Troll).go();
			trollSpawnTimer = MIN_TROLL_SPAWNTIME;
		}
	}

	public function daybreak():Void
	{
		trollRetreat();
		cast(coins.recycle(Coin), Coin).drop(castle, player);
		if (castle.stage >= 2)
		{
			cast(coins.recycle(Coin), Coin).drop(castle, player);
		}
		day.addValue(1);
		showCenterText(utils.toRoman(Std.int(day.value)));
		saveProgress();
	}

	public function saveProgress():Void
	{
		var numBeggars:Int = beggars.countLiving();
		var numCitizens:Array<Int> = [0, 0, 0, 0];
		for (i in 0...characters.length)
		{
			if (characters.members[i] != null && (characters.members[i].alive))
			{
				numCitizens[cast(characters.members[i], Citizen).occupation]++;
			}
		}
		numCitizens[Citizen.HUNTER] += Std.int(Math.max(0, archers.countLiving()));
		var wallStages:Array<Int> = [];
		for (i in 0...walls.length)
		{
			wallStages.push(cast(walls.members[i], Wall).stage);
		}

		var s:String = '';
		s += 'D' + day.value + ' ';
		s += 'A' + phase + ' ';
		s += 'X' + Std.int(player.x) + ' ';
		s += 'B' + numBeggars + ' ';
		s += 'P' + numCitizens[Citizen.POOR] + ' ';
		s += 'F' + numCitizens[Citizen.FARMER] + ' ';
		s += 'H' + numCitizens[Citizen.HUNTER] + ' ';
		s += 'W' + wallStages.join('') + ' ';
		s += 'C' + castle.stage + ' ';
		s += 'S' + cast(shops.members[0], Shop).supply + cast(shops.members[1], Shop).supply + ' ';
		s += 'G' + cast(player, Player).coins;
		trace(s);
		savedProgress = s;
	}

	public function setProgress(s:String):Void
	{
		progressAll();
		if(s == null) {
			return;
		}

		// Regular expressions
		var newDay_r:EReg 		= ~/D(\d+)/;
		var ph_r:EReg			= ~/A(\d+)/;
		var playerX_r:EReg 		= ~/X(\d+)/;
		var numBeggars_r:EReg	= ~/B(\d+)/;
		var numPoor_r:EReg		= ~/P(\d+)/;
		var numFarmers_r:EReg	= ~/F(\d+)/;
		var numHunters_r:EReg 	= ~/H(\d+)/;
		var wallStages_r:EReg	= ~/W(\d)(\d)(\d)(\d)(\d)(\d)/;
		var castleStage_r:EReg	= ~/C(\d)/;
		var shopSupply_r:EReg	= ~/S(\d)(\d)/;
		var gold_r:EReg			= ~/G(\d)/;

		// Matching
		newDay_r.match(s);
		ph_r.match(s);
		playerX_r.match(s);
		numBeggars_r.match(s);
		numPoor_r.match(s);
		numFarmers_r.match(s);
		numHunters_r.match(s);
		wallStages_r.match(s);
		castleStage_r.match(s);
		shopSupply_r.match(s);
		gold_r.match(s);

		// Parsing
		var newDay:Int 		= Std.parseInt(newDay_r.matched(1));
		var ph:Int			= Std.parseInt(ph_r.matched(1));
		var playerX:Int		= Std.parseInt(playerX_r.matched(1));
		var numBeggars:Int	= Std.parseInt(numBeggars_r.matched(1));
		var numPoor:Int		= Std.parseInt(numPoor_r.matched(1));
		var numFarmers:Int	= Std.parseInt(numFarmers_r.matched(1));
		var numHunters:Int	= Std.parseInt(numHunters_r.matched(1));
		var wallStages:Array<Int> = [
							Std.parseInt(wallStages_r.matched(1)),
							Std.parseInt(wallStages_r.matched(2)),
							Std.parseInt(wallStages_r.matched(3)),
							Std.parseInt(wallStages_r.matched(4)),
							Std.parseInt(wallStages_r.matched(5)),
							Std.parseInt(wallStages_r.matched(6))
							];
		var castleStage:Int = Std.parseInt(castleStage_r.matched(1));
		var shopSupply:Array<Int> = [
							Std.parseInt(shopSupply_r.matched(1)),
							Std.parseInt(shopSupply_r.matched(2))
							];
		var gold:Int		= Std.parseInt(gold_r.matched(1));

		while (beggars.countLiving() < numBeggars)
		{
			beggars.add(new Citizen((kingdomRight + kingdomLeft) / 2, 0));
		}

		player.x = playerX;

		characters.callAll("kill");
		archers.callAll("kill");
		var c:Citizen;
		while (numPoor > 0)
		{
			c = new Citizen((kingdomRight + kingdomLeft) / 2, 0);
			c.morph(Citizen.POOR);
			characters.add(c);
			numPoor--;
		}

		while (numFarmers > 0)
		{
			c = new Citizen((kingdomRight + kingdomLeft) / 2, 0);
			c.morph(Citizen.FARMER);
			characters.add(c);
			numFarmers--;
		}

		while (numHunters > 0)
		{
			c = new Citizen((kingdomRight + kingdomLeft) / 2, 0);
			c.morph(Citizen.HUNTER);
			characters.add(c);
			numHunters--;
		}

		for (i in 0...walls.length)
		{
			cast(walls.members[i], Wall).buildTo(wallStages[i + 1], true);
		}

		cast(shops.members[0], Shop).setSupply(shopSupply[0]);
		cast(shops.members[1], Shop).setSupply(shopSupply[1]);

		castle.morph(castleStage);

		cast(player, Player).changeCoins(gold - cast(player, Player).coins);

		phase = ph - 1;
		day.setValue(newDay - 1);
		nextPhase();

		trolls.callAll("kill");
		trollsNoCollide.callAll("kill");
		gibs.callAll("kill");
	}

	public function trollRetreat(delay:Float = 10):Void
	{
		retreatDelay = delay;

		if (retreatDelay <= 0)
		{
			//trollsToSpawn.splice(0);
			trollsToSpawn.splice(0, trolls.length);
			trolls.callAll("retreat");
			trollsNoCollide.callAll("retreat");
		}
	}

	public function pickUpCoin(coin:FlxObject, char:FlxObject):Void
	{
		if (Std.is(char, Player))
		{
			cast(char, Player).pickup(coin);
		}
		else if (Std.is(char, Citizen))
		{
			cast(char, Citizen).pickup(coin);
		}
		else if (Std.is(char, Troll))
		{
			cast(char, Troll).pickup(coin);
		}
	}

	public function giveTaxes(char:FlxObject, player:FlxObject):Void
	{
		if (char != player)
		{
			cast(char, Citizen).giveTaxes(cast(player, Player));
		}
	}

	public function trollWall(troll:FlxObject, wall:FlxObject):Void
	{
		FlxObject.separate(troll, wall);
		wall.hurt(cast(troll, Troll).big ? 10 : 5);
	}

	public function trollShot(arrow:FlxObject, troll:Troll):Void
	{
		if (troll.alive && arrow.exists)
		{
			FlxG.sound.play("HitbigSound").proximity(arrow.x, arrow.y, player, FlxG.width);
			arrow.kill();
			cast(troll, Troll).getShot();
		}
	}

	public function bunnyShot(arrow:FlxObject, bunny:FlxObject):Void
	{
		if (bunny.alive && arrow.exists)
		{
			FlxG.sound.play("HitSound").proximity(arrow.x, arrow.y, player, FlxG.width);
			arrow.kill();
			cast(bunny, Bunny).getShot(cast(arrow, Arrow));
		}
	}

	public function trollHit(troll:FlxObject, char:FlxObject):Void
	{
		if (Std.is(char, Citizen))
		{
			cast(char, Citizen).hitByTroll(cast(troll, Troll));
		}
		if (char == player)
		{
			cast(char, Player).hitByTroll(cast(troll, Troll));
		}
	}

	public function crownStolen():Void
	{
		gameOver = true;
		phasesPaused = true;
		trollRetreat(0);
		FlxG.mouse.visible = true;
		showText("No crown, no king. Game over.");
		showText("Click to continue.");
		//showText("Wait to enter highscore.");
		//showText("Click to continue.");
		//showText("Wait to enter highscore.");
		//
		// No highscores because Haxe.
		FlxG.cameras.fade(0, 20, false, endGame);
	}

	public function endGame():Void
	{
		FlxG.switchState(new GameOverState(Std.int(day.value - 1)));
	}

	//=== RENDERING ===//
	override public function draw():Void
	{
		darkness.dirty = true;
		darkness.pixels.fillRect(new Rectangle(0, 0, darkness.width, darkness.height), weather.darknessColor);

		super.draw();
		#if flash
		weather.ambientTransform.applyFilter(FlxG.camera.buffer);
		#end
	}

	public function showCoins():Void
	{
		var c:Int = cast(player, Player).coins;
		sack.show(c);
	}

	public function showText(t:String = null):Void
	{
		if (t != null)
		{
			textQueue = textQueue.concat(t.split("\n"));
		}
		if (textQueue.length > 0 && textTimeout <= 0)
		{
			text.text = textQueue.shift();
			text.visible = true;
			textTimeout = Math.max(TEXT_MIN_TIME, TEXT_READ_SPEED * text.text.length);
		}
	}

	public function showCenterText(t:String):Void
	{
		centerText.text = t;
		centerText.visible = true;
		centerText.alpha = 0.999;
	}

	public function panTo(o:FlxSprite, duration:Float = 8.0, lead:Float = 0):Void
	{
		cameraTimeout = duration;
		cameraTarget.target = o;
		cameraTarget.lead = lead;
	}
}
