package;

import flixel.FlxG;
import flixel.FlxSprite;

class Cat extends FlxSprite
{
	public var type:String;

	var idleFr:Array<Int>;
	var counter:Float = 0.06;
	var finFr:Array<Int>;

	public var catAngle:Float;

	public var rolled:Bool = false;

	override public function new(x:Float, y:Float, type:String)
	{
		super();

		this.type = type;
		this.x = x;
		this.y = y;
		this.drag.x = 1400;
		this.loadGraphic("assets/images/playstate/kit_she.png", true);

		switch (this.type)
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

		this.animation.add('catgud', idleFr, 1, false);
		this.animation.add('cat rolled', finFr, 1, false);

		this.antialiasing = false;
	}

	function movement()
	{
		var rRight = FlxG.keys.anyJustPressed([RIGHT, D]);
		var rLeft = FlxG.keys.anyJustPressed([LEFT, A]);

		if (rRight)
		{
			if (this.type == 'luna')
			{
				this.velocity.x = this.velocity.x + 125;
				this.angularVelocity = 140;
			}
			else
			{
				this.velocity.x = this.velocity.x + 115;
				this.angularVelocity = 120;
			}
		}
		else if (rLeft)
		{
			this.velocity.x = this.velocity.x - 115;
			this.angularVelocity = -120;
		}
		else
			this.angularVelocity = 0;

		if (!rolled)
			this.animation.play('catgud');
		else
		{
			this.animation.play('cat rolled');
			this.velocity.x = 0;
		}
	}

	override public function update(elapsed:Float)
	{
		catAngle = this.angularVelocity;
		movement();
		super.update(elapsed);
	}
}
