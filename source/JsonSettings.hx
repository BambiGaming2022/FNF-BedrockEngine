package;

#if sys
import sys.FileSystem;
import sys.io.File;
#end
import haxe.Json;
import flixel.FlxG;

class JsonSettings

{

    public static var logs:Int = 0; 
    //this is used for log counts

    //ui settings 
    public static var iconSupport:Bool;
    public static var noteSkin:String;
    public static var noteSplashSkin:String;
    public static var judgementSkin:String;

    //offsets, (working this time)

    public static var marvWindow:Int = 25;
    public static var sickWindow:Int = 45;
    public static var goodWindow:Int = 60;
    public static var badWindow:Int = 90;
    //public static var shitWindow:Int = 135;

    //gameplay settings 
    public static var divider:String;
    public static var letterGrader:Bool;
	public static var antiMash:Bool;

    //json directories
    public static var dirtwo:String = "settings/gameplaySettings.json";
    public static var dir:String = "settings/uiSettings.json";
    public static var offdir:String = "settings/offsets.json";

    #if MODS_ALLOWED
    public static var dirmod:String = "mods/settings/settings.json";
    #end

    public static function offdev(offdir:String)
    {
        if (FileSystem.exists(offdir))
        {
            var offset:String = File.getContent(offdir);
            if (offset != null && offset.length > 0)
            {
                logs++;

                var piss:Dynamic = Json.parse(offset);

                var marv:Int = Reflect.getProperty(piss, "marvOffset");
                var sick:Int = Reflect.getProperty(piss, "sickOffset");
                var good:Int = Reflect.getProperty(piss, "goodOffset");
                var bad:Int =  Reflect.getProperty(piss, "badOffset");

                marvWindow = marv;
                sickWindow = sick;
                goodWindow = good;
                badWindow = bad;


                //if its not int, make it int
                if (Std.is(marv, Float))
                {
                    Std.int(marv);
                    marvWindow = marv;

                    if (marv < 1 || marv > 45)
                        marvWindow = 25;
                }

                if (Std.is(sick, Float))
                {
                    Std.int(sick);
                    sickWindow = sick;

                    if (sick < 5 || sick > 75)
                        sickWindow = 45;
                }

                if (Std.is(good, Float))
                {
                    Std.int(good);
                    goodWindow = sick;

                    if (good < 10 || good > 135)
                        goodWindow = 60;

                }

                if (Std.is(bad, Float))
                {
                    Std.int(bad);
                    badWindow = bad;

                    if (bad < 15 || bad > 180)
                        badWindow = 90;
                }

                //prevent people to abuse it
                if (marv < 1 || marv > 45)
                    marvWindow = 25;
                if (sick < 5 || sick > 75)
                    sickWindow = 45;
                if (good < 10 || good > 135)
                    goodWindow = 60;
                if (bad < 15 || bad > 180)
                    badWindow = 90;
            }
        }
    }

    public static function devtwo(dirtwo:String)
    {
        if (FileSystem.exists(dirtwo))
        {
            var customJson:String = File.getContent(dirtwo);
            if (customJson != null && customJson.length > 0)
            {
                logs++;

                var poop:Dynamic = Json.parse(customJson);
                var letterGraderTEMPLATE:Bool = Reflect.getProperty(poop, "letterGrader");
				var antiMashTEMPLATE:Bool = Reflect.getProperty(poop, "antiMash");
				var dividerTEMPLATE:String = Reflect.getProperty(poop, "divider");

                letterGrader = letterGraderTEMPLATE;
                antiMash = antiMashTEMPLATE;
                divider = dividerTEMPLATE;

               // trace(antiMash + divider + letterGrader);

                if (dividerTEMPLATE != null && dividerTEMPLATE.length > 6)
                {
                    if  (logs < 16)
                     trace("did you really think you could abuse dividers LMAO");
                    divider = ' - ';
                }
                
                if (dividerTEMPLATE==null)
                {
                    divider = " - ";
                    if (FlxG.random.bool(0.1)) //this has a little chance to happen
                    {
                        if (FileSystem.exists("settings/lmao.log"))
                        {
                            if (logs < 31)
                                trace("you already got this one lmao");
                        }
                        else
                            File.saveContent("settings/lmao.log", "did you really think you could make noteskins null? LMFAO someone thought about this already dumbass");
                        divider = " permission-denied ";
                    }
                }
            }
        }
    }

    public static function dev(dir:String)
    {
        if (FileSystem.exists(dir))
        {
            var customGame:String = File.getContent(dir);
            if (customGame != null && customGame.length > 0)
            {
                logs++;

                var shit:Dynamic = Json.parse(customGame);
                var iconSupportTEMPLATE:Bool = Reflect.getProperty(shit, "iconSupport");
				var judgementSkinTEMPLATE:String = Reflect.getProperty(shit, "judgementSkin");
				var noteSplashSkinTEMPLATE:String = Reflect.getProperty(shit, "noteSplashSkin");
                var noteSkinTEMPLATE:String = Reflect.getProperty(shit, "noteSkin");

                noteSkin = noteSkinTEMPLATE;
                noteSplashSkin = noteSplashSkinTEMPLATE;
                judgementSkin = judgementSkinTEMPLATE;
                iconSupport = iconSupportTEMPLATE;

                if (judgementSkinTEMPLATE == null || judgementSkinTEMPLATE.length < 0)
                {
                   if (logs < 11) 
                    trace("invalid judgement skin, reverting back to the defaults.");
                   judgementSkin = 'bedrock';
                }

                if (noteSkinTEMPLATE == null || noteSkinTEMPLATE.length < 0)
                {
                    if (logs < 11)
                     trace("invalid note skin, reverting back to the defaults.");
                    noteSkin = 'NOTE_assets';
                }

                if (noteSplashSkinTEMPLATE == null || noteSplashSkinTEMPLATE.length < 0)
                {
                    if (logs < 11)
                     trace("invalid note splash, reverting back to the defaults.");
                    noteSplashSkin = 'noteSplashes';
                }
            }
        }
    }

   

    //use this on your mods and add your options 
    #if MODS_ALLOWED
    public static function devmod(dirmod:String)
    {
        if (FileSystem.exists(dir))
        {
            var customMod:String = File.getContent(dirmod);
            if (customMod != null)
            {
                logs++;

                trace("wow no mod options installed");
            }
        }
    }
    #end
}