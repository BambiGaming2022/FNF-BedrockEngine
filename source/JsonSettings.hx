package;

#if (desktop && sys)
import Discord.DiscordClient;
import sys.FileSystem;
import sys.io.File;
#end
import haxe.Json;

class JsonSettings

{

    public static var logs:Int = 0; 
    //this is used for log counts

    //ui settings 
    public static var iconSupport:Bool;
    public static var noteSkin:String;
    public static var noteSplashSkin:String;
    public static var judgementSkin:String;

    //gameplay settings 
    public static var divider:String;
    public static var letterGrader:Bool;
	public static var antiMash:Bool;

    //json directories
    public static var dirtwo:String = "settings/gameplaySettings.json";
    public static var dir:String = "settings/uiSettings.json";
    #if MODS_ALLOWED
    public static var dirmod:String = "mods/settings/settings.json";
    #end

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

                //trace(antiMash + divider + letterGrader);

                if (dividerTEMPLATE != null && dividerTEMPLATE.length > 6)
                {
                    if  (logs < 16)
                     trace("did you really think you could abuse dividers LMAO");
                    divider = ' ' +null+ ' ';
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
                    trace("judgement skins are null, making them bedrock again.");
                   judgementSkin = 'bedrock';
                }

                if (noteSkinTEMPLATE == null || noteSkinTEMPLATE.length < 0)
                {
                    if (logs < 11)
                     trace("note skins are null, making them note_assets again.");
                    noteSkin = 'NOTE_assets';
                }

                if (noteSplashSkinTEMPLATE == null || noteSplashSkinTEMPLATE.length < 0)
                {
                    if (logs < 11)
                     trace("note splash skins are null, making them noteSplashes again.");
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
