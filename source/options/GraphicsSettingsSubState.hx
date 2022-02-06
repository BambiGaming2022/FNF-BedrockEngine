package options;

#if desktop
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

using StringTools;

class GraphicsSettingsSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Graphics';
		rpcTitle = 'Tweaking the Graphics'; //for Discord Rich Presence

		var option:Option = new Option('Anti-Aliasing', 'If unchecked, disables anti-aliasing, increases performance\nat the cost of sharper visuals.', 'globalAntialiasing', 'bool', true);
		//option.showBoyfriend = true;
		option.onChange = onChangeAntiAliasing; //Changing onChange is only needed if you want to make a special interaction after it changes the value
		addOption(option);
		//need to rewrite showBoyfriend to avoid crash maybe

		var option:Option = new Option('Auto Pause',
		"Whether or not to pause the game automatically when the window is unfocused",
		'autoPause',
		'bool',
		true);
		option.onChange = onChangeAutoPause;
		addOption(option);

		#if !mobile
		var option:Option = new Option('FPS Counter',
		"Whether to display the FPS Counter.",
		'showFPS',
		'bool',
		true);
		addOption(option);
		option.onChange = onChangeFPSCounter;
		#end

		#if !html5 //Apparently other framerates isn't correctly supported on Browser? Probably it has some V-Sync shit enabled by default, idk
		var option:Option = new Option('FPS Cap',
		"Define your maximum FPS.",
		'framerate',
		'int',
		60);
		addOption(option);

		option.minValue = 60;
		option.maxValue = 240;
		option.displayFormat = '%v FPS';
		option.onChange = onChangeFramerate;	
		#end

		var option:Option = new Option('Hide Girlfriend',
		"Whether to Hide or Show Girlfriend on Stages, this does not apply if GF is the opponent",
		'hideGf',
		'bool',
		false);
		addOption(option);

		//I'd suggest using "Low Quality" as an example for making your own option since it is the simplest here
		var option:Option = new Option('Low Quality', //Name
		'If checked, disables some background details,\ndecreases loading times and improves performance.', //Description
		'lowQuality', //Save data variable name
		'bool', //Variable type
		false); //Default value
		addOption(option);

		var option:Option = new Option('Max Optimization',
		'If checked, disables backgrounds, characters, and anything related to those in order to increase performance, this does not apply for Mods, or any HUD elements (such as Icons and Note Splashes).',
		'maxOptimization',
		'bool',
		false);
		addOption(option);

		var option:Option = new Option('Memory Counter',
		"Whether to display approximately how much memory is being used, and the peak of that Memory.",
		'memCounter',
		'bool',
		false);
		addOption(option);

		super();
	}

	function onChangeAutoPause()
	{
		FlxG.autoPause = ClientPrefs.autoPause;
	}

	#if !mobile
	function onChangeFPSCounter()
	{
		if(Main.fpsVar != null)
			Main.fpsVar.visible = ClientPrefs.showFPS;
	}
	#end

	function onChangeFramerate()
	{
		if(ClientPrefs.framerate > FlxG.drawFramerate)
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

	function onChangeAntiAliasing()
	{
		for (sprite in members)
		{
			var sprite:Dynamic = sprite; //Make it check for FlxSprite instead of FlxBasic
			var sprite:FlxSprite = sprite; //Don't judge me ok
			if(sprite != null && (sprite is FlxSprite) && !(sprite is FlxText)) {
				sprite.antialiasing = ClientPrefs.globalAntialiasing;
			}
		}
	}
}