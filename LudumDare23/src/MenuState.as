package
{

	import org.flixel.*;

	public class MenuState extends FlxState
	{
		
		private var playButton:FlxButton;
		private var devButton:FlxButton;
		private var Title:FlxText;
		
		override public function create():void
		{
			FlxG.bgColor = 0xff000000;
			
			Title = new FlxText(0, FlxG.camera.height / 3, FlxG.camera.width, "Shr1nk")
			Title.setFormat(null, 16, 0xFFFFFF, "center", 0x333333);
			add(Title);
			
			devButton = new FlxButton(FlxG.width/2-40,FlxG.height / 3 + 60, "Insert Site", onSite);
			devButton.soundOver = null;  //replace with mouseOver sound
			add(devButton);
			
			playButton = new FlxButton(FlxG.width/2-40,FlxG.height / 3 + 100, "Click To Play", onPlay);
			playButton.soundOver = devButton.soundOver;
			playButton.color = devButton.color;
			playButton.label.color = devButton.label.color;
			add(playButton);
			
			
			FlxG.mouse.show();
			
		}
		
		override public function update():void
		{
			if (FlxG.keys.X && FlxG.keys.C) onPlay();
			
			super.update();	
		}
		
		protected function onSite():void
		{
			
			FlxU.openURL("http://example.com/");  //replace with your site's URL 
		}
		
		protected function onPlay():void
		{
			playButton.exists = false;
			FlxG.switchState(new PlayState());
		}
		
		
	}
}

