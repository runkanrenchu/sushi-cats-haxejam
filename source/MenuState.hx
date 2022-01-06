package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.system.FlxAssets;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import openfl.text.TextFormat;

class MenuState extends FlxState
{
	var titleText:FlxText;
	var bd:FlxBackdrop;
	var playButton:FlxButton;
	var arr:Array<String>;
	var ttlObj:Array<Dynamic>;
	var datxt:FlxText;

	override public function create()
	{
		super.create();
		bd = new FlxBackdrop('assets/images/bdrop.png', 1, 1);
		bd.velocity.set(40, 40);
		FlxG.camera.bgColor = FlxColor.fromString("#d2cbf2");
		titleText = new FlxText(198, 90, 0, "Sushi Cats!", 48, true);
		titleText.font = 'assets/data/fonts/lowbatt.ttf';
		playButton = new FlxButton(256, 260, "Play!", onClick);

		datxt = new FlxText(148, 320, 0, "Made with love to the Haxe Community, \n by Renchu (@BSOD).", 14);
		datxt.alignment = CENTER;
		datxt.color = FlxColor.fromString("383259");
		datxt.autoSize = false;

		ttlObj = [bd, titleText, playButton, datxt];

		for (o in ttlObj)
			add(o);
	}

	function onClick()
	{
		FlxG.camera.fade(FlxColor.BLACK, 1);
		for (o in ttlObj)
		{
			FlxTween.tween(o, {alpha: 0}, 1, {
				onComplete: (_) ->
				{
					FlxG.camera.bgColor = FlxColor.BLACK;
					FlxG.switchState(new PlayState());
				}
			});
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
