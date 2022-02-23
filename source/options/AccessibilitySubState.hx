package options;

import meta.data.ClientPrefs;
#if desktop
import meta.data.Discord.DiscordClient;
#end
import flash.text.TextField;
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

using StringTools;

class AccessibilitySubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Accessibility';
		rpcTitle = 'in the Accessibility Settings'; // for Discord Rich Presence

		var option:Option = new Option('Anti-Aliasing', 'If unchecked, disables anti-aliasing, increases performance\nat the cost of sharper visuals.',
			'globalAntialiasing', 'bool', true);
		option.showBoyfriend = true;
		option.onChange = onChangeAntiAliasing; // Changing onChange is only needed if you want to make a special interaction after it changes the value
		addOption(option);

		var option:Option = new Option('Filter:', "Choose a filter for colorblindness.", 'curFilter', 'string', 'None',
			['Deuteranopia', 'Protanopia', 'Tritanopia', 'None']);
		addOption(option);

		var option:Option = new Option('Background Opacity:', 'How much opaque the background should be?', 'bgAlpha', 'float', true);
		option.displayFormat = '%v';
		option.scrollSpeed = 100;
		option.changeValue = 0.1;
		option.decimals = 1;
		option.minValue = 0;
		option.maxValue = 1;
		addOption(option);

		var option:Option = new Option('Health Bar Opacity', 'How much opaque should the health bar and icons be.', 'healthBarAlpha', 'percent', 1);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		addOption(option);

		var option:Option = new Option('Lane Opacity', "How much opaque should your Lane Underlay be.", 'underlay', 'float', true);
		option.displayFormat = '%v';
		option.scrollSpeed = 100;
		option.changeValue = 0.1;
		option.decimals = 1;
		option.minValue = 0;
		option.maxValue = 1;
		addOption(option);

		var option:Option = new Option('Strumline Opacity', "How much opaque should your Notes' Strumline be?.", 'strumLineAlpha', 'percent', 1);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		// addOption(option);

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
}
