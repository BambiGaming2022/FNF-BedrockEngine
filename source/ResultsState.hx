package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import flixel.util.FlxTimer;

class ResultsState extends MusicBeatState
{
    public var swagQuotes:FlxText;
    public var accText:FlxText;
    public var ratingShit:Array<Dynamic>;
    // public var continue:FlxText;

    public var applause:FlxSound;
    public var results:FlxSound;

    public var bg:FlxSprite;
    public var resultRank:FlxSprite;
    public var hidingBG:FlxSprite;

    // WIP
    override function create()
    {
        applause = new FlxSound().loadEmbedded(Paths.sound('applause'));
        results = new FlxSound().loadEmbedded(Paths.music('resultsScreen'));
        results.looped = true;

        var ratingResult:String = '';

        var judgements:FlxSpriteGroup = new FlxSpriteGroup();

        accText = new FlxText(-200, 65, 0,
            'Accuracy: ${countAcc(Highscore.floorDecimal(PlayState.instance.ratingPercent * 100, 2), 2)}'
        );

        var perfect:FlxSprite = new FlxSprite(-150, 65).loadGraphic(Paths.image('maniamode/resultsscreen/perfect'));
        perfect.antialiasing = true;

        ratingShit = Ratings.maniaMode;
        var percent:Float = PlayState.instance.ratingPercent;

        if(percent >= 1) {
            var poop = ratingsShit[ratingsShit.length - 1][0];
            ratingResult = poop;
        } else {
            for (i in 0...ratingsShit.length - 1)
			{
				if (percent < ratingsShit[i][1])
				{
					ratingResult = ratingsShit[i][0];
					break;
				}
			}
		}
        
        switch(ratingShit) {
            case 'D':
                swagQuotes = new FlxText;
        }

        resultRank = new FlxSprite(FlxG.width - 400, 60).loadGraphic(Paths.image('maniamode/rankresults/' + ratingResult));
        resultRank.antialiasing = ClientPrefs.globalAntialiasing;
        resultRank.visible = false;

        if(PlayState.instance.totalMisses < 1 && ratingResult == 'X' || ratingResult == 'S')
            resultRank = new FlxSprite(600, 60).loadGraphic(Paths.image('maniamode/rankresults/' + ratingResult + '-gold'));

        hidingBG = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);

        add(accText);
        add(resultRank);

        super.create();
    }

    override function update(elapsed:Float):Void
    {
        if(controls.ACCEPT)
        {
            results.fadeIn(0.4, 1, 0);
            applause.fadeIn(0.4, 1, 0);

            FlxG.sound.playMusic(Paths.music('freakyMenu'));
			if (ClientPrefs.useClassicSongs)
			{
				FlxG.sound.playMusic(Paths.music('freakyMenuC'));
			}

            if(PlayState.isStoryMode)
                MusicBeatState.switchState(new StoryMenuState());
            else
                MusicBeatState.switchState(new FreeplayState());
        }

        super.update(elapsed);
    }

    public function new()
    {
        bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        bg.alpha = 0;

        FlxTween.tween(bg, {alpha: 0.6}, 1, {
            ease: FlxEase.circOut
        });

        new FlxTimer().start(0.9, function(tmr:FlxTimer)
        {
            resultRank.visible = true;
            FlxG.sound.play(Paths.sound('confirmMenu'));
            new FlxTimer().start(0.6, function(tmr:FlxTimer)
            {
                results.play();
                applause.play();
            });
        });

        super();
    }

    public static function countAcc(number:Float, precision:Int):Float // ROBBED FROM KADE LMAOO
    {
        var num = number;
        num = num * Math.pow(10, precision);
        num = Math.round(num) / Math.pow(10, precision);
        return num;
    }
}