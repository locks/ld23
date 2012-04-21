package  
{
	import org.flixel.*;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	public class CreditsState extends FlxState 
	{
		private var exitButton:FlxButton;
		
		private var Title:FlxText;
		
		public function CreditsState() 
		{
			Title = new FlxText(0, FlxG.camera.height / 3, FlxG.camera.width, "Credits")
			Title.setFormat(null, 16, 0xFFFFFF, "center");
			add(Title);			
			
			exitButton = new FlxButton(FlxG.width/2-40,FlxG.height / 3 + 60, "Main Menu", onExit);
			exitButton.soundOver = null;  //replace with mouseOver sound
			exitButton.color = 0xffD4D943;
			exitButton.label.color = 0xffD8EBA2;
			add(exitButton);
			
			FlxG.mouse.show();
		}
		
		protected function onExit():void
		{
			FlxG.switchState(new MenuState());
		}
		
	}

}