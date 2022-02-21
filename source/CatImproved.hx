package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class CatImp extends FlxTypedGroup<FlxSprite>
{
	public var type:String;

	var idleFr:Array<Int>;
	var counter:Float = 0.06;
	var finFr:Array<Int>;

	public var cat:FlxSprite;

	var roll:FlxSprite;
	var blanket:FlxSprite;
	var X:Float;
	var Y:Float;

	public var catAngle:Float;
	public var movObj:Array<FlxSprite>;
	public var rolled:Bool = false;

	public function new(x:Float, y:Float, type:String)
	{
		super();

		this.type = type;
		for (i in this)
		{
			i.x = x;
			i.y = y;
			i.drag.x = 1400;
		}
		this.X = x;
		this.Y = y;

		switch (type)
		{
			case 'logo':
				idleFr = [2];
				finFr = [3];
			case 'lilly':
				idleFr = [0];
				finFr = [1];
			case 'luna':
				idleFr = [4];
				finFr = [5];
			case 'artsi':
				idleFr = [6];
				finFr = [7];
			case _:
				return;
		}

		cat = new FlxSprite(0, 0);
		cat.loadGraphic("assets/images/playstate/kit_she.png", true);
		blanket = new FlxSprite(90, 398);
		blanket.loadGraphic('assets/images/playstate/${type}blank.png');
		roll = new FlxSprite(0, 0);
		roll.loadGraphic('assets/images/playstate/${type}roll.png');

		this.rolled = false;

		cat.animation.add('catgud', idleFr, 1, false);
		cat.animation.add('cat rolled', finFr, 1, false);
		cat.antialiasing = false;

		resetCat();

		this.add(blanket);
		this.add(roll);
		this.add(cat);

		movObj = [cat, roll];
	}

	public function resetCat()
	{
		cat.setGraphicSize(80);
		cat.setPosition(108, 338);
		cat.centerOrigin();
		cat.updateHitbox();
		cat.centerOffsets();

		roll.centerOrigin();
		roll.centerOffsets();
		roll.setPosition(cat.x - 44, cat.y - 38);

		rolled = false;
	}

	function movement()
	{
		var rRight = FlxG.keys.anyPressed([RIGHT, D]);
		var rLeft = FlxG.keys.anyPressed([LEFT, A]);

		for (i in movObj)
		{
			if (rRight)
			{
				if (this.type == 'luna')
				{
					cat.velocity.x = i.velocity.x + 125;
					i.angularVelocity = 140;
				}
				else
				{
					i.velocity.x = i.velocity.x + 115;
					i.angularVelocity = 120;
				}
			}
			else if (rLeft)
			{
				i.velocity.x = i.velocity.x - 115;
				i.angularVelocity = -120;
			}
			else
				i.angularVelocity = 0;

			if (!rolled)
				cat.animation.play('catgud');
			else
			{
				cat.animation.play('cat rolled');
				i.velocity.x = 0;
			}
		}
	}

	function rollLogic(elapsed:Float)
	{
		counter -= elapsed;
		roll.setPosition(cat.x - 44, cat.y - 38);

		if (!(cat.angularVelocity == 0))
			if (counter <= 0)
			{
				if (cat.angularVelocity < 0)
				{
					roll.angularVelocity = cat.angularVelocity;
					roll.angularDrag = 1400;
					counter = 0.08;

					roll.height--;
					roll.width--;
				}
				else
				{
					roll.angularVelocity = cat.angularVelocity;
					roll.angularDrag = 1400;
					counter = 0.08;
					roll.height++;
					roll.width++;
				}
				roll.setGraphicSize(Std.int(roll.width), Std.int(roll.height));
			}
	}

	override public function update(elapsed:Float)
	{
		rollLogic(elapsed);
		catAngle = cat.angularVelocity;
		movement();
		super.update(elapsed);
	}
}
