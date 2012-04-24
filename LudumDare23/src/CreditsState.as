package  
{
	import org.flixel.*;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	public class CreditsState extends FlxState 
	{
		[Embed(source = 'data///credits.png')] private var ImgCredits:Class;
		
		private var exitButton:FlxButton;
		
		private var Title:FlxText;
		
		public function CreditsState() 
		{
			add(new FlxSprite(0, 0, ImgCredits));
			
			exitButton = new FlxButton(0, 0, "Main Menu", onExit);
			exitButton.x = FlxG.width - exitButton.width - 10;
			exitButton.y = FlxG.height - exitButton.height - 10;
			add(exitButton);
			
			FlxG.mouse.show();
		}
		
		protected function onExit():void
		{
			FlxG.switchState(new MenuState());
		}
		
	}

}