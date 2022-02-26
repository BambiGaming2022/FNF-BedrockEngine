package options;

#if desktop
import Discord.DiscordClient;
#end

class MillisecondCounterSubState extends BaseOptionsMenu
{
    public var coolBool:Null<Bool> = ClientPrefs.milliseconds;
    var option2:Option;

    public function new()
    {
        title = "Millisecond Counter Menu";
        rpcTitle = "In the Menus\nMillisecond Counter Menu";
    
        var option:Option = new Option('Millisecond Counter', "If unchecked, millisecond counters for when you hit a note\nwill be disabled.",
		'milliseconds', 'bool', true);
		addOption(option);

        lmao(); //used a different trick this time
        if (option2 != null)
            addOption(option2);

        super();
    }

    function lmao()
    {
        if (!coolBool && ClientPrefs.millisecondColor) {
        option2 = new Option('Millisecond Color (Inactive)', "If unchecked, millisecond counters won't change colors.\nEnable counters to change this!",
        'nothinglol', 'string', "", [""]);
        //so uh, nothinglol is a null string, it means if this option is inactive you wont be able to change anything in this option
        }
        else {
            option2 = new Option('Millisecond Color', "If unchecked, millisecond counters won't change colors.",
		    'millisecondColor', 'bool', coolBool);
        }
    }
}