package
{

	import org.flixel.*;

	public class MenuState extends FlxState
	{
		
		private var playButton:FlxButton;
		private var devButton:FlxButton;
		private var creditsButton:FlxButton;
		
		private var Title:FlxText;
		
		override public function create():void
		{
			FlxG.bgColor = 0xff000000;
			
			Title = new FlxText(0, FlxG.camera.height / 3, FlxG.camera.width, "LudumDare23")
			Title.setFormat(null, 16, 0xFFFFFF, "center");
			add(Title);
			
			devButton = new FlxButton(FlxG.width/2-40,FlxG.height / 3 + 60, "Insert Site", onSite);
			devButton.soundOver = null;  //replace with mouseOver sound
			devButton.color = 0xffD4D943;
			devButton.label.color = 0xffD8EBA2;
			add(devButton);
			
			playButton = new FlxButton(FlxG.width/2-40,FlxG.height / 3 + 100, "Click To Play", onPlay);
			playButton.soundOver = devButton.soundOver;
			playButton.color = devButton.color;
			playButton.label.color = devButton.label.color;
			add(playButton);
			
			creditsButton = new FlxButton(FlxG.width/2 - 40,FlxG.height / 3 + 100 + playButton.height * 2, "Credits", onCredits);
			creditsButton.soundOver = devButton.soundOver;
			creditsButton.color = devButton.color;
			creditsButton.label.color = devButton.label.color;
			add(creditsButton);
			
			
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
			FlxG.switchState(new GalaxyState());
		}
		
		protected function onCredits():void
		{
			creditsButton.exists = false;
			FlxG.switchState(new CreditsState());
		}
		
		
	}
}

