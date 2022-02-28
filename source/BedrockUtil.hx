package;

import haxe.Json;
#if sys
import sys.io.File;
import sys.FileSystem;
#end

using StringTools;

typedef NoteSkinFile =
{
	var name:String;
	var imageFile:String;
}

// Utils for Bedrock Engine
class BedrockUtil
{
	public static var noteSkins:Map<String, String> = ['normal' => 'NOTE_assets', 'circle' => 'NOTE_circle', 'bar' => 'NOTE_bar'];

	// ayo actual helpers for note shitz????
	public static function reloadNoteSkinFiles()
	{
		#if MODS_ALLOWED
		var directories:Array<String> = [
			Paths.mods('images/noteskins/'),
			Paths.mods(Paths.currentModDirectory + '/noteskins/'),
			Paths.getPreloadPath('noteskins/')
		];
		#else
		var directories:Array<String> = [Paths.getPreloadPath('noteskins/')];
		#end

		for (i in 0...directories.length)
		{
			var directory:String = directories[i];
			#if sys
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
			#end
		}
	}

	public static function getNoteSkin(skin:String = 'normal', ?pixel:Bool = false)
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
}
