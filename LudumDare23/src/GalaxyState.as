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
		[Embed(source = 'data///galaxyBackground.png')] private var imgGalaxy:Class;

		private var _bkgA:FlxSprite;
		private var _bkgB:FlxSprite;

		private var background:FlxGroup;
		
		private var playButton:FlxButton;
		private var Title:FlxText;
		
		private var _doubleClick:int = 0;
		
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
			
			SetUpBackground();
		}
		
		override public function update():void
		{
			if (_doubleClick == 2)
				onLevelSelected();
			
			if (FlxG.keys.X && FlxG.keys.C) onLevelSelected();
			if (FlxG.mouse.pressed()) {
				_doubleClick++;
			} else {
				_doubleClick = 0;
			}
			
			super.update();	
		}
		
		private function SetUpBackground():void 
		{
			background = new FlxGroup();
			
			_bkgA = new FlxSprite(0, 0, imgGalaxy);

			background.add(_bkgA);
			add(background);
		}
		
		protected function onLevelSelected():void
		{
			FlxG.switchState(new PlayState());
		}
		
	}

}