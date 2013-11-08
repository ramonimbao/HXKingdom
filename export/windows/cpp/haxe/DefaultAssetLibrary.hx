package;


import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.MovieClip;
import flash.text.Font;
import flash.media.Sound;
import flash.net.URLRequest;
import flash.utils.ByteArray;
import haxe.Unserializer;
import openfl.Assets;

#if (flash || js)
import flash.display.Loader;
import flash.events.Event;
import flash.net.URLLoader;
#end

#if ios
import openfl.utils.SystemPath;
#end


class DefaultAssetLibrary extends AssetLibrary {
	
	
	public static var className (default, null) = new Map <String, Dynamic> ();
	public static var path (default, null) = new Map <String, String> ();
	public static var type (default, null) = new Map <String, AssetType> ();
	
	
	public function new () {
		
		super ();
		
		#if flash
		
		className.set ("assets/04b03.ttf", __ASSET__assets_04b03_ttf);
		type.set ("assets/04b03.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
		className.set ("assets/aurora.ttf", __ASSET__assets_aurora_ttf);
		type.set ("assets/aurora.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
		className.set ("assets/data/data-goes-here.txt", __ASSET__assets_data_data_goes_here_txt);
		type.set ("assets/data/data-goes-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("assets/gfx/arrow.png", __ASSET__assets_gfx_arrow_png);
		type.set ("assets/gfx/arrow.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/attention.png", __ASSET__assets_gfx_attention_png);
		type.set ("assets/gfx/attention.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/beggar.png", __ASSET__assets_gfx_beggar_png);
		type.set ("assets/gfx/beggar.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/bunny.png", __ASSET__assets_gfx_bunny_png);
		type.set ("assets/gfx/bunny.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/campfire.png", __ASSET__assets_gfx_campfire_png);
		type.set ("assets/gfx/campfire.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/castle.png", __ASSET__assets_gfx_castle_png);
		type.set ("assets/gfx/castle.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/citizen.png", __ASSET__assets_gfx_citizen_png);
		type.set ("assets/gfx/citizen.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/cobblestones.png", __ASSET__assets_gfx_cobblestones_png);
		type.set ("assets/gfx/cobblestones.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/coin.png", __ASSET__assets_gfx_coin_png);
		type.set ("assets/gfx/coin.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/coin_drop.png", __ASSET__assets_gfx_coin_drop_png);
		type.set ("assets/gfx/coin_drop.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/dust.png", __ASSET__assets_gfx_dust_png);
		type.set ("assets/gfx/dust.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/farmer.png", __ASSET__assets_gfx_farmer_png);
		type.set ("assets/gfx/farmer.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/farmland.png", __ASSET__assets_gfx_farmland_png);
		type.set ("assets/gfx/farmland.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/firefly.png", __ASSET__assets_gfx_firefly_png);
		type.set ("assets/gfx/firefly.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/fog.png", __ASSET__assets_gfx_fog_png);
		type.set ("assets/gfx/fog.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/hill.png", __ASSET__assets_gfx_hill_png);
		type.set ("assets/gfx/hill.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/hunter.png", __ASSET__assets_gfx_hunter_png);
		type.set ("assets/gfx/hunter.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/king.png", __ASSET__assets_gfx_king_png);
		type.set ("assets/gfx/king.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/light.png", __ASSET__assets_gfx_light_png);
		type.set ("assets/gfx/light.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/light_large.gif", __ASSET__assets_gfx_light_large_gif);
		type.set ("assets/gfx/light_large.gif", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/light_large.png", __ASSET__assets_gfx_light_large_png);
		type.set ("assets/gfx/light_large.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/light_mid.gif", __ASSET__assets_gfx_light_mid_gif);
		type.set ("assets/gfx/light_mid.gif", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/light_mid.png", __ASSET__assets_gfx_light_mid_png);
		type.set ("assets/gfx/light_mid.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/light_reflect_small.png", __ASSET__assets_gfx_light_reflect_small_png);
		type.set ("assets/gfx/light_reflect_small.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/light_reflect_wide.png", __ASSET__assets_gfx_light_reflect_wide_png);
		type.set ("assets/gfx/light_reflect_wide.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/light_small.gif", __ASSET__assets_gfx_light_small_gif);
		type.set ("assets/gfx/light_small.gif", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/light_small.png", __ASSET__assets_gfx_light_small_png);
		type.set ("assets/gfx/light_small.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/outline_noio.png", __ASSET__assets_gfx_outline_noio_png);
		type.set ("assets/gfx/outline_noio.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/outline_pez.png", __ASSET__assets_gfx_outline_pez_png);
		type.set ("assets/gfx/outline_pez.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/pier.png", __ASSET__assets_gfx_pier_png);
		type.set ("assets/gfx/pier.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/reed.png", __ASSET__assets_gfx_reed_png);
		type.set ("assets/gfx/reed.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/sack.png", __ASSET__assets_gfx_sack_png);
		type.set ("assets/gfx/sack.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/scaffold.png", __ASSET__assets_gfx_scaffold_png);
		type.set ("assets/gfx/scaffold.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/shop.png", __ASSET__assets_gfx_shop_png);
		type.set ("assets/gfx/shop.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/skyline_hills.png", __ASSET__assets_gfx_skyline_hills_png);
		type.set ("assets/gfx/skyline_hills.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/skyline_trees.png", __ASSET__assets_gfx_skyline_trees_png);
		type.set ("assets/gfx/skyline_trees.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/sparkle.png", __ASSET__assets_gfx_sparkle_png);
		type.set ("assets/gfx/sparkle.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/splash.png", __ASSET__assets_gfx_splash_png);
		type.set ("assets/gfx/splash.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/sunmoon.png", __ASSET__assets_gfx_sunmoon_png);
		type.set ("assets/gfx/sunmoon.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/tiles.png", __ASSET__assets_gfx_tiles_png);
		type.set ("assets/gfx/tiles.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/title.png", __ASSET__assets_gfx_title_png);
		type.set ("assets/gfx/title.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/torch.png", __ASSET__assets_gfx_torch_png);
		type.set ("assets/gfx/torch.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/treeline.png", __ASSET__assets_gfx_treeline_png);
		type.set ("assets/gfx/treeline.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/tree_dead.png", __ASSET__assets_gfx_tree_dead_png);
		type.set ("assets/gfx/tree_dead.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/troll.png", __ASSET__assets_gfx_troll_png);
		type.set ("assets/gfx/troll.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/trollbig.png", __ASSET__assets_gfx_trollbig_png);
		type.set ("assets/gfx/trollbig.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/gfx/wall.png", __ASSET__assets_gfx_wall_png);
		type.set ("assets/gfx/wall.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/HaxeFlixel.svg", __ASSET__assets_haxeflixel_svg);
		type.set ("assets/HaxeFlixel.svg", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("assets/images/images-go-here.txt", __ASSET__assets_images_images_go_here_txt);
		type.set ("assets/images/images-go-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("assets/levels/fields.oel", __ASSET__assets_levels_fields_oel);
		type.set ("assets/levels/fields.oel", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("assets/levels/fields_alt.oel", __ASSET__assets_levels_fields_alt_oel);
		type.set ("assets/levels/fields_alt.oel", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("assets/levels/fields_loose.oel", __ASSET__assets_levels_fields_loose_oel);
		type.set ("assets/levels/fields_loose.oel", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("assets/levels/fields_old.oel", __ASSET__assets_levels_fields_old_oel);
		type.set ("assets/levels/fields_old.oel", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("assets/music/day1.mp3", __ASSET__assets_music_day1_mp3);
		type.set ("assets/music/day1.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		className.set ("assets/music/day1.wav", __ASSET__assets_music_day1_wav);
		type.set ("assets/music/day1.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		className.set ("assets/music/day2.mp3", __ASSET__assets_music_day2_mp3);
		type.set ("assets/music/day2.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		className.set ("assets/music/day2.wav", __ASSET__assets_music_day2_wav);
		type.set ("assets/music/day2.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		className.set ("assets/music/day3.mp3", __ASSET__assets_music_day3_mp3);
		type.set ("assets/music/day3.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		className.set ("assets/music/day3.wav", __ASSET__assets_music_day3_wav);
		type.set ("assets/music/day3.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		className.set ("assets/music/day4.mp3", __ASSET__assets_music_day4_mp3);
		type.set ("assets/music/day4.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		className.set ("assets/music/day4.wav", __ASSET__assets_music_day4_wav);
		type.set ("assets/music/day4.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		className.set ("assets/music/day5.mp3", __ASSET__assets_music_day5_mp3);
		type.set ("assets/music/day5.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		className.set ("assets/music/day5.wav", __ASSET__assets_music_day5_wav);
		type.set ("assets/music/day5.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		className.set ("assets/music/music-goes-here.txt", __ASSET__assets_music_music_goes_here_txt);
		type.set ("assets/music/music-goes-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("assets/music/night1.mp3", __ASSET__assets_music_night1_mp3);
		type.set ("assets/music/night1.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		className.set ("assets/music/night1.wav", __ASSET__assets_music_night1_wav);
		type.set ("assets/music/night1.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		className.set ("assets/music/night2.mp3", __ASSET__assets_music_night2_mp3);
		type.set ("assets/music/night2.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		className.set ("assets/music/night2.wav", __ASSET__assets_music_night2_wav);
		type.set ("assets/music/night2.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		className.set ("assets/music/night3.mp3", __ASSET__assets_music_night3_mp3);
		type.set ("assets/music/night3.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		className.set ("assets/music/night3.wav", __ASSET__assets_music_night3_wav);
		type.set ("assets/music/night3.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		className.set ("assets/music/night4.mp3", __ASSET__assets_music_night4_mp3);
		type.set ("assets/music/night4.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		className.set ("assets/music/night4.wav", __ASSET__assets_music_night4_wav);
		type.set ("assets/music/night4.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		className.set ("assets/music/night5.mp3", __ASSET__assets_music_night5_mp3);
		type.set ("assets/music/night5.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		className.set ("assets/music/night5.wav", __ASSET__assets_music_night5_wav);
		type.set ("assets/music/night5.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		className.set ("assets/sound/birds.mp3", __ASSET__assets_sound_birds_mp3);
		type.set ("assets/sound/birds.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		className.set ("assets/sound/birds.wav", __ASSET__assets_sound_birds_wav);
		type.set ("assets/sound/birds.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		className.set ("assets/sound/build.bfxrsound", __ASSET__assets_sound_build_bfxrsound);
		type.set ("assets/sound/build.bfxrsound", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("assets/sound/build.mp3", __ASSET__assets_sound_build_mp3);
		type.set ("assets/sound/build.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		className.set ("assets/sound/build.wav", __ASSET__assets_sound_build_wav);
		type.set ("assets/sound/build.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		className.set ("assets/sound/cicada.aiff", __ASSET__assets_sound_cicada_aiff);
		type.set ("assets/sound/cicada.aiff", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("assets/sound/cicada.mp3", __ASSET__assets_sound_cicada_mp3);
		type.set ("assets/sound/cicada.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		className.set ("assets/sound/cicada.wav", __ASSET__assets_sound_cicada_wav);
		type.set ("assets/sound/cicada.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		className.set ("assets/sound/hit.bfxrsound", __ASSET__assets_sound_hit_bfxrsound);
		type.set ("assets/sound/hit.bfxrsound", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("assets/sound/hit.mp3", __ASSET__assets_sound_hit_mp3);
		type.set ("assets/sound/hit.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		className.set ("assets/sound/hit.wav", __ASSET__assets_sound_hit_wav);
		type.set ("assets/sound/hit.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		className.set ("assets/sound/hitbig.bfxrsound", __ASSET__assets_sound_hitbig_bfxrsound);
		type.set ("assets/sound/hitbig.bfxrsound", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("assets/sound/hitbig.mp3", __ASSET__assets_sound_hitbig_mp3);
		type.set ("assets/sound/hitbig.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		className.set ("assets/sound/hitbig.wav", __ASSET__assets_sound_hitbig_wav);
		type.set ("assets/sound/hitbig.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		className.set ("assets/sound/hitcitizen.bfxrsound", __ASSET__assets_sound_hitcitizen_bfxrsound);
		type.set ("assets/sound/hitcitizen.bfxrsound", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("assets/sound/hitcitizen.mp3", __ASSET__assets_sound_hitcitizen_mp3);
		type.set ("assets/sound/hitcitizen.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		className.set ("assets/sound/hitcitizen.wav", __ASSET__assets_sound_hitcitizen_wav);
		type.set ("assets/sound/hitcitizen.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		className.set ("assets/sound/hitwall.bfxrsound", __ASSET__assets_sound_hitwall_bfxrsound);
		type.set ("assets/sound/hitwall.bfxrsound", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("assets/sound/hitwall.mp3", __ASSET__assets_sound_hitwall_mp3);
		type.set ("assets/sound/hitwall.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		className.set ("assets/sound/hitwall.wav", __ASSET__assets_sound_hitwall_wav);
		type.set ("assets/sound/hitwall.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		className.set ("assets/sound/owls.mp3", __ASSET__assets_sound_owls_mp3);
		type.set ("assets/sound/owls.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		className.set ("assets/sound/owls.wav", __ASSET__assets_sound_owls_wav);
		type.set ("assets/sound/owls.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		className.set ("assets/sound/pickup.bfxrsound", __ASSET__assets_sound_pickup_bfxrsound);
		type.set ("assets/sound/pickup.bfxrsound", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("assets/sound/pickup.mp3", __ASSET__assets_sound_pickup_mp3);
		type.set ("assets/sound/pickup.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		className.set ("assets/sound/pickup.wav", __ASSET__assets_sound_pickup_wav);
		type.set ("assets/sound/pickup.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		className.set ("assets/sound/powerup.bfxrsound", __ASSET__assets_sound_powerup_bfxrsound);
		type.set ("assets/sound/powerup.bfxrsound", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("assets/sound/powerup.mp3", __ASSET__assets_sound_powerup_mp3);
		type.set ("assets/sound/powerup.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		className.set ("assets/sound/powerup.wav", __ASSET__assets_sound_powerup_wav);
		type.set ("assets/sound/powerup.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		className.set ("assets/sound/shoot.mp3", __ASSET__assets_sound_shoot_mp3);
		type.set ("assets/sound/shoot.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		className.set ("assets/sound/shoot.wav", __ASSET__assets_sound_shoot_wav);
		type.set ("assets/sound/shoot.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		className.set ("assets/sound/stolen.bfxrsound", __ASSET__assets_sound_stolen_bfxrsound);
		type.set ("assets/sound/stolen.bfxrsound", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("assets/sound/stolen.mp3", __ASSET__assets_sound_stolen_mp3);
		type.set ("assets/sound/stolen.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		className.set ("assets/sound/stolen.wav", __ASSET__assets_sound_stolen_wav);
		type.set ("assets/sound/stolen.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		className.set ("assets/sound/throw.bfxrsound", __ASSET__assets_sound_throw_bfxrsound);
		type.set ("assets/sound/throw.bfxrsound", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("assets/sound/throw.mp3", __ASSET__assets_sound_throw_mp3);
		type.set ("assets/sound/throw.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		className.set ("assets/sound/throw.wav", __ASSET__assets_sound_throw_wav);
		type.set ("assets/sound/throw.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		className.set ("assets/sounds/sounds-go-here.txt", __ASSET__assets_sounds_sounds_go_here_txt);
		type.set ("assets/sounds/sounds-go-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("flixel/img/debugger/buttons/console.png", __ASSET__flixel_img_debugger_buttons_console_png);
		type.set ("flixel/img/debugger/buttons/console.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/debugger/buttons/logDebug.png", __ASSET__flixel_img_debugger_buttons_logdebug_png);
		type.set ("flixel/img/debugger/buttons/logDebug.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/debugger/buttons/open.png", __ASSET__flixel_img_debugger_buttons_open_png);
		type.set ("flixel/img/debugger/buttons/open.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/debugger/buttons/pause.png", __ASSET__flixel_img_debugger_buttons_pause_png);
		type.set ("flixel/img/debugger/buttons/pause.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/debugger/buttons/play.png", __ASSET__flixel_img_debugger_buttons_play_png);
		type.set ("flixel/img/debugger/buttons/play.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/debugger/buttons/record_off.png", __ASSET__flixel_img_debugger_buttons_record_off_png);
		type.set ("flixel/img/debugger/buttons/record_off.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/debugger/buttons/record_on.png", __ASSET__flixel_img_debugger_buttons_record_on_png);
		type.set ("flixel/img/debugger/buttons/record_on.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/debugger/buttons/restart.png", __ASSET__flixel_img_debugger_buttons_restart_png);
		type.set ("flixel/img/debugger/buttons/restart.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/debugger/buttons/statsDebug.png", __ASSET__flixel_img_debugger_buttons_statsdebug_png);
		type.set ("flixel/img/debugger/buttons/statsDebug.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/debugger/buttons/step.png", __ASSET__flixel_img_debugger_buttons_step_png);
		type.set ("flixel/img/debugger/buttons/step.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/debugger/buttons/stop.png", __ASSET__flixel_img_debugger_buttons_stop_png);
		type.set ("flixel/img/debugger/buttons/stop.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/debugger/buttons/visualDebug.png", __ASSET__flixel_img_debugger_buttons_visualdebug_png);
		type.set ("flixel/img/debugger/buttons/visualDebug.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/debugger/buttons/watchDebug.png", __ASSET__flixel_img_debugger_buttons_watchdebug_png);
		type.set ("flixel/img/debugger/buttons/watchDebug.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/debugger/flixel.png", __ASSET__flixel_img_debugger_flixel_png);
		type.set ("flixel/img/debugger/flixel.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/debugger/windowHandle.png", __ASSET__flixel_img_debugger_windowhandle_png);
		type.set ("flixel/img/debugger/windowHandle.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/logo/default.png", __ASSET__flixel_img_logo_default_png);
		type.set ("flixel/img/logo/default.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/logo/HaxeFlixel.svg", __ASSET__flixel_img_logo_haxeflixel_svg);
		type.set ("flixel/img/logo/HaxeFlixel.svg", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("flixel/img/logo/logo.png", __ASSET__flixel_img_logo_logo_png);
		type.set ("flixel/img/logo/logo.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/preloader/corners.png", __ASSET__flixel_img_preloader_corners_png);
		type.set ("flixel/img/preloader/corners.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/preloader/light.png", __ASSET__flixel_img_preloader_light_png);
		type.set ("flixel/img/preloader/light.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/tile/autotiles.png", __ASSET__flixel_img_tile_autotiles_png);
		type.set ("flixel/img/tile/autotiles.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/tile/autotiles_alt.png", __ASSET__flixel_img_tile_autotiles_alt_png);
		type.set ("flixel/img/tile/autotiles_alt.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/ui/analog/base.png", __ASSET__flixel_img_ui_analog_base_png);
		type.set ("flixel/img/ui/analog/base.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/ui/analog/thumb.png", __ASSET__flixel_img_ui_analog_thumb_png);
		type.set ("flixel/img/ui/analog/thumb.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/ui/button.png", __ASSET__flixel_img_ui_button_png);
		type.set ("flixel/img/ui/button.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/ui/cursor.png", __ASSET__flixel_img_ui_cursor_png);
		type.set ("flixel/img/ui/cursor.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/ui/fontData11pt.png", __ASSET__flixel_img_ui_fontdata11pt_png);
		type.set ("flixel/img/ui/fontData11pt.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/ui/virtualpad/a.png", __ASSET__flixel_img_ui_virtualpad_a_png);
		type.set ("flixel/img/ui/virtualpad/a.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/ui/virtualpad/b.png", __ASSET__flixel_img_ui_virtualpad_b_png);
		type.set ("flixel/img/ui/virtualpad/b.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/ui/virtualpad/c.png", __ASSET__flixel_img_ui_virtualpad_c_png);
		type.set ("flixel/img/ui/virtualpad/c.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/ui/virtualpad/down.png", __ASSET__flixel_img_ui_virtualpad_down_png);
		type.set ("flixel/img/ui/virtualpad/down.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/ui/virtualpad/left.png", __ASSET__flixel_img_ui_virtualpad_left_png);
		type.set ("flixel/img/ui/virtualpad/left.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/ui/virtualpad/right.png", __ASSET__flixel_img_ui_virtualpad_right_png);
		type.set ("flixel/img/ui/virtualpad/right.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/ui/virtualpad/up.png", __ASSET__flixel_img_ui_virtualpad_up_png);
		type.set ("flixel/img/ui/virtualpad/up.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/ui/virtualpad/x.png", __ASSET__flixel_img_ui_virtualpad_x_png);
		type.set ("flixel/img/ui/virtualpad/x.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/img/ui/virtualpad/y.png", __ASSET__flixel_img_ui_virtualpad_y_png);
		type.set ("flixel/img/ui/virtualpad/y.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("flixel/snd/beep.wav", __ASSET__flixel_snd_beep_wav);
		type.set ("flixel/snd/beep.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		className.set ("flixel/snd/flixel.wav", __ASSET__flixel_snd_flixel_wav);
		type.set ("flixel/snd/flixel.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		
		
		#elseif html5
		
		className.set ("assets/04b03.ttf", __ASSET__assets_04b03_ttf);
		type.set ("assets/04b03.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
		className.set ("assets/aurora.ttf", __ASSET__assets_aurora_ttf);
		type.set ("assets/aurora.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
		path.set ("assets/data/data-goes-here.txt", "assets/data/data-goes-here.txt");
		type.set ("assets/data/data-goes-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
		path.set ("assets/gfx/arrow.png", "assets/gfx/arrow.png");
		type.set ("assets/gfx/arrow.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/attention.png", "assets/gfx/attention.png");
		type.set ("assets/gfx/attention.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/beggar.png", "assets/gfx/beggar.png");
		type.set ("assets/gfx/beggar.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/bunny.png", "assets/gfx/bunny.png");
		type.set ("assets/gfx/bunny.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/campfire.png", "assets/gfx/campfire.png");
		type.set ("assets/gfx/campfire.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/castle.png", "assets/gfx/castle.png");
		type.set ("assets/gfx/castle.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/citizen.png", "assets/gfx/citizen.png");
		type.set ("assets/gfx/citizen.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/cobblestones.png", "assets/gfx/cobblestones.png");
		type.set ("assets/gfx/cobblestones.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/coin.png", "assets/gfx/coin.png");
		type.set ("assets/gfx/coin.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/coin_drop.png", "assets/gfx/coin_drop.png");
		type.set ("assets/gfx/coin_drop.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/dust.png", "assets/gfx/dust.png");
		type.set ("assets/gfx/dust.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/farmer.png", "assets/gfx/farmer.png");
		type.set ("assets/gfx/farmer.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/farmland.png", "assets/gfx/farmland.png");
		type.set ("assets/gfx/farmland.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/firefly.png", "assets/gfx/firefly.png");
		type.set ("assets/gfx/firefly.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/fog.png", "assets/gfx/fog.png");
		type.set ("assets/gfx/fog.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/hill.png", "assets/gfx/hill.png");
		type.set ("assets/gfx/hill.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/hunter.png", "assets/gfx/hunter.png");
		type.set ("assets/gfx/hunter.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/king.png", "assets/gfx/king.png");
		type.set ("assets/gfx/king.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/light.png", "assets/gfx/light.png");
		type.set ("assets/gfx/light.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/light_large.gif", "assets/gfx/light_large.gif");
		type.set ("assets/gfx/light_large.gif", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/light_large.png", "assets/gfx/light_large.png");
		type.set ("assets/gfx/light_large.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/light_mid.gif", "assets/gfx/light_mid.gif");
		type.set ("assets/gfx/light_mid.gif", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/light_mid.png", "assets/gfx/light_mid.png");
		type.set ("assets/gfx/light_mid.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/light_reflect_small.png", "assets/gfx/light_reflect_small.png");
		type.set ("assets/gfx/light_reflect_small.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/light_reflect_wide.png", "assets/gfx/light_reflect_wide.png");
		type.set ("assets/gfx/light_reflect_wide.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/light_small.gif", "assets/gfx/light_small.gif");
		type.set ("assets/gfx/light_small.gif", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/light_small.png", "assets/gfx/light_small.png");
		type.set ("assets/gfx/light_small.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/outline_noio.png", "assets/gfx/outline_noio.png");
		type.set ("assets/gfx/outline_noio.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/outline_pez.png", "assets/gfx/outline_pez.png");
		type.set ("assets/gfx/outline_pez.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/pier.png", "assets/gfx/pier.png");
		type.set ("assets/gfx/pier.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/reed.png", "assets/gfx/reed.png");
		type.set ("assets/gfx/reed.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/sack.png", "assets/gfx/sack.png");
		type.set ("assets/gfx/sack.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/scaffold.png", "assets/gfx/scaffold.png");
		type.set ("assets/gfx/scaffold.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/shop.png", "assets/gfx/shop.png");
		type.set ("assets/gfx/shop.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/skyline_hills.png", "assets/gfx/skyline_hills.png");
		type.set ("assets/gfx/skyline_hills.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/skyline_trees.png", "assets/gfx/skyline_trees.png");
		type.set ("assets/gfx/skyline_trees.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/sparkle.png", "assets/gfx/sparkle.png");
		type.set ("assets/gfx/sparkle.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/splash.png", "assets/gfx/splash.png");
		type.set ("assets/gfx/splash.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/sunmoon.png", "assets/gfx/sunmoon.png");
		type.set ("assets/gfx/sunmoon.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/tiles.png", "assets/gfx/tiles.png");
		type.set ("assets/gfx/tiles.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/title.png", "assets/gfx/title.png");
		type.set ("assets/gfx/title.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/torch.png", "assets/gfx/torch.png");
		type.set ("assets/gfx/torch.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/treeline.png", "assets/gfx/treeline.png");
		type.set ("assets/gfx/treeline.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/tree_dead.png", "assets/gfx/tree_dead.png");
		type.set ("assets/gfx/tree_dead.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/troll.png", "assets/gfx/troll.png");
		type.set ("assets/gfx/troll.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/trollbig.png", "assets/gfx/trollbig.png");
		type.set ("assets/gfx/trollbig.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/gfx/wall.png", "assets/gfx/wall.png");
		type.set ("assets/gfx/wall.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("assets/HaxeFlixel.svg", "assets/HaxeFlixel.svg");
		type.set ("assets/HaxeFlixel.svg", Reflect.field (AssetType, "text".toUpperCase ()));
		path.set ("assets/images/images-go-here.txt", "assets/images/images-go-here.txt");
		type.set ("assets/images/images-go-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
		path.set ("assets/levels/fields.oel", "assets/levels/fields.oel");
		type.set ("assets/levels/fields.oel", Reflect.field (AssetType, "binary".toUpperCase ()));
		path.set ("assets/levels/fields_alt.oel", "assets/levels/fields_alt.oel");
		type.set ("assets/levels/fields_alt.oel", Reflect.field (AssetType, "binary".toUpperCase ()));
		path.set ("assets/levels/fields_loose.oel", "assets/levels/fields_loose.oel");
		type.set ("assets/levels/fields_loose.oel", Reflect.field (AssetType, "binary".toUpperCase ()));
		path.set ("assets/levels/fields_old.oel", "assets/levels/fields_old.oel");
		type.set ("assets/levels/fields_old.oel", Reflect.field (AssetType, "binary".toUpperCase ()));
		path.set ("assets/music/day1.mp3", "assets/music/day1.mp3");
		type.set ("assets/music/day1.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		path.set ("assets/music/day1.wav", "assets/music/day1.wav");
		type.set ("assets/music/day1.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		path.set ("assets/music/day2.mp3", "assets/music/day2.mp3");
		type.set ("assets/music/day2.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		path.set ("assets/music/day2.wav", "assets/music/day2.wav");
		type.set ("assets/music/day2.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		path.set ("assets/music/day3.mp3", "assets/music/day3.mp3");
		type.set ("assets/music/day3.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		path.set ("assets/music/day3.wav", "assets/music/day3.wav");
		type.set ("assets/music/day3.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		path.set ("assets/music/day4.mp3", "assets/music/day4.mp3");
		type.set ("assets/music/day4.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		path.set ("assets/music/day4.wav", "assets/music/day4.wav");
		type.set ("assets/music/day4.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		path.set ("assets/music/day5.mp3", "assets/music/day5.mp3");
		type.set ("assets/music/day5.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		path.set ("assets/music/day5.wav", "assets/music/day5.wav");
		type.set ("assets/music/day5.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		path.set ("assets/music/music-goes-here.txt", "assets/music/music-goes-here.txt");
		type.set ("assets/music/music-goes-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
		path.set ("assets/music/night1.mp3", "assets/music/night1.mp3");
		type.set ("assets/music/night1.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		path.set ("assets/music/night1.wav", "assets/music/night1.wav");
		type.set ("assets/music/night1.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		path.set ("assets/music/night2.mp3", "assets/music/night2.mp3");
		type.set ("assets/music/night2.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		path.set ("assets/music/night2.wav", "assets/music/night2.wav");
		type.set ("assets/music/night2.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		path.set ("assets/music/night3.mp3", "assets/music/night3.mp3");
		type.set ("assets/music/night3.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		path.set ("assets/music/night3.wav", "assets/music/night3.wav");
		type.set ("assets/music/night3.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		path.set ("assets/music/night4.mp3", "assets/music/night4.mp3");
		type.set ("assets/music/night4.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		path.set ("assets/music/night4.wav", "assets/music/night4.wav");
		type.set ("assets/music/night4.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		path.set ("assets/music/night5.mp3", "assets/music/night5.mp3");
		type.set ("assets/music/night5.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		path.set ("assets/music/night5.wav", "assets/music/night5.wav");
		type.set ("assets/music/night5.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		path.set ("assets/sound/birds.mp3", "assets/sound/birds.mp3");
		type.set ("assets/sound/birds.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		path.set ("assets/sound/birds.wav", "assets/sound/birds.wav");
		type.set ("assets/sound/birds.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		path.set ("assets/sound/build.bfxrsound", "assets/sound/build.bfxrsound");
		type.set ("assets/sound/build.bfxrsound", Reflect.field (AssetType, "binary".toUpperCase ()));
		path.set ("assets/sound/build.mp3", "assets/sound/build.mp3");
		type.set ("assets/sound/build.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		path.set ("assets/sound/build.wav", "assets/sound/build.wav");
		type.set ("assets/sound/build.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		path.set ("assets/sound/cicada.aiff", "assets/sound/cicada.aiff");
		type.set ("assets/sound/cicada.aiff", Reflect.field (AssetType, "binary".toUpperCase ()));
		path.set ("assets/sound/cicada.mp3", "assets/sound/cicada.mp3");
		type.set ("assets/sound/cicada.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		path.set ("assets/sound/cicada.wav", "assets/sound/cicada.wav");
		type.set ("assets/sound/cicada.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		path.set ("assets/sound/hit.bfxrsound", "assets/sound/hit.bfxrsound");
		type.set ("assets/sound/hit.bfxrsound", Reflect.field (AssetType, "binary".toUpperCase ()));
		path.set ("assets/sound/hit.mp3", "assets/sound/hit.mp3");
		type.set ("assets/sound/hit.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		path.set ("assets/sound/hit.wav", "assets/sound/hit.wav");
		type.set ("assets/sound/hit.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		path.set ("assets/sound/hitbig.bfxrsound", "assets/sound/hitbig.bfxrsound");
		type.set ("assets/sound/hitbig.bfxrsound", Reflect.field (AssetType, "binary".toUpperCase ()));
		path.set ("assets/sound/hitbig.mp3", "assets/sound/hitbig.mp3");
		type.set ("assets/sound/hitbig.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		path.set ("assets/sound/hitbig.wav", "assets/sound/hitbig.wav");
		type.set ("assets/sound/hitbig.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		path.set ("assets/sound/hitcitizen.bfxrsound", "assets/sound/hitcitizen.bfxrsound");
		type.set ("assets/sound/hitcitizen.bfxrsound", Reflect.field (AssetType, "binary".toUpperCase ()));
		path.set ("assets/sound/hitcitizen.mp3", "assets/sound/hitcitizen.mp3");
		type.set ("assets/sound/hitcitizen.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		path.set ("assets/sound/hitcitizen.wav", "assets/sound/hitcitizen.wav");
		type.set ("assets/sound/hitcitizen.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		path.set ("assets/sound/hitwall.bfxrsound", "assets/sound/hitwall.bfxrsound");
		type.set ("assets/sound/hitwall.bfxrsound", Reflect.field (AssetType, "binary".toUpperCase ()));
		path.set ("assets/sound/hitwall.mp3", "assets/sound/hitwall.mp3");
		type.set ("assets/sound/hitwall.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		path.set ("assets/sound/hitwall.wav", "assets/sound/hitwall.wav");
		type.set ("assets/sound/hitwall.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		path.set ("assets/sound/owls.mp3", "assets/sound/owls.mp3");
		type.set ("assets/sound/owls.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		path.set ("assets/sound/owls.wav", "assets/sound/owls.wav");
		type.set ("assets/sound/owls.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		path.set ("assets/sound/pickup.bfxrsound", "assets/sound/pickup.bfxrsound");
		type.set ("assets/sound/pickup.bfxrsound", Reflect.field (AssetType, "binary".toUpperCase ()));
		path.set ("assets/sound/pickup.mp3", "assets/sound/pickup.mp3");
		type.set ("assets/sound/pickup.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		path.set ("assets/sound/pickup.wav", "assets/sound/pickup.wav");
		type.set ("assets/sound/pickup.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		path.set ("assets/sound/powerup.bfxrsound", "assets/sound/powerup.bfxrsound");
		type.set ("assets/sound/powerup.bfxrsound", Reflect.field (AssetType, "binary".toUpperCase ()));
		path.set ("assets/sound/powerup.mp3", "assets/sound/powerup.mp3");
		type.set ("assets/sound/powerup.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		path.set ("assets/sound/powerup.wav", "assets/sound/powerup.wav");
		type.set ("assets/sound/powerup.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		path.set ("assets/sound/shoot.mp3", "assets/sound/shoot.mp3");
		type.set ("assets/sound/shoot.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		path.set ("assets/sound/shoot.wav", "assets/sound/shoot.wav");
		type.set ("assets/sound/shoot.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		path.set ("assets/sound/stolen.bfxrsound", "assets/sound/stolen.bfxrsound");
		type.set ("assets/sound/stolen.bfxrsound", Reflect.field (AssetType, "binary".toUpperCase ()));
		path.set ("assets/sound/stolen.mp3", "assets/sound/stolen.mp3");
		type.set ("assets/sound/stolen.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		path.set ("assets/sound/stolen.wav", "assets/sound/stolen.wav");
		type.set ("assets/sound/stolen.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		path.set ("assets/sound/throw.bfxrsound", "assets/sound/throw.bfxrsound");
		type.set ("assets/sound/throw.bfxrsound", Reflect.field (AssetType, "binary".toUpperCase ()));
		path.set ("assets/sound/throw.mp3", "assets/sound/throw.mp3");
		type.set ("assets/sound/throw.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		path.set ("assets/sound/throw.wav", "assets/sound/throw.wav");
		type.set ("assets/sound/throw.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		path.set ("assets/sounds/sounds-go-here.txt", "assets/sounds/sounds-go-here.txt");
		type.set ("assets/sounds/sounds-go-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
		path.set ("flixel/img/debugger/buttons/console.png", "flixel/img/debugger/buttons/console.png");
		type.set ("flixel/img/debugger/buttons/console.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/debugger/buttons/logDebug.png", "flixel/img/debugger/buttons/logDebug.png");
		type.set ("flixel/img/debugger/buttons/logDebug.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/debugger/buttons/open.png", "flixel/img/debugger/buttons/open.png");
		type.set ("flixel/img/debugger/buttons/open.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/debugger/buttons/pause.png", "flixel/img/debugger/buttons/pause.png");
		type.set ("flixel/img/debugger/buttons/pause.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/debugger/buttons/play.png", "flixel/img/debugger/buttons/play.png");
		type.set ("flixel/img/debugger/buttons/play.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/debugger/buttons/record_off.png", "flixel/img/debugger/buttons/record_off.png");
		type.set ("flixel/img/debugger/buttons/record_off.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/debugger/buttons/record_on.png", "flixel/img/debugger/buttons/record_on.png");
		type.set ("flixel/img/debugger/buttons/record_on.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/debugger/buttons/restart.png", "flixel/img/debugger/buttons/restart.png");
		type.set ("flixel/img/debugger/buttons/restart.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/debugger/buttons/statsDebug.png", "flixel/img/debugger/buttons/statsDebug.png");
		type.set ("flixel/img/debugger/buttons/statsDebug.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/debugger/buttons/step.png", "flixel/img/debugger/buttons/step.png");
		type.set ("flixel/img/debugger/buttons/step.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/debugger/buttons/stop.png", "flixel/img/debugger/buttons/stop.png");
		type.set ("flixel/img/debugger/buttons/stop.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/debugger/buttons/visualDebug.png", "flixel/img/debugger/buttons/visualDebug.png");
		type.set ("flixel/img/debugger/buttons/visualDebug.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/debugger/buttons/watchDebug.png", "flixel/img/debugger/buttons/watchDebug.png");
		type.set ("flixel/img/debugger/buttons/watchDebug.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/debugger/flixel.png", "flixel/img/debugger/flixel.png");
		type.set ("flixel/img/debugger/flixel.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/debugger/windowHandle.png", "flixel/img/debugger/windowHandle.png");
		type.set ("flixel/img/debugger/windowHandle.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/logo/default.png", "flixel/img/logo/default.png");
		type.set ("flixel/img/logo/default.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/logo/HaxeFlixel.svg", "flixel/img/logo/HaxeFlixel.svg");
		type.set ("flixel/img/logo/HaxeFlixel.svg", Reflect.field (AssetType, "text".toUpperCase ()));
		path.set ("flixel/img/logo/logo.png", "flixel/img/logo/logo.png");
		type.set ("flixel/img/logo/logo.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/preloader/corners.png", "flixel/img/preloader/corners.png");
		type.set ("flixel/img/preloader/corners.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/preloader/light.png", "flixel/img/preloader/light.png");
		type.set ("flixel/img/preloader/light.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/tile/autotiles.png", "flixel/img/tile/autotiles.png");
		type.set ("flixel/img/tile/autotiles.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/tile/autotiles_alt.png", "flixel/img/tile/autotiles_alt.png");
		type.set ("flixel/img/tile/autotiles_alt.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/ui/analog/base.png", "flixel/img/ui/analog/base.png");
		type.set ("flixel/img/ui/analog/base.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/ui/analog/thumb.png", "flixel/img/ui/analog/thumb.png");
		type.set ("flixel/img/ui/analog/thumb.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/ui/button.png", "flixel/img/ui/button.png");
		type.set ("flixel/img/ui/button.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/ui/cursor.png", "flixel/img/ui/cursor.png");
		type.set ("flixel/img/ui/cursor.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/ui/fontData11pt.png", "flixel/img/ui/fontData11pt.png");
		type.set ("flixel/img/ui/fontData11pt.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/ui/virtualpad/a.png", "flixel/img/ui/virtualpad/a.png");
		type.set ("flixel/img/ui/virtualpad/a.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/ui/virtualpad/b.png", "flixel/img/ui/virtualpad/b.png");
		type.set ("flixel/img/ui/virtualpad/b.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/ui/virtualpad/c.png", "flixel/img/ui/virtualpad/c.png");
		type.set ("flixel/img/ui/virtualpad/c.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/ui/virtualpad/down.png", "flixel/img/ui/virtualpad/down.png");
		type.set ("flixel/img/ui/virtualpad/down.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/ui/virtualpad/left.png", "flixel/img/ui/virtualpad/left.png");
		type.set ("flixel/img/ui/virtualpad/left.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/ui/virtualpad/right.png", "flixel/img/ui/virtualpad/right.png");
		type.set ("flixel/img/ui/virtualpad/right.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/ui/virtualpad/up.png", "flixel/img/ui/virtualpad/up.png");
		type.set ("flixel/img/ui/virtualpad/up.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/ui/virtualpad/x.png", "flixel/img/ui/virtualpad/x.png");
		type.set ("flixel/img/ui/virtualpad/x.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/img/ui/virtualpad/y.png", "flixel/img/ui/virtualpad/y.png");
		type.set ("flixel/img/ui/virtualpad/y.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("flixel/snd/beep.wav", "flixel/snd/beep.wav");
		type.set ("flixel/snd/beep.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		path.set ("flixel/snd/flixel.wav", "flixel/snd/flixel.wav");
		type.set ("flixel/snd/flixel.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		
		
		#else
		
		try {
			
			var bytes = ByteArray.readFile ("manifest");
			bytes.position = 0;
			
			if (bytes.length > 0) {
				
				var data = bytes.readUTFBytes (bytes.length);
				
				if (data != null && data.length > 0) {
					
					var manifest:Array<AssetData> = Unserializer.run (data);
					
					for (asset in manifest) {
						
						path.set (asset.id, asset.path);
						type.set (asset.id, asset.type);
						
					}
					
				}
				
			}
			
		} catch (e:Dynamic) {
			
			trace ("Warning: Could not load asset manifest");
			
		}
		
		#end
		
	}
	
	
	public override function exists (id:String, type:AssetType):Bool {
		
		var assetType = DefaultAssetLibrary.type.get (id);
		
		#if pixi
		
		if (assetType == IMAGE) {
			
			return true;
			
		} else {
			
			return false;
			
		}
		
		#end
		
		if (assetType != null) {
			
			if (assetType == type || type == SOUND && (assetType == MUSIC || assetType == SOUND)) {
				
				return true;
				
			}
			
			#if flash
			
			if ((assetType == BINARY || assetType == TEXT) && type == BINARY) {
				
				return true;
				
			} else if (path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (type == BINARY || type == null) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getBitmapData (id:String):BitmapData {
		
		#if pixi
		
		return BitmapData.fromImage (path.get (id));
		
		#elseif flash
		
		return cast (Type.createInstance (className.get (id), []), BitmapData);
		
		#elseif js
		
		return cast (ApplicationMain.loaders.get (path.get (id)).contentLoaderInfo.content, Bitmap).bitmapData;
		
		#else
		
		return BitmapData.load (path.get (id));
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if pixi
		
		return null;
		
		#elseif flash
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);
		
		#elseif js
		
		var bytes:ByteArray = null;
		var data = ApplicationMain.urlLoaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			bytes = new ByteArray ();
			bytes.writeUTFBytes (data);
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}

		if (bytes != null) {
			
			bytes.position = 0;
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Font {
		
		#if pixi
		
		return null;
		
		#elseif (flash || js)
		
		return cast (Type.createInstance (className.get (id), []), Font);
		
		#else
		
		return new Font (path.get (id));
		
		#end
		
	}
	
	
	public override function getPath (id:String):String {
		
		#if ios
		
		return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		#else
		
		return path.get (id);
		
		#end
		
	}
	
	
	public override function getSound (id:String):Sound {
		
		#if pixi
		
		return null;
		
		#elseif flash
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return new Sound (new URLRequest (path.get (id)), null, type.get (id) == MUSIC);
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:AssetType):Bool {
		
		#if flash
		
		if (type != AssetType.MUSIC && type != AssetType.SOUND) {
			
			return className.exists (id);
			
		}
		
		#end
		
		return true;
		
	}
	
	
	public override function loadBitmapData (id:String, handler:BitmapData -> Void):Void {
		
		#if pixi
		
		handler (getBitmapData (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBitmapData (id));
			
		}
		
		#else
		
		handler (getBitmapData (id));
		
		#end
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		#if pixi
		
		handler (getBytes (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = new ByteArray ();
				bytes.writeUTFBytes (event.currentTarget.data);
				bytes.position = 0;
				
				handler (bytes);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBytes (id));
			
		}
		
		#else
		
		handler (getBytes (id));
		
		#end
		
	}
	
	
	public override function loadFont (id:String, handler:Font -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getFont (id));
			
		//}
		
		#else
		
		handler (getFont (id));
		
		#end
		
	}
	
	
	public override function loadSound (id:String, handler:Sound -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getSound (id));
			
		//}
		
		#else
		
		handler (getSound (id));
		
		#end
		
	}
	
	
}


#if pixi
#elseif flash

class __ASSET__assets_04b03_ttf extends null { }
class __ASSET__assets_aurora_ttf extends null { }
class __ASSET__assets_data_data_goes_here_txt extends null { }
class __ASSET__assets_gfx_arrow_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_attention_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_beggar_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_bunny_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_campfire_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_castle_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_citizen_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_cobblestones_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_coin_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_coin_drop_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_dust_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_farmer_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_farmland_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_firefly_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_fog_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_hill_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_hunter_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_king_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_light_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_light_large_gif extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_light_large_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_light_mid_gif extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_light_mid_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_light_reflect_small_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_light_reflect_wide_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_light_small_gif extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_light_small_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_outline_noio_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_outline_pez_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_pier_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_reed_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_sack_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_scaffold_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_shop_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_skyline_hills_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_skyline_trees_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_sparkle_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_splash_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_sunmoon_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_tiles_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_title_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_torch_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_treeline_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_tree_dead_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_troll_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_trollbig_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_gfx_wall_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__assets_haxeflixel_svg extends null { }
class __ASSET__assets_images_images_go_here_txt extends null { }
class __ASSET__assets_levels_fields_oel extends null { }
class __ASSET__assets_levels_fields_alt_oel extends null { }
class __ASSET__assets_levels_fields_loose_oel extends null { }
class __ASSET__assets_levels_fields_old_oel extends null { }
class __ASSET__assets_music_day1_mp3 extends null { }
class __ASSET__assets_music_day1_wav extends null { }
class __ASSET__assets_music_day2_mp3 extends null { }
class __ASSET__assets_music_day2_wav extends null { }
class __ASSET__assets_music_day3_mp3 extends null { }
class __ASSET__assets_music_day3_wav extends null { }
class __ASSET__assets_music_day4_mp3 extends null { }
class __ASSET__assets_music_day4_wav extends null { }
class __ASSET__assets_music_day5_mp3 extends null { }
class __ASSET__assets_music_day5_wav extends null { }
class __ASSET__assets_music_music_goes_here_txt extends null { }
class __ASSET__assets_music_night1_mp3 extends null { }
class __ASSET__assets_music_night1_wav extends null { }
class __ASSET__assets_music_night2_mp3 extends null { }
class __ASSET__assets_music_night2_wav extends null { }
class __ASSET__assets_music_night3_mp3 extends null { }
class __ASSET__assets_music_night3_wav extends null { }
class __ASSET__assets_music_night4_mp3 extends null { }
class __ASSET__assets_music_night4_wav extends null { }
class __ASSET__assets_music_night5_mp3 extends null { }
class __ASSET__assets_music_night5_wav extends null { }
class __ASSET__assets_sound_birds_mp3 extends null { }
class __ASSET__assets_sound_birds_wav extends null { }
class __ASSET__assets_sound_build_bfxrsound extends null { }
class __ASSET__assets_sound_build_mp3 extends null { }
class __ASSET__assets_sound_build_wav extends null { }
class __ASSET__assets_sound_cicada_aiff extends null { }
class __ASSET__assets_sound_cicada_mp3 extends null { }
class __ASSET__assets_sound_cicada_wav extends null { }
class __ASSET__assets_sound_hit_bfxrsound extends null { }
class __ASSET__assets_sound_hit_mp3 extends null { }
class __ASSET__assets_sound_hit_wav extends null { }
class __ASSET__assets_sound_hitbig_bfxrsound extends null { }
class __ASSET__assets_sound_hitbig_mp3 extends null { }
class __ASSET__assets_sound_hitbig_wav extends null { }
class __ASSET__assets_sound_hitcitizen_bfxrsound extends null { }
class __ASSET__assets_sound_hitcitizen_mp3 extends null { }
class __ASSET__assets_sound_hitcitizen_wav extends null { }
class __ASSET__assets_sound_hitwall_bfxrsound extends null { }
class __ASSET__assets_sound_hitwall_mp3 extends null { }
class __ASSET__assets_sound_hitwall_wav extends null { }
class __ASSET__assets_sound_owls_mp3 extends null { }
class __ASSET__assets_sound_owls_wav extends null { }
class __ASSET__assets_sound_pickup_bfxrsound extends null { }
class __ASSET__assets_sound_pickup_mp3 extends null { }
class __ASSET__assets_sound_pickup_wav extends null { }
class __ASSET__assets_sound_powerup_bfxrsound extends null { }
class __ASSET__assets_sound_powerup_mp3 extends null { }
class __ASSET__assets_sound_powerup_wav extends null { }
class __ASSET__assets_sound_shoot_mp3 extends null { }
class __ASSET__assets_sound_shoot_wav extends null { }
class __ASSET__assets_sound_stolen_bfxrsound extends null { }
class __ASSET__assets_sound_stolen_mp3 extends null { }
class __ASSET__assets_sound_stolen_wav extends null { }
class __ASSET__assets_sound_throw_bfxrsound extends null { }
class __ASSET__assets_sound_throw_mp3 extends null { }
class __ASSET__assets_sound_throw_wav extends null { }
class __ASSET__assets_sounds_sounds_go_here_txt extends null { }
class __ASSET__flixel_img_debugger_buttons_console_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_debugger_buttons_logdebug_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_debugger_buttons_open_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_debugger_buttons_pause_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_debugger_buttons_play_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_debugger_buttons_record_off_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_debugger_buttons_record_on_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_debugger_buttons_restart_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_debugger_buttons_statsdebug_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_debugger_buttons_step_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_debugger_buttons_stop_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_debugger_buttons_visualdebug_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_debugger_buttons_watchdebug_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_debugger_flixel_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_debugger_windowhandle_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_logo_haxeflixel_svg extends null { }
class __ASSET__flixel_img_logo_logo_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_preloader_corners_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_preloader_light_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_tile_autotiles_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_tile_autotiles_alt_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_ui_analog_base_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_ui_analog_thumb_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_ui_cursor_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_ui_fontdata11pt_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_ui_virtualpad_a_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_ui_virtualpad_b_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_ui_virtualpad_c_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_ui_virtualpad_down_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_ui_virtualpad_left_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_ui_virtualpad_right_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_ui_virtualpad_up_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_ui_virtualpad_x_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_img_ui_virtualpad_y_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__flixel_snd_beep_wav extends null { }
class __ASSET__flixel_snd_flixel_wav extends null { }


#elseif html5

class __ASSET__assets_04b03_ttf extends flash.text.Font { }
class __ASSET__assets_aurora_ttf extends flash.text.Font { }
























































































































































#end