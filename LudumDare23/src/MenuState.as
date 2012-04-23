package
{
	import com.increpare.bfxr.Bfxr;
	import org.flixel.*;

	public class MenuState extends FlxState
	{
		[Embed(source = 'data///titleBackground.png')]private var ImgBackground:Class;
		[Embed(source = "data/team.png")]private var ImgTeam:Class;
		[Embed(source = 'data///titleBackground.png')] private var imgBackground:Class;
		[Embed(source = 'data///shr1nkFinal.mp3')] private var sndTitle:Class;
	
		private const strClick:String = ",0.5,,0.1943,,0.1338,0.3,0.2706,,,,,,,,,,,,,0.1321,,,,,1,,,0.1,,,,masterVolume";
		public  var sndClick:Bfxr = new Bfxr();
		
		private var playButton:FlxButton;
		private var devButton:FlxButton;
		private var creditsButton:FlxButton;
		
		private var Title:FlxText;
		
		override public function create():void
		{
			FlxG.bgColor = 0xff000000;
			
			add(new FlxSprite(0, 0, ImgBackground));
			add(new FlxSprite(FlxG.width-140, 0, ImgTeam));
			
			Title = new FlxText(0, 0, FlxG.camera.width, "Shr1nk")
			Title.setFormat(null, 16, 0xFFFFFF, "left", 0x333333);
			add(Title);
			
			FlxG.play(sndTitle);
			
			sndClick = new Bfxr();
			sndClick.Load(Registry.strClick);
			sndClick.CacheMutations(0.05, 10);	//cache 5 mutations
			
			devButton = new FlxButton(FlxG.width / 2 - 40, FlxG.height / 3 + 60, "Insert Site", onSite);
			devButton.x = FlxG.width - devButton.width - 10;
			devButton.soundOver = null;  //replace with mouseOver sound
			add(devButton);
			
			playButton = new FlxButton(FlxG.width/2-40,FlxG.height / 3 + 100, "Click To Play", onPlay);
			playButton.x = FlxG.width - playButton.width - 10;
			playButton.soundOver = devButton.soundOver;
			playButton.color = devButton.color;
			playButton.label.color = devButton.label.color;
			add(playButton);
			
			creditsButton = new FlxButton(FlxG.width/2 - 40,FlxG.height / 3 + 100 + playButton.height * 2, "Credits", onCredits);
			creditsButton.x = FlxG.width - creditsButton.width - 10;
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
			sndClick.Play(0.5);
			FlxG.switchState(new GalaxyState());
		}
		
		protected function onCredits():void
		{
			creditsButton.exists = false;
			sndClick.Play(0.5);
			FlxG.switchState(new CreditsState());
		}
		
		
	}
}

