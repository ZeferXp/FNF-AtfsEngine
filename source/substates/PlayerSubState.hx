package substates;

import backend.WeekData;
import backend.Highscore;

import flixel.FlxSubState;
import objects.HealthIcon;

class PlayerSubState extends MusicBeatSubstate
{
	var bg:FlxSprite;
	var alphabetArray:Array<Alphabet> = [];
	var icon:HealthIcon;
	var onYes:Bool = false;
	var yesText:Alphabet;
	var noText:Alphabet;

	var song:String;
	var difficulty:Int;
	var week:Int;

	// Week -1 = Freeplay
	public function new(song:String, difficulty:Int, character:String, week:Int = -1)
	{
		this.song = song;
		this.difficulty = difficulty;
		this.week = week;

		super();

		var name:String = song;
		if(week > -1) {
			name = WeekData.weeksLoaded.get(WeekData.weeksList[week]).weekName;
		}
		name += ' (' + Difficulty.getString(difficulty) + ')?';

		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

		// PlayerSelectors = new FlxGroup();
		// add(PlayerSelectors);

		// leftArrow = new FlxSprite(850, grpWeekText.members[0].y + 10);
		// leftArrow.antialiasing = ClientPrefs.data.antialiasing;
		// leftArrow.frames = ui_tex;
		// leftArrow.animation.addByPrefix('idle', "arrow left");
		// leftArrow.animation.addByPrefix('press', "arrow push left");
		// leftArrow.animation.play('idle');
		// PlayerSelectors.add(leftArrow);

		// PlayerSelectors.resetList();
		// if(lastPlayerName == '')
		// {
		// 	lastPlayerName = Player.getDefault();
		// }
		// curPlr = Math.round(Math.max(0, Player.defaultList.indexOf(lastPlayerName)));
		
		// sprPlayer = new FlxSprite(0, leftArrow.y);
		// sprPlayer.antialiasing = ClientPrefs.data.antialiasing;
		// PlayerSelectors.add(sprName);

		// rightArrow = new FlxSprite(leftArrow.x + 376, leftArrow.y);
		// rightArrow.antialiasing = ClientPrefs.data.antialiasing;
		// rightArrow.frames = ui_tex;
		// rightArrow.animation.addByPrefix('idle', 'arrow right');
		// rightArrow.animation.addByPrefix('press', "arrow push right", 24, false);
		// rightArrow.animation.play('idle');
		// difficultySelectors.add(rightArrow);

		yesText = new Alphabet(0, text.y + 150, Language.getPhrase('Yes'), true);
		yesText.screenCenter(X);
		yesText.x -= 200;
		add(yesText);
		noText = new Alphabet(0, text.y + 150, Language.getPhrase('No'), true);
		noText.screenCenter(X);
		noText.x += 200;
		add(noText);
		
		for(letter in yesText.letters) letter.color = FlxColor.RED;
		updateOptions();
	}

	override function update(elapsed:Float)
	{
		bg.alpha += elapsed * 1.5;
		if(bg.alpha > 0.6) bg.alpha = 0.6;

		for (i in 0...alphabetArray.length) {
			var spr = alphabetArray[i];
			spr.alpha += elapsed * 2.5;
		}
		if(week == -1) icon.alpha += elapsed * 2.5;

		if(controls.UI_LEFT_P || controls.UI_RIGHT_P) {
			FlxG.sound.play(Paths.sound('scrollMenu'), 1);
			onYes = !onYes;
			updateOptions();
		}
		if(controls.BACK) {
			FlxG.sound.play(Paths.sound('cancelMenu'), 1);
			close();
		} else if(controls.ACCEPT) {
			if(onYes) {
				if(week == -1) {
					Highscore.resetSong(song, difficulty);
				} else {
					Highscore.resetWeek(WeekData.weeksList[week], difficulty);
				}
			}
			FlxG.sound.play(Paths.sound('cancelMenu'), 1);
			close();
		}
		super.update(elapsed);
	}

	function updateOptions() {
		var scales:Array<Float> = [0.75, 1];
		var alphas:Array<Float> = [0.6, 1.25];
		var confirmInt:Int = onYes ? 1 : 0;

		yesText.alpha = alphas[confirmInt];
		yesText.scale.set(scales[confirmInt], scales[confirmInt]);
		noText.alpha = alphas[1 - confirmInt];
		noText.scale.set(scales[1 - confirmInt], scales[1 - confirmInt]);
		if(week == -1) icon.animation.curAnim.curFrame = confirmInt;
	}
}