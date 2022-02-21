package options;

import gameObjects.font.Alphabet;
import meta.data.ClientPrefs;
import meta.data.FlxUIDropDownMenuCustom;
import meta.subState.MusicBeatSubstate;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;

class NotesPromptSubState extends MusicBeatSubstate
{
	var noteSkinList:Array<String> = [];

	var dropDown:FlxUIDropDownMenuCustom;

	override function create()
	{
		super.create();

		BedrockUtil.reloadNoteSkinFiles();

		for (skin in BedrockUtil.noteSkins.keys())
			noteSkinList.push(skin);

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
		bg.alpha = 0.3;
		add(bg);

		var text:Alphabet = new Alphabet(0, FlxG.height / 3, 'Choose your Noteskin', true);
		text.screenCenter(X);
		add(text);

		dropDown = new FlxUIDropDownMenuCustom(0, text.y + text.height * 1.5, FlxUIDropDownMenuCustom.makeStrIdLabelArray(noteSkinList, true),
			function(skin:String)
			{
				ClientPrefs.noteSkin = noteSkinList[Std.parseInt(skin)];
			});
		dropDown.screenCenter(X);
		add(dropDown);

		FlxG.mouse.visible = true;
	}

	override function close()
	{
		FlxG.mouse.visible = false;
		super.close();
	}

	override function update(elasped)
	{
		super.update(elasped);

		if (!dropDown.dropPanel.visible)
		{
			if (controls.ACCEPT)
			{
				ClientPrefs.saveSettings();
				FlxG.sound.play(Paths.sound('confirmMenu'));
				close();
			}

			if (controls.BACK)
			{
				ClientPrefs.saveSettings();
				FlxG.sound.play(Paths.sound('cancelMenu'));
				close();
			}
		}
	}
}
