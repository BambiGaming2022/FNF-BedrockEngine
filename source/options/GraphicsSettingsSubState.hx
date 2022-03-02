package options;

#if DISCORD_ALLOWED
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;
import openfl.Lib;
import openfl.filters.ColorMatrixFilter;
import openfl.filters.BitmapFilter;

using StringTools;

class GraphicsSettingsSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Graphics';
		rpcTitle = 'Graphics Settings Menu'; // for Discord Rich Presence

		// I'd suggest using "Low Quality" as an example for making your own option since it is the simplest here
		var option:Option = new Option('Low Quality',
			'If checked, disables some background details,\ndecreases loading times and improves performance.', // Name and Description
			'lowQuality', 'bool',
			false); // Save Data Variable Name on ClientPrefs, Variable Type and Default value
		addOption(option);

		var option:Option = new Option('Anti-Aliasing', 'If unchecked, disables anti-aliasing, increases performance\nat the cost of sharper visuals.',
			'globalAntialiasing', 'bool', true);
		// option.showBoyfriend = true;
		option.onChange = onChangeAntiAliasing; // Changing onChange is only needed if you want to make a special interaction after it changes the value
		addOption(option);

		#if !html5 // Apparently other framerates isn't correctly supported on Browser? Probably it has some V-Sync shit enabled by default, idk
		var option:Option = new Option('Framerate', "Pretty self explanatory, isn't it?", 'framerate', 'int', 60);
		addOption(option);

		option.minValue = 60;
		option.maxValue = 240;
		option.displayFormat = '%v FPS';
		option.onChange = onChangeFramerate;
		#end

		var option:Option = new Option('Background Opacity', 'How opaque should the characters and the background be.', 'bgOpacity', 'float', 0);
		option.minValue = 0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		addOption(option);

		#if desktop // only desktop can use these shits
		var option:Option = new Option('Screen Resolution', 'Select your preferred screen resolution.\n(Goes from 240p to 8K)', 'screenRes', 'string',
			'1280x720', ['426x240', '640x360', '854x480', '1280x720', '1920x1080', '3840x2160', '7680x4320']);
		addOption(option);
		option.onChange = onChangeScreenRes;

		var option:Option = new Option('Filter:', "Choose a filter for colorblindness.", 'colorFilter', 'string', 'None',
			['Deuteranopia', 'Protanopia', 'Tritanopia', 'None']);
		option.onChange = onChangeFilters;
		addOption(option);

		var option:Option = new Option('Fullscreen', 'This option will activate the Flixel\'s fullscreen.', 'fullscreen', 'bool', false);
		addOption(option);
		option.onChange = onChangeFullscreen;
		#end

		/*
			var option:Option = new Option('Persistent Cached Data',
				'If checked, images loaded will stay in memory\nuntil the game is closed, this increases memory usage,\nbut basically makes reloading times instant.',
				'imagesPersist',
				'bool',
				false);
			option.onChange = onChangePersistentData; //Persistent Cached Data changes FlxGraphic.defaultPersist
			addOption(option);
		 */

		super();
	}

	function onChangeAntiAliasing()
	{
		for (sprite in members)
		{
			var sprite:Dynamic = sprite; // Make it check for FlxSprite instead of FlxBasic
			var sprite:FlxSprite = sprite; // Don't judge me ok
			if (sprite != null && (sprite is FlxSprite) && !(sprite is FlxText))
			{
				sprite.antialiasing = ClientPrefs.globalAntialiasing;
			}
		}
	}

	function onChangeFullscreen() // i hate to make a 1 line function
	{
		FlxG.fullscreen;
	}

	function onChangeScreenRes()
	{
		var res = ClientPrefs.screenRes.split('x');

		FlxG.resizeWindow(Std.parseInt(res[0]), Std.parseInt(res[1]));
		FlxG.fullscreen = false;
		FlxG.fullscreen = ClientPrefs.fullscreen;
	}

	function onChangeFramerate()
	{
		if (ClientPrefs.framerate > FlxG.drawFramerate)
		{
			FlxG.updateFramerate = ClientPrefs.framerate;
			FlxG.drawFramerate = ClientPrefs.framerate;
		}
		else
		{
			FlxG.drawFramerate = ClientPrefs.framerate;
			FlxG.updateFramerate = ClientPrefs.framerate;
		}
	}

	public static function onChangeFilters() //got from a FNF PR, link: https://github.com/ninjamuffin99/Funkin/pull/567/
    {
        var matrix:Array<Float> = [];
        var filters:Array<BitmapFilter> = [];
        
        switch (ClientPrefs.colorFilter)
        {
            case 'None':
                matrix = [
                    1,    0,    0,   0,   0,
                    0,    1,    0,   0,   0,
                    0,    0,    1,   0,   0,
                    0,    0,    0,   1,   0,
                ];

            case 'Deuteranopia':
                matrix = [
                    0.43, 0.72, -.15, 0, 0,
                    0.34, 0.57, 0.09, 0, 0,
                    -.02, 0.03,    1, 0, 0,
                        0,    0,    0, 1, 0,
                ];

            case 'Protanopia':
                matrix = [
                    0.20, 0.99, -.19, 0, 0,
                    0.16, 0.79, 0.04, 0, 0,
                    0.01, -.01,    1, 0, 0,
                        0,    0,    0, 1, 0,
                ];

            case 'Tritanopia':
                matrix = [
                    0.97, 0.11, -.08, 0, 0,
                    0.02, 0.82, 0.16, 0, 0,
                    0.06, 0.88, 0.18, 0, 0,
                            0,    0,    0, 1, 0,
                ];
        }

        filters.push(new ColorMatrixFilter(matrix));
        FlxG.game.setFilters(filters);
    }
}
