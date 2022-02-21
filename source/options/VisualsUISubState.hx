package options;

import meta.data.Controls;
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

class VisualsUISubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Visuals and UI';
		rpcTitle = 'Tweaking the Visuals & UI'; // for Discord Rich Presence

		var option:Option = new Option('Camera Zooms', "If unchecked, the camera won't zoom in on a beat hit.",
			'camZooms', 'bool', true);
		addOption(option);

		var option:Option = new Option('Controller Mode', 'Check this if you want to play with\na controller instead of using your Keyboard.',
			'controllerMode', 'bool', false);
		 addOption(option);

		var option:Option = new Option('Flashing Lights', "Uncheck this if you're sensitive to flashing lights!",
			'flashing', 'bool', true);
		addOption(option);

		var option:Option = new Option('Hide HUD', 'If checked, hides most HUD elements.',
			'hideHud', 'bool', false);
		addOption(option);

		var option:Option = new Option('Disable Winning Icons', "If unchecked, disables the Winning Icons.",
			'iconSupport', 'bool', false);
		addOption(option);

		var option:Option = new Option('Hide Combo Sprite', "If checked, disables the Combo Sprite that appears once you have a 10 Combo Streak.",
			'comboSprite', 'bool', false);
		addOption(option);

		var option:Option = new Option('Judgement Counters', "If checked, will show Judgement Counters at the left side of the screen",
			'judgCounter', 'bool', true);
		addOption(option);

		/*var option:Option = new Option ('Mania Mode', 
				'If checked, it will turn FNF visual into osu!mania (or StepMania) visual.', 
				'maniaMode', 
				'bool', 
				false);
			addOption(option); */

		var option:Option = new Option('Note Splashes', "If unchecked, hitting \"Marvelous!\" or \"Sick!\" notes won't show particles.",
			'noteSplashes', 'bool', true);
		addOption(option);

		var option:Option = new Option('Score Text Zoom on Hit', "If unchecked, disables the Score text zooming\neverytime you hit a note.",
			'scoreZoom', 'bool', true);
		addOption(option);

		var option:Option = new Option('Show Watermarks', "If unchecked, hides engine watermarks from the bottom right corner of the screen",
			'showWatermarks', 'bool', true);
		addOption(option);

		var option:Option = new Option('Show Song Display', "If unchecked, hides song name and difficulty from the bottom left corner of the screen",
			'showSongDisplay', 'bool', true);
		addOption(option);

		var option:Option = new Option('Use Classic Songs', "If checked, will use the Classic Songs instead of Bedrock's songs.",
			'useClassicSongs', 'bool', true);
		addOption(option);

		var option:Option = new Option('Judgement Skin', "What should judgements skins be?", 'judgementSkin', 'string', 'Bedrock',
			["Bedrock", "Classic"]);
		addOption(option);

		var option:Option = new Option('Time Bar:', "What should the Time Bar display?", 'timeBarType', 'string', 'Time Left',
			['Time Left', 'Time Elapsed', 'Song Name', 'Disabled']);
		addOption(option);

		var option:Option = new Option('Time Bar Style:', "What should the Time Bar look like?", 'timeBarUi', 'string', 'Psych Engine',
			['Psych Engine', 'Kade Engine']);
		addOption(option);

		super();
	}
}
