package;

import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import openfl.utils.Assets;

class Dialogue extends FlxSubState
{
	var dialogue:FlxText;
	var text:Array<String>;
	var textCool:Array<Array<String>>;

	public function new(bgColor:FlxColor = FlxColor.TRANSPARENT, dialogueText:String)
	{
		super(bgColor);
		text = Assets.getText("source/cool text.txt").split("/");
		textCool = [];
		for (i in text)
		{
			textCool.push(i.split("/"));
		}
		for (i in textCool)
			trace(i);

		dialogue = new FlxText(100, 100, 0, text[1]);
		add(dialogue);
		// boo
	}
}
