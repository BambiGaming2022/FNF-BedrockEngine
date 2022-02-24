package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.ui.FlxBar;
import flixel.text.FlxText;
import flixel.graphics.FlxGraphic;

public var healthBar:FlxBar;
public var healthBarBG:AttachedSprite;

public var iconP1:HealthIcon;
public var iconP2:HealthIcon;

public var timeBar:FlxBar;
public var timeBarBG:AttachedSprite;

/*
	timeBarBG and healthBarBG should now be public so I can mess with them 
	on PlayState if I ever actually implement ClassHUD
	- Gui iago
*/

public var scoreTxt:FlxText;
public var botplayTxt:FlxText;

public var beWatermark:FlxText;
public var peWatermark:FlxText;
public var judgementCounter:FlxText;
public var songDisplay:FlxText;
public var laneunderlay:FlxSprite;
public var laneunderlayOpponent:FlxSprite;

class ClassHUD extends FlxTypedGroup<FlxBasic>
{
	//nothing
}