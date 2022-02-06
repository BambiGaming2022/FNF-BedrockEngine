package;

import flixel.FlxG;
import flixel.math.FlxMath;
import Song.SwagSong;

/**
 * ...
 * @author
 */

typedef BPMChangeEvent =
{
	var stepTime:Int;
	var songTime:Float;
	var bpm:Float;
}

class Conductor
{
	public static var bpm:Float = 100;
	public static var crochet:Float = ((60 / bpm) * 1000); // beats in milliseconds
	public static var stepCrochet:Float = crochet / 4; // steps in milliseconds
	public static var songPosition:Float=0;
	public static var lastSongPos:Float;
	public static var offset:Float = 0;
	public static var numerator:Int = 4;
	public static var denominator:Int = 4;

	//public static var safeFrames:Int = 10;
	public static var safeZoneOffset:Float = (ClientPrefs.safeFrames / 60) * 1000; // is calculated in create(), is safeFrames in milliseconds

	public static var bpmChangeMap:Array<BPMChangeEvent> = [];

	public static var timeScale:Array<Int> = [4, 4];

	public static var nonmultilmao_crochet:Float = ((60 / bpm) * 1000); // beats in milliseconds
	public static var nonmultilmao_stepCrochet:Float = nonmultilmao_crochet / 4; // steps in milliseconds

	public function new()
	{
	}

	public static function recalculateStuff(?multi:Float = 1)
	{
		crochet = ((60 / bpm) * 1000);
		stepCrochet = crochet / (16 / timeScale[1]);

		if(multi != 1)
		{
			nonmultilmao_crochet = ((60 / bpm) * 1000);
			nonmultilmao_stepCrochet = nonmultilmao_crochet / (16 / timeScale[1]);
		}
		else
		{
			nonmultilmao_crochet = crochet;
			nonmultilmao_stepCrochet = stepCrochet;
		}
	}

	public static function judgeNote(note:Note, diff:Float=0) //STOLEN FROM KADE ENGINE (bbpanzu) - I had to rewrite it later anyway after i added the custom hit windows lmao (Shadow Mario)
	{
		JsonSettings.offdev(JsonSettings.offdir);
		var timingWindows:Array<Int> = [JsonSettings.marvWindow, JsonSettings.sickWindow, JsonSettings.goodWindow, JsonSettings.badWindow];
		if (ClientPrefs.keAccuracy)
		{
			var daDiff:Float = Math.abs(diff);
			for (index in 0...timingWindows.length) // based on 4 timing windows, will break with anything else
			{
				var time = timingWindows[index];
				var nextTime = index + 1 > timingWindows.length - 1 ? 0 : timingWindows[index + 1];
				if (daDiff < time && daDiff >= nextTime)
				{
					switch (index)
					{
						case 0: // marvelous
							return ClientPrefs.marvelouses ? "marvelous" : "sick";
						case 1: // sick
							return "sick";
						case 2: // good
							return "good";
						case 3: // bad
							return "bad";
					}
				}
			}
			return "good";
		}
		else
		{
			//tryna do MS based judgment due to popular demand
			var windowNames:Array<String> = ['sick', 'good', 'bad'];
			if (ClientPrefs.marvelouses)
				windowNames = ['marvelous', 'sick', 'good', 'bad']; //i dont think that works on haxe

			// var diff = Math.abs(note.strumTime - Conductor.songPosition) / (PlayState.songMultiplier >= 1 ? PlayState.songMultiplier : 1);
			for(i in 0...timingWindows.length) // based on 4 timing windows, will break with anything else
			{
				if (diff <= timingWindows[Math.round(Math.min(i, timingWindows.length - 1))])
				{
					return windowNames[i];
				}
			}
			return 'shit';
		}
	}
	public static function mapBPMChanges(song:SwagSong, ?songMultiplier:Float = 1.0)
	{
		bpmChangeMap = [];

		var curBPM:Float = song.bpm;
		var totalSteps:Int = 0;
		var totalPos:Float = 0;

		for (i in 0...song.notes.length)
		{
			if(song.notes[i].changeBPM && song.notes[i].bpm != curBPM)
			{
				curBPM = song.notes[i].bpm;

				var event:BPMChangeEvent = {
					stepTime: totalSteps,
					songTime: totalPos,
					bpm: curBPM
				};

				trace(totalPos);
				
				bpmChangeMap.push(event);
			}

			var deltaSteps:Int = song.notes[i].lengthInSteps;
			totalSteps += deltaSteps;
			totalPos += ((((60 /  curBPM) * 1000) / (denominator / 4)) / 4) * deltaSteps;
		}
		trace("new BPM map BUDDY " + bpmChangeMap);

		recalculateStuff(songMultiplier); //haha funny speed mods
	}

	public static function changeBPM(newBpm:Float)
	{
		bpm = newBpm;

		crochet = ((60 / bpm) * 1000) / (denominator / 4);
		stepCrochet = crochet / 4;
		
		//recalculateStuff(multi);
	}
}
