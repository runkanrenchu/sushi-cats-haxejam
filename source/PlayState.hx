package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.text.FlxTypeText;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
	var counter:Float = 0.08;
	var kitties:Cat;
	var blanket:FlxSprite;
	var curKit:String;
	var timer:FlxTimer;
	var bg:FlxSprite;
	var curBlanket:String;
	var curRoll:String;
	var tutorial:FlxTypeText;
	var tutFinish:Bool = false;
	var rollPoint:FlxSprite;
	var points:Float = 0;
	var pText:FlxText;

	public static var roll:FlxSprite;

	override public function create()
	{
		pText = new FlxText(0, 0, 0, "", 16, true);
		pText.font = 'assets/data/fonts/statusplz-regular.ttf';

		rollPoint = new FlxSprite(480, 380);
		rollPoint.makeGraphic(16, 16, FlxColor.TRANSPARENT);
		FlxG.camera.color = FlxColor.BLACK;
		FlxG.camera.fade(FlxColor.TRANSPARENT, true);
		super.create();
		bg = new FlxSprite(0, 0, 'assets/images/stage preview.png');
		add(bg);
		add(rollPoint);
		add(pText);

		timer = new FlxTimer();

		// roll.color = FlxColor.fromRGB(245, 227, 163, 255);

		switch (FlxG.random.int(0, 3))
		{
			case 0:
				curKit = 'lilly';
				curRoll = 'assets/images/lillyroll.png';
				curBlanket = 'assets/images/lillyblank.png';
			case 1:
				curKit = 'logo';
				curRoll = 'assets/images/logoroll.png';
				curBlanket = 'assets/images/logoblank.png';
			case 2:
				curKit = 'luna';
				curRoll = 'assets/images/lunaroll.png';
				curBlanket = 'assets/images/lunablank.png';
			case 3:
				curKit = 'artsi';
				curRoll = 'assets/images/artsiroll.png';
				curBlanket = 'assets/images/artsiblank.png';
			case _:
				trace("default :(");
		}
		kitties = new Cat(108, 363, curKit);
		kitties.setGraphicSize(64 + 16);
		kitties.centerOrigin();
		kitties.updateHitbox();
		kitties.centerOffsets();

		roll = new FlxSprite(0, 0);
		roll.loadGraphic(curRoll);
		roll.centerOrigin();
		roll.centerOffsets();

		blanket = new FlxSprite(90, 398);
		blanket.loadGraphic(curBlanket);

		add(blanket);
		add(roll);
		add(kitties);
	}

	function rollLogic(elapsed:Float)
	{
		counter -= elapsed;
		roll.setPosition(kitties.x - 44, kitties.y - 38);

		if (!(kitties.angularVelocity == 0))
			if (counter <= 0)
			{
				if (kitties.angularVelocity < 0)
				{
					roll.angularVelocity = kitties.angularVelocity;
					roll.angularDrag = 1400;
					counter = 0.03;

					roll.height--;
					roll.width--;
				}
				else
				{
					roll.angularVelocity = kitties.angularVelocity;
					roll.angularDrag = 1400;
					counter = 0.08;
					roll.height++;
					roll.width++;
				}
				roll.setGraphicSize(Std.int(roll.width), Std.int(roll.height));
			}
	}

	function doARoll()
	{
		if (kitties.overlaps(rollPoint))
		{
			kitties.rolled = true;
			FlxTween.tween(kitties, {angle: kitties.angle + 20, y: 500}, 0.7, {
				ease: FlxEase.bounceOut,
				onComplete: function(_):Void
				{
					create();

					// reset angle and stuff
				}
			});
		}
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.anyJustPressed([ENTER]))
		{
			var dialogue = new Dialogue(FlxColor.BLACK, "hey :)");
			openSubState(dialogue);
		}
		pText.text = '$points';
		rollLogic(elapsed);
		doARoll();
		super.update(elapsed);
	}
}
