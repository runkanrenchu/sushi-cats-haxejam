import flash.Lib;
import flash.display.*;
import flixel.system.FlxBasePreloader;
import flixel.system.FlxPreloader;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.text.Font;
import openfl.text.TextField;
import openfl.text.TextFormat;

@:font("assets/data/fonts/lowbatt.ttf") class LowbattFont extends Font {}
@:bitmap("assets/preloader/ng_preloader.png") class NGPreloaderLogo extends BitmapData {}

class Preloader extends FlxBasePreloader
{
	var bar:Bitmap;
	var pldimg:Sprite;
	var text:TextField;

	public function new(minDisplayTime:Float = 0)
	{
		super(0);
	}

	override public function create()
	{
		this._width = Lib.current.stage.stageWidth;
		this._height = Lib.current.stage.stageHeight;

		var ratio:Float = this._width / 900;

		Font.registerFont(LowbattFont);
		pldimg = new Sprite();
		pldimg.addChild(new Bitmap(new NGPreloaderLogo(0, 0)));
		pldimg.x = 170;
		pldimg.y = 100;
		pldimg.scaleX = pldimg.scaleY = ratio;

		text = new TextField();
		text.defaultTextFormat = new TextFormat("Lowbatt", 24, 0xFFFFFFFF);
		text.text = "Loading...";
		text.x = 260;
		text.y = 400;
		trace(text.x);
		trace(text.y);

		bar = new Bitmap(new BitmapData(1, 7, false, 0xffae00));
		addChild(bar);
		addChild(pldimg);
		addChild(text);

		super.create();
	}

	override public function update(Percent:Float):Void
	{
		bar.scaleX = Percent * (_width - 8);
	}
}
