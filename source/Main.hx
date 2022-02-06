package;

import flixel.graphics.FlxGraphic;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import openfl.Assets;
import openfl.Lib;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.display.StageScaleMode;
import haxe.Timer;
import openfl.events.Event;
import openfl.system.System;
import openfl.text.TextField;
import openfl.text.TextFormat;

class FPS_Mem extends TextField
{
	private var times:Array<Float>;
	private var memPeak:Float = 0;

	public function new(inX:Float = 10.0, inY:Float = 10.0, inCol:Int = 0x000000)
	{
		super();
		x = inX;
		y = inY;
		selectable = false;
		defaultTextFormat = new TextFormat("VCR OSD Mono", 16, inCol);
		text = "FPS: ";
		times = [];
		addEventListener(Event.ENTER_FRAME, onEnter);
		width = 1280;
		height = 720;
	}

	private function onEnter(_)
	{
		var now = Timer.stamp();
		times.push(now);
		while (times[0] < now - 1)
			times.shift();
		var mem:Float = Math.round(System.totalMemory / 1024 / 1024 * 100) / 100;
		if (mem > memPeak)
			memPeak = mem;
		if (visible)
		{
			//TODO: make this thing less complicated

			text = "FPS: " + times.length; //FPS Text

			if(ClientPrefs.memCounter)
				text = "FPS: " + times.length + "\nMEM: " + mem + " MB\nMEM peak: " + memPeak + " MB"; // FPS with Memory Counter text

			if(ClientPrefs.memCounter && !ClientPrefs.showFPS)
				text = "MEM: " + mem + " MB\nMEM peak: " + memPeak + " MB"; // Memory Counter without FPS text

			if(!ClientPrefs.showFPS && !ClientPrefs.memCounter)
				text = ""; //nothing lol
		}
	}
}

class Main extends Sprite
{
	var gameWidth:Int = 1280; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var gameHeight:Int = 720; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).

	public static var mainClassState:Class<FlxState>; // Determine the main class state of the game

	var initialState:Class<FlxState> = TitleState; // The FlxState the game starts with.
	var zoom:Float = -1; // If -1, zoom is automatically calculated to fit the window dimensions.
	var framerate:Int = 60; // How many frames per second the game should run at.
	var skipSplash:Bool = true; // Whether to skip the flixel splash screen that appears in release mode.
	var startFullscreen:Bool = false; // Whether to start the game in fullscreen on desktop targets

	public static var fpsVar:FPS;

	// You can pretty much ignore everything from here on - your code should go in your states.

	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();

		if (stage != null)
		{
			init();
		}
		else
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}

	private function setupGame():Void
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (zoom == -1)
		{
			var ratioX:Float = stageWidth / gameWidth;
			var ratioY:Float = stageHeight / gameHeight;
			zoom = Math.min(ratioX, ratioY);
			gameWidth = Math.ceil(stageWidth / zoom);
			gameHeight = Math.ceil(stageHeight / zoom);
		}

		#if !debug
		initialState = TitleState;
		#end

		ClientPrefs.loadDefaultKeys();
		// fuck you, persistent caching stays ON during sex
		FlxGraphic.defaultPersist = true;
		// the reason for this is we're going to be handling our own cache smartly
		addChild(new FlxGame(gameWidth, gameHeight, initialState, zoom, framerate, framerate, skipSplash, startFullscreen));

		#if !mobile
		var fps_mem:FPS_Mem = new FPS_Mem(10, 3, 0xFFFFFF);
		Lib.current.stage.align = "tl";
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		#end

		#if !debug
		addChild(fps_mem);
		if (fps_mem != null)
		{
			fps_mem.visible = ClientPrefs.showFPS;
		}
		#end
	}
}
