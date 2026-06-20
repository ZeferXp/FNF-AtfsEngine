package options;
// import flixel.FlxSprite;
// import flixel.tweens.FlxTween;
// import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.graphics.FlxGraphic;

class PlayerChangerSubState extends BaseOptionsMenu
{
	public function new()
	{
		function createplrbg(name:String, x:Float, y:Float):FlxSprite
		backingS = new FlxSprite(FlxG.width, FlxG.height - 24);
		backing.loadGraphic('characterselect/backing');
		add(backing);

		FlxTween.tween(backing, {x: 0}, 0.65, {ease: flixel.tweens.FlxEase.quadOut});
	}
}
