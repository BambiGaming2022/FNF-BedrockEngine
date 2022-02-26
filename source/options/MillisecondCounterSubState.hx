package options;

#if desktop
import Discord.DiscordClient;
#end

class MillisecondCounterSubState extends BaseOptionsMenu
{
    public function new()
    {
        title = "Millisecond Counter Menu";
        rpcTitle = "In the Menus\nMillisecond Counter Menu";
    
        var option:Option = new Option('Millisecond Counter', "If unchecked, milliseconds counters when you hit a note\nwill be disabled.",
		'milliseconds', 'bool', true);
		addOption(option);
        //will add alot of stuff here

        super();
    }
}