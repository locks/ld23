package  
{
	import org.flixel.*;
	import org.flixel.FlxState;
	
	/**
	 * ...
	 * @author Ricardo Mendes
	 */
	public class GalaxyState extends FlxState 
	{
		private var playButton:FlxButton;
		
		private var Title:FlxText;
		
		override public function create():void
		{
			Title = new FlxText(0, FlxG.camera.height / 3, FlxG.camera.width, "Level Select")
			Title.setFormat(null, 16, 0xFFFFFF, "center");
			add(Title);
			
			playButton = new FlxButton(FlxG.width/2-40,FlxG.height / 3 + 100, "Click To Play", onLevelSelected);
			playButton.soundOver = null;  //replace with mouseOver sound
			playButton.color = 0xffD4D943;
			playButton.label.color = 0xffD8EBA2;
			add(playButton);
			
		}
		
		override public function update():void
		{
			if (FlxG.keys.X && FlxG.keys.C) onLevelSelected();
			
			super.update();	
		}
		
		protected function onLevelSelected():void
		{
			FlxG.switchState(new PlayState());
		}
		
		
	}

}