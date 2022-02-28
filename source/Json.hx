package;

#if sys
import sys.io.File;
import sys.FileSystem;
#end
import haxe.Json;

class Json //extends JsonBase
{
    public var optionFile:String;
    public var optionName:String; //option name, will be saved as the name
    public var optionType:String;  
    public var value:String;
    public var type:Bool = true; //if this is false, it means json setting

    public function new(optionFile:String, optionName:String, optionType:String, ?value:String, type:Bool = true)
    {
        this.optionFile = optionFile;
        this.optionName = optionName;
        this.optionType = optionType;
        this.value = value;
        this.type = type;

        #if sys
        if (FileSystem.exists("settings/" + optionFile + ".json")) 
        {
            var cont:String = File.getContent("settings/" + optionFile + ".json");
            var lol:Dynamic = Json.parse(cont);

            if (type) 
            {
                value = null

                if (value == null)
                {
                    if (optionType == "true")
                        Reflect.setProperty(lol, optionName, true);
                    else if (optionType == "false")
                        Reflect.setProperty(lol, optionName, false);
                    else
                        Reflect.setProperty(lol, optionName, false);
                }
            }

            else
            {
                switch(optionType.toLowerCase())
                {
                    case "string":
                        Reflect.setProperty(lol, optionName, value);
                    default:
                        switch(optionType.toLowerCase())
                        {
                            case "int":
                                var int:Int = Std.parseInt(value);

                                if (int != null)
                                    Reflect.setProperty(lol, optionName, int)
                                else
                                    Reflect.setProperty(lol, optionName, 0);
                            case "float" | "double":
                                var float:Float = Std.parseFloat(value);

                                if (float != null)
                                    Reflect.setProperty(lol, optionName, float)
                                else
                                    Reflect.setProperty(lol, optionName, 0);
                        }
                }
            }
        }
        #end
    }
}

class JsonSettings
{
    public static var lol:Json;

    public static function main()
    {
    /*So quick talk
      Look at below, gameplay means the setting file.
      noteSkin means the option name, name will be saved on json file
      double means option type, like if you want your value to be 1.01 or something like that,
      make it 'double' or 'float'. they are the same.
      10 means the value, obviously
      false means the type is NOT bool, if you want your option to be bool make like this:
      var lol = new Json("yourFileName", "yourOptionName", "true", true);
      or if you want to false
      var lol = new Json("yourFileName", "yourOptionName", "false", true);
      do NOT touch the true at the end, it means its bool

      if you make the value float or int and do not write numbers in there
      value will be 0 by default, someone has already tought about this dumbass
    */
        lol = new Json("gameplay", "noteSkin", "double", "10", false);
    }
}