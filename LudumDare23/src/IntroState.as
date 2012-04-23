package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Deviantgeek
	 */
	public class IntroState extends FlxState
	{
		[Embed(source = "data/intro1.png")]private var Img1:Class;
		[Embed(source = "data/title2I'm not bothering with anatomy.png")]private var Img2:Class;
		private var BG:FlxSprite;
		private var Counter:int = 0;
		
		override public function create():void
		{
			BG = new FlxSprite(0, 0, Img1);
			add(BG);
		}
		
		override public function update():void
		{
			if (FlxG.keys.justPressed("ENTER"))
			{
				Counter++;
			}
			if (Counter == 1)
			{
				BG = new FlxSprite(0, 0, Img2);
				add(BG);
				Counter++;
			}
			if (Counter == 3)
			{
				FlxG.switchState(new PlayState());
			}
		}
	}

}