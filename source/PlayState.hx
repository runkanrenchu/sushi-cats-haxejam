package;

import CatImproved.CatImp;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.text.FlxTypeText;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import haxe.CallStack;

class PlayState extends FlxState
{
	var counter:Float = 0.08;
	var kitties:CatImp;
	var blanket:FlxSprite;
	var curKit:String;
	var timer:FlxTimer;
	var bg:FlxSprite;
	var curBlanket:String;
	var curRoll:String;
	var tutorial:FlxTypeText;
	var tutFinish:Bool = false;
	var rollPoint:FlxSprite;
	var leftRollPoint:FlxSprite;
	var points:Float = 0;
	var pText:FlxText;
	var flag:Bool = true;
	var leftFlag:Bool = true;
	var catcom:Array<FlxSprite>;

	override public function create()
	{
		FlxG.mouse.visible = false;

		pText = new FlxText(106, 322, 0, "", 16, true);
		pText.font = 'assets/data/fonts/statusplz-regular.ttf';
		pText.antialiasing = false;

		rollPoint = new FlxSprite(480, 380);
		rollPoint.makeGraphic(16, 16, FlxColor.TRANSPARENT);
		leftRollPoint = new FlxSprite(25, 380);
		FlxG.watch.add(leftRollPoint, "x");
		FlxG.watch.add(leftRollPoint, "y");
		leftRollPoint.makeGraphic(16, 16, FlxColor.TRANSPARENT);
		FlxG.camera.color = FlxColor.BLACK;
		FlxG.camera.fade(FlxColor.TRANSPARENT, 1, true);
		super.create();
		bg = new FlxSprite(0, 0, 'assets/images/playstate/stage preview.png');

		add(bg);
		add(rollPoint);
		add(leftRollPoint);
		add(pText);
		#if (FLX_DEBUG)
		{
			#if (show_devtools == "yes")
			FlxG.watch.addMouse();
			FlxG.watch.add(pText, "x");
			FlxG.watch.add(pText, "y"); // pText.angle = -8;
			FlxG.watch.add(pText, "angle");
			var angButton = new FlxButton(0, 0, "1more", onClick);
			add(angButton);
			#end
			FlxG.mouse.visible = true;
		}
		#end
		spawnCats();
	}

	function onClick()
	{
		pText.angle = pText.angle - 2;
	}

	function spawnCats()
	{
		switch (FlxG.random.int(0, 3))
		{
			case 0:
				curKit = 'lilly';
			case 1:
				curKit = 'logo';
			case 2:
				curKit = 'luna';
			case 3:
				curKit = 'artsi';
			case _:
				trace("default :(");
		}

		kitties = new CatImp(108, 363, curKit);
		if (kitties != null && !kitties.exists && !kitties.alive)
			kitties.revive();

		add(kitties);
		FlxTween.tween(kitties.cat, {y: kitties.cat.y + 20}, 0.8, {ease: FlxEase.bounceOut});
	}

	function doARoll()
	{
		if ((kitties.cat.overlaps(rollPoint) && flag) || (kitties.cat.overlaps(leftRollPoint) && leftFlag))
		{
			flag = false;
			leftFlag = false;

			points = points + 25;
			kitties.rolled = true;
			for (i in kitties.movObj)
				FlxTween.tween(i, {angle: i.angle + 20, y: 500}, 0.7, {
					ease: FlxEase.bounceOut,
					onComplete: function(_):Void
					{
						for (i in kitties.movObj)
							i.kill();

						spawnCats();
						flag = true;
						leftFlag = false;
					}
				});
		}
		else if (kitties.cat.overlaps(leftRollPoint) && leftFlag)
			leftFlag = false;
	}

	override public function update(elapsed:Float)
	{
		pText.text = '$points';
		doARoll();
		super.update(elapsed);
	}
}
