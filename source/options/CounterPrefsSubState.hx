package options;

#if desktop
import Discord.DiscordClient;
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
import Controls;

using StringTools;

class CounterPrefsSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Counter Preferences';
		rpcTitle = 'In the Menus\nCounter Preferences'; //for Discord Rich Presence

		var option:Option = new Option('Show Highest Combo', "If checked, will show your Highest Combo in a Song.",
			'showtotalCombo', 'bool', true);
		addOption(option);

		var option:Option = new Option('Show Combo', "If checked, will show your Current Combo in a Song.",
			'showCombo', 'bool', true);
		addOption(option);

		var option:Option = new Option('Show Sick!', 'If checked, will show how many Sick! Ratings you have in a Song.',
			'showSick', 'bool', true);
		addOption(option);

		var option:Option = new Option('Show Good', 'If checked, will show how many Good Ratings you have in a Song.',
			'showGood', 'bool', true);
		addOption(option);

		var option:Option = new Option('Show Bad', 'If checked, will show how many Bad Ratings you have in a Song.',
			'showBad', 'bool', true);
		addOption(option);

		var option:Option = new Option('Show Shit', 'If checked, will show how many Shit Ratings you have in a Song.',
			'showShit', 'bool', true);
		addOption(option);

		var option:Option = new Option('Show Combo Breaks', 'If checked, will show how many Combo Breaks you have in a Song.',
			'showComboBreaks', 'bool', true);
		addOption(option);

		super();
	}
}