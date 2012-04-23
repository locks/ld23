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
		
		[Embed(source = "data/panel_one.mp3")]private var sndPanelOne:Class;
		[Embed(source = "data/panel_two.mp3")]private var sndPanelTwo:Class;

		
		private var background:FlxGroup;
		private var BG:FlxSprite;
		private var Counter:int = 0;
		
		private var text:FlxText;
		
		private var dialogue:FlxSound;
		
		override public function create():void
		{
			BG = new FlxSprite(0, 0, Img1);
			
			background = new FlxGroup();
			background.add(BG);
			add(background);
			
			text = new FlxText(0, 0, FlxG.width, "Press spacebar");
			text.alignment = "right";
			add(text);
			
			dialogue = new FlxSound();
			dialogue.loadEmbedded(sndPanelOne);
			dialogue.play();
		}
		
		override public function update():void
		{
			if (FlxG.keys.justPressed("SPACE"))
			{
				Counter++;
			}
			if (Counter == 1)
			{
				BG = new FlxSprite(0, 0, Img2);
				background.add(BG);
				Counter++;
				
				dialogue.stop();
				dialogue.loadEmbedded(sndPanelTwo);
				dialogue.play();
			}
			if (Counter == 3)
			{
				dialogue.stop();
				//text = new FlxText(0, 0, FlxG.width, "loading ...");
				text.text = "loading ...";
				FlxG.switchState(new PlayState());
			}
		}
	}

}