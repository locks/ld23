package  
{
	import flash.geom.Point;
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

		private var _background:FlxGroup;
		private var _planets:FlxGroup;
		
		private var _mouseCollision:FlxObject;
		
		private var playButton:FlxButton;
		private var Title:FlxText;
		
		private var _doubleClick:int = 0;
		
		private var _curPlanet:Planet;
		
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
			
			_mouseCollision = new FlxObject(0, 0, 40, 40);
			
			setUpBackground();
			generatePlanets();
		}
		
		override public function update():void
		{
			for each (var planet:Planet in _planets)
			{
				if (FlxG.mouse.x > planet.x && FlxG.mouse.x < planet.x + planet.width && FlxG.mouse.y > planet.y && FlxG.mouse.y < planet.y) {
					planet.scale = new FlxPoint(0.12, 0.12);
				} else {
					planet.scale.x = 0.05;
					planet.scale.y = 0.05;
				}
			}
			
			_mouseCollision.x = FlxG.mouse.x;
			_mouseCollision.y = FlxG.mouse.y;
			FlxG.overlap(_planets, _mouseCollision, onPlanetSelected);
			
			if (FlxG.keys.X && FlxG.keys.C) onLevelSelected();
			
			super.update();
		}
		
		private function generatePlanets():void
		{
			_planets = new FlxGroup();
			
			var move:int = 50;
			var i:int = 1;
			for each (var planet:Planet in Registry.Planets)
			{
				planet.x = move * i;
				planet.y = move * i;
				
				planet.scale.x = 0.1;
				planet.scale.y = 0.1;
				
				planet.width *= planet.scale.x;
				planet.height *= planet.scale.y;
				
				i++;
				
				_planets.add(planet);
			}
			
			add(_planets);
		}
		
		private function setUpBackground():void 
		{
			_background = new FlxGroup();
			
			_bkgA = new FlxSprite(0, 0, imgGalaxy);

			_background.add(_bkgA);
			add(_background);
		}
		
		protected function onLevelSelected():void
		{
			FlxG.switchState(new PlayState());
		}
		
		protected function onPlanetSelected(planet:Planet, mouse:FlxObject):void
		{
			Registry.CurrentPlanet = planet;
			Registry.CurrentPlanet.scale.x = 0.2;
			Registry.CurrentPlanet.scale.y = 0.2;
			FlxG.log(Registry.CurrentPlanet);
		}
		
		
	}

}