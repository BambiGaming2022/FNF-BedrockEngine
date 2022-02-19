package;

import haxe.Json;
import sys.io.File;
import sys.FileSystem;

using StringTools;

typedef NoteSkinFile =
{
	var name:String;
	var imageFile:String;
}

// Utils for Bedrock Engine
class BedrockUtil
{
	public static var noteSkins:Map<String, String> = [
		'bar' => 'NOTE_bar',
		'circle' => 'NOTE_circle',
		'diamond' => 'NOTE_diamond',
		'simply' => 'NOTE_simplyarrow',
		'step' => 'NOTE_step',
		'normal' => 'NOTE_assets'
	];

	// ayo actual helpers for note shitz????
	public static function reloadNoteSkinFiles()
	{
		#if MODS_ALLOWED
		var directories:Array<String> = [
			Paths.mods('noteskins/'),
			Paths.mods(Paths.currentModDirectory + '/noteskins/'),
			Paths.getPreloadPath('noteskins/')
		];
		#else
		var directories:Array<String> = [Paths.getPreloadPath('noteskins/')];
		#end

		for (i in 0...directories.length)
		{
			var directory:String = directories[i];
			if (FileSystem.exists(directory))
			{
				for (file in FileSystem.readDirectory(directory))
				{
					var path = haxe.io.Path.join([directory, file]);
					if (!FileSystem.isDirectory(path) && file.endsWith('.json'))
					{
						var rawJson:String = File.getContent(path).trim();
						while (!rawJson.endsWith("}"))
						{
							rawJson = rawJson.substr(0, rawJson.length - 1);
							// LOL GOING THROUGH THE BULLSHIT TO CLEAN IDK WHATS STRANGE
						}
						var json:NoteSkinFile = cast Json.parse(rawJson);
						if (!noteSkins.exists(json.name))
							noteSkins.set(json.name, json.imageFile);
					}
				}
			}
		}
	}

/*	public static function getNoteSkin(skin:String = 'normal', ?pixel:Bool = false)
	{
		var path:String = 'noteskins/';
		if (pixel)
			path = 'pixelUI/' + path;

		if (noteSkins.exists(skin.toLowerCase()))
			path += noteSkins.get(skin.toLowerCase());
		else
			path += noteSkins.get('normal');

		return path;
	}

typedef JudgementSkinFile =
{
	var name:String;
	var directory:String;
}

public static var jSkinFile:Map<String, String> = [
	'classic' => 'classic/',
	'bedrock' => 'bedrock/',
];

public static function reloadNoteSkinFiles()
{
	#if MODS_ALLOWED
	var directories:Array<String> = [
		Paths.mods('judgements/'),
		Paths.mods(Paths.currentModDirectory + '/judgements/'),
		Paths.getPreloadPath('judgements/')
	];
	#else
	var directories:Array<String> = [Paths.getPreloadPath('judgements/')];
	#end

	for (i in 0...directories.length)
	{
		var directory:String = directories[i];
		if (FileSystem.exists(directory))
		{
			for (file in FileSystem.readDirectory(directory))
			{
				var path = haxe.io.Path.join([directory, file]);
				if (!FileSystem.isDirectory(path) && file.endsWith('.json'))
				{
					var rawJson:String = File.getContent(path).trim();
					while (!rawJson.endsWith("}"))
					{
						rawJson = rawJson.substr(0, rawJson.length - 1);
					}
					var json:JudgementSkinFile = cast Json.parse(rawJson);
					if (!judgements.exists(json.name))
						judgements.set(json.name, json.imageFile);
				}
			}
		}
	}
}

	public static function getJudgementSkin(skin:String = 'classic', ?pixel:Bool = false)
	{
		var path:String = 'judgements/';
		if (pixel)
			path = 'pixelUI/' + path;

		if (jSkinFile.exists(skin.toLowerCase()))
			path += judgements.get(skin.toLowerCase());
		else
			path += judgements.get('classic');

		return path;
	}*/
}
