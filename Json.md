# Adding Json options to the game

If you want to add Json options, you'll need 3 things.

```
Source Code
An editor (Visual Studio or Atom recommended)
Necessary Haxe libraries and stuff.
```



If you do not know about compiling the game or coding we don't recommend doing this because source code is not user-friendly, but still if you wanna add option just read [this](https://github.com/Gui-iago/FNF-BedrockEngine/blob/main/README.md) compiling guide.

You must have the most recent source code, if you use an outdated source it may be buggy.

Jsons are working fine right now but it is not fully clean and it'll have some bugs in it.

Then let's begin.

First, go to ```source/JsonSettings.hx``` then open it in your editor.

Find:    
```haxe   
public static var dir:String = "settings/uiSettings.json";
```

Then write this next to it: 
```haxe
public  static var yourshit:String  = "mods/settings/yourshit.json";
```

It has already mod settings but in case if you want to add a new one.

Go to bottom.

Copy paste this code. (If you do not want to use function devmod)

```haxe
public static function moddev(yourshit:String)
{
    if (FileSystem.exists(yourshit))
    {
        var customJsonMod:String = File.getContent(yourshit);
        if (customJsonMod != null && customJson.length > 0)
        {
            logs++;
            
            
        }
    }
}
```

Now, go to UI Settings or (Gameplay) section at top, and create your **public static** variable.

It can be anything; string, integer, float or a bool.

We will use bools because it's the most simple one.

Write this to ui or gameplay section.

```haxe
public static var coolBool:Bool;
```

In moddev function, write this next to logs++;:

```haxe
var shit:Dynamic = Json.parse(customJsonMod);
var coolBool:Bool = Reflect.getProperty(shit, "coolBool");
```

Now, create a file called ```yourshit.json``` and place to ```example_mods/settings``` .

Write this in it:

```java
{
    coolBool:true
}
```

If you want 2 options, then write:

```java
{
    coolBool:true,
    coolBool2:true
}
```

Then call your function like this:
```haxe
JsonSettings.moddev(JsonSettings.yourshit);
```
You can use your function in EVERYWHERE, it does not matter where you put it'll work.

Use your bool like this in another states:

```haxe
JsonSettings.moddev(JsonSettings.yourshit); //call the function

if (coolBool) //this means bool is true
    trace("coolBool is true"); //warn the player
    
else if (!coolBool) //this means bool is false
    trace("coolBool is false");
    
else //this means bool is null, very big problem
{
    coolBool = true; //make the coolBool true
    trace("coolBool was null, made it true.");
}
```

This is an example of course, it can be used for much much more complex things.
 











