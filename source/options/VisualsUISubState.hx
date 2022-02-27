package options;

#if DISCORD_ALLOWED
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

class VisualsUISubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Appearance'; //deep down, this is still just Visuals and UI
		rpcTitle = 'In the Menus\nAppearance'; //for Discord Rich Presence

		var option:Option = new Option('Camera Zooms', "If unchecked, the camera won't zoom in on a beat hit.",
			'camZooms', 'bool', true);
		addOption(option);

		var option:Option = new Option('Flashing Lights', "Uncheck this if you're sensitive to flashing lights!",
			'flashing', 'bool', true);
		addOption(option);

		#if !mobile
		var option:Option = new Option('FPS & Memory Counter', 'If unchecked, hides FPS & Memory Counters.',
			'showFPS', 'bool', true);
		addOption(option);
		option.onChange = onChangeFPSCounter;
		#end

		var option:Option = new Option('Hide Combo Sprite', "If checked, disables the Combo Sprite.",
			'comboSpr', 'bool', false);
		addOption(option);

		var option:Option = new Option('Hide HUD', 'If checked, hides most HUD elements.',
			'hideHud', 'bool', false);
		addOption(option);

		var option:Option = new Option('Hide Winning Icons', "If checked, will use the old icons and disable the winning icons\nthis may also fix broken icons for mods that don't use winning icons\nMake sure to put your Icons on the 'images/icons/old' folder",
			'oldIcons', 'bool', false);
		addOption(option);

		var option:Option = new Option('Note Splashes', "If unchecked, hitting \"Sick!\" notes won't show particles.",
			'noteSplashes', 'bool', true);
		addOption(option);

		var option:Option = new Option('Score Text Zoom on Hit', "If unchecked, disables the Score text zooming\neverytime you hit a note.",
			'scoreZoom', 'bool', true);
		addOption(option);

		var option:Option = new Option('Simply Judgements', "If checked, simplifies the judgement animations, displaying only one judgement / rating sprite at a time.",
			'simplyJudgements', 'bool', false);
		addOption(option);

		var option:Option = new Option('Show Watermarks', "If unchecked, hides engine watermarks from the bottom right corner of the screen",
			'showWatermarks', 'bool', true);
		addOption(option);

		var option:Option = new Option('Show Song Display', "If unchecked, hides song name and difficulty from the bottom left corner of the screen",
			'showSongDisplay', 'bool', true);
		addOption(option);
		
		var option:Option = new Option('Health Bar Opacity',
			'How much opaque should the health bar and icons be.',
			'healthBarAlpha',
			'percent',
			1);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		addOption(option);

		var option:Option = new Option('Lane Opacity',
			'Enables a black background behind the notes for visibility\nhow much opaque should it be?',
			'laneAlpha',
			'percent',
			0);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		addOption(option);

		var option:Option = new Option('Time Bar:',
			"What should the Time Bar display?",
			'timeBarType',
			'string',
			'Time Left',
			['Time Left', 'Time Elapsed', 'Song Name', 'Disabled']);
		addOption(option);
		
		var option:Option = new Option('Time Bar Style:',
			"What should the Time Bar look like?",
			'timeBarUi',
			'string',
			'Psych Engine',
			['Bedrock', 'Psych Engine', 'Kade Engine']);
		addOption(option);

		super();
	}

	#if !mobile
	function onChangeFPSCounter()
	{
		if(Main.fpsVar != null)
			Main.fpsVar.visible = ClientPrefs.showFPS;
	}
	#end
}
