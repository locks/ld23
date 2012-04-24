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
	public class GameOverState extends FlxState 
	{
		[Embed(source = 'data///gameOver.png')] private var ImgGameOver:Class;
		[Embed(source = 'data///gameOverYeah.mp3')] private var sndGameOver:Class;
		
		private var background:FlxGroup;
		private var titleText:FlxText;
		private var scoreText:FlxText;
		
		private var btnContinue:FlxButton;
		
		public function GameOverState() 
		{
			background = new FlxGroup();
			background.add(new FlxSprite(0, 0, ImgGameOver));
			add(background);
			
			scoreText = new FlxText(0, FlxG.height  - 80, FlxG.width - 10, "score: " + FlxG.score.toString());
			//scoreText.y -= scoreText.height + 5;
			//scoreText.color = 0xFF000000;
			scoreText.size = 20;
			scoreText.alignment = "right";
			add(scoreText);
			
			btnContinue = new FlxButton(FlxG.width, FlxG.height , "Menu", onPlay);
			btnContinue.x -= btnContinue.width + 10;
			btnContinue.y -= btnContinue.height + 10;
			add(btnContinue);
			
			FlxG.play(sndGameOver);
		}
		
		protected function onPlay():void
		{
			btnContinue.exists = false;
			FlxG.switchState(new MenuState());
		}
		
	}

}