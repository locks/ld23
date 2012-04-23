package  
{
	import org.flixel.*;
	
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Ricardo Mendes
	 */
	public class ScoreState extends FlxState 
	{
		[Embed(source = 'data///galaxyBackground.png')] private var ImgGalaxy:Class;
		
		private var background:FlxGroup;
		private var titleText:FlxText;
		
		private var btnContinue:FlxButton;
		
		public function ScoreState() 
		{
			background = new FlxGroup();
			background.add(new FlxSprite(0, 0, ImgGalaxy));
			add(background);
			
			titleText = new FlxText(0, 10, FlxG.width, "SCORE");
			titleText.alignment = "center";
			titleText.size = 20;
			add(titleText);
			
			btnContinue = new FlxButton(FlxG.width, FlxG.height , "Next Level", onPlay);
			btnContinue.x -= btnContinue.width + 10;
			btnContinue.y -= btnContinue.height + 10;
			add(btnContinue);
		}
		
		protected function onPlay():void
		{
			btnContinue.exists = false;
			FlxG.switchState(new PlayState());
		}
		
	}

}