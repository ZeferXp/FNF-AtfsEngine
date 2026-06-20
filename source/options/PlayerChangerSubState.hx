package options;


class PlayerChangerSubState extends BaseOptionsMenu
{
	public function new()
	{
		function createplrbg(name:String, x:Float, y:Float):FlxSprite
	{
		var plrbg:FlxSprite = new FlxSprite(x, y);
		plrbg.frames = Paths.getSparrowAtlas('characterselect/backing');

var ui_tex = Paths.getSparrowAtlas('playerselect/player_UI_ast');




charSelectors = new FlxGroup();
		add(charSelectors);

		leftArrow = new FlxSprite(850, grpWeekText.members[0].y + 10);
		leftArrow.antialiasing = ClientPrefs.data.antialiasing;
		leftArrow.frames = ui_tex;
		leftArrow.animation.addByPrefix('idle', "arrow left");
		leftArrow.animation.addByPrefix('press', "arrow push left");
		leftArrow.animation.play('idle');
		charSelectors.add(leftArrow);

		Difficulty.resetList();
		if(lastDifficultyName == '')
		{
			lastDifficultyName = Difficulty.getDefault();
		}
		curDifficulty = Math.round(Math.max(0, Difficulty.defaultList.indexOf(lastDifficultyName)));
		
		sprDifficulty = new FlxSprite(0, leftArrow.y);
		sprDifficulty.antialiasing = ClientPrefs.data.antialiasing;
		charSelectors.add(sprDifficulty);

		rightArrow = new FlxSprite(leftArrow.x + 376, leftArrow.y);
		rightArrow.antialiasing = ClientPrefs.data.antialiasing;
		rightArrow.frames = ui_tex;
		rightArrow.animation.addByPrefix('idle', 'arrow right');
		rightArrow.animation.addByPrefix('press', "arrow push right", 24, false);
		rightArrow.animation.play('idle');
		charSelectors.add(rightArrow);

		add(IdlePlayer);

		changeDifficulty();

		super.create();
	}
	function changecharacter(change:Int = 0):Void
	{
		curCharacter += change;

		if (curCharacter < 0)
			curCharacter = Character.list.length-1;
		if (curCharacter >= Character.list.length)
			curCharacter = 0;

		WeekData.setDirectoryFromWeek(loadedWeeks[curWeek]);

		var diff:String = Character.getString(curCharacter, false);
		var newImage:FlxGraphic = Paths.image('playerselect/characters/tag$name');
		//trace(Mods.currentModDirectory + ', menudifficulties/' + Paths.formatToSongPath(diff));

	override function closeSubState() {
		persistentUpdate = true;
		changeWeek();
		super.closeSubState();
	}

























		if(sprCharacter.graphic != newImage)
		{
			sprCharacter.loadGraphic(newImage);
			sprCharacter.x = leftArrow.x + 60;
			sprCharacter.x += (308 - sprCharacter.width) / 3;
			sprCharacter.alpha = 0;
			sprCharacter.y = leftArrow.y - sprCharacter.height + 50;

			FlxTween.cancelTweensOf(sprCharacter);
			FlxTween.tween(sprCharacter, {y: sprCharacter.y + 30, alpha: 1}, 0.07);
		}
		lastCharacterName = diff;

		#if !switch
		intendedScore = Highscore.getWeekScore(loadedWeeks[curWeek].fileName, curCharacter);
		#end
	}




		plrbg.antialiasing = ClientPrefs.data.antialiasing;
		plrbg.scrollFactor.set();
		plrbgs.add(plrbg);
		return plrbg;
	}
		sprite.x = FlxG.width;

		var targetX:Float = FlxG.width - sprite.width - 20; // 20 pixels from the right edge

		FlxTween.tween(sprite, {x: targetX}, 1.0, {ease: FlxEase.quadOut});
		super();
	}

	function onChangeHitsoundVolume()
		FlxG.sound.play(Paths.sound('hitsound'), ClientPrefs.data.hitsoundVolume);

	function onChangeAutoPause()
		FlxG.autoPause = ClientPrefs.data.autoPause;
}
