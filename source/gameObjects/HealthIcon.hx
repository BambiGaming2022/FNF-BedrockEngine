package gameObjects;

import meta.data.ClientPrefs;
import meta.CoolUtil;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import openfl.utils.Assets as OpenFlAssets;

using StringTools;

class HealthIcon extends FlxSprite
{
	public var sprTracker:FlxSprite;
	public var canBounce:Bool = false;
	private var isOldIcon:Bool = false;
	private var isPlayer:Bool = false;
	private var char:String = '';

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		isOldIcon = (char == 'bf-old');
		this.isPlayer = isPlayer;
		changeIcon(char);
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);

		if (canBounce)
		{
			var mult:Float = FlxMath.lerp(1, scale.x, CoolUtil.boundTo(1 - (elapsed * 9), 0, 1));
			scale.set(mult, mult);
			updateHitbox();
		}
	}

	public function swapOldIcon() {
		if(isOldIcon = !isOldIcon) changeIcon('bf-old');
		else changeIcon('bf');
	}

	private var iconOffsets:Array<Float> = [0, 0, 0];
	public var int:Int = 3;

	

	public function changeIcon(char:String) {
		if (ClientPrefs.iconSupport)
		{
			iconOffsets = [0, 0];
			int = 2;
		}
		if(this.char != char) {
			var name:String = 'icons/' + char;
			if (ClientPrefs.iconSupport)
				name = "icons-old/" + char;
			if(!Paths.fileExists('images/' + name + '.png', IMAGE)) 
			{
				name = 'icons/icon-' + char; //Older versions of psych engine's support
				if (ClientPrefs.iconSupport)
					name = "icons-old/icon-" + char;
			}

			if(!Paths.fileExists('images/' + name + '.png', IMAGE))
			{	 
				name = 'icons/icon-face'; //Prevents crash from missing icon
			 	if (ClientPrefs.iconSupport)
					name = "icons-old/icon-face";
			}
			var file:Dynamic = Paths.image(name);

			loadGraphic(file); //Load stupidly first for getting the file size
			loadGraphic(file, true, Math.floor(width / int), Math.floor(height)); //Then load it fr
			iconOffsets[0] = (width - 150) / 2;
			iconOffsets[1] = (width - 150) / 2;
			if (!ClientPrefs.iconSupport)
				iconOffsets[2] = (width - 150) / 2;
			updateHitbox();

			if (ClientPrefs.iconSupport)
				animation.add(char, [0, 1], 0, false, isPlayer);
			else
				animation.add(char, [0, 1, 2], 0, false, isPlayer);
			
			animation.play(char);
			this.char = char;

			antialiasing = ClientPrefs.globalAntialiasing;
			if(char.endsWith('-pixel')) {
				antialiasing = false;
			}
		}
	}

	override function updateHitbox()
	{
		super.updateHitbox();
		offset.x = iconOffsets[0];
		offset.y = iconOffsets[1];
	}

	public function bounce()
	{
		if (canBounce)
		{
			var mult:Float = 1.2;
			scale.set(mult, mult);
			updateHitbox();
		}
	}

	public function getCharacter():String {
		return char;
	}
}
