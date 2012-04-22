package
{
	import org.flixel.*;
	import Enemies.Enemy;
	import org.flixel.plugin.photonstorm.FlxWeapon;

	public class PlayState extends FlxState
	{
		[Embed(source = 'data///crosshair.png')] private var ImgCursor:Class;

		protected var _player:Ship;
		protected var _swarms:FlxGroup;
		
		protected var _follow:Enemy;
		
		protected var _bullets:FlxGroup;
		protected var _gibs:FlxEmitter;
		
		private var _hud:HUD;
		
<<<<<<< HEAD
		private var _curPlanet:Planet;
=======
		private var _cannon:FlxWeapon;
>>>>>>> weapon isnt showing up for some reason
		
		override public function create():void
		
		{
			_curPlanet = new Planet(FlxG.width - 100, FlxG.height - 100, Registry.ImgPlanet1);
			_curPlanet.antialiasing = true;
			add(_curPlanet);
			
			//shrinkPlanet();
			
			_cannon = new FlxWeapon("cannon", _player, "x", "y");
			
			_player = new Ship(FlxG.width / 2 - 40, FlxG.height / 2 - 55, _bullets, _cannon);
			add(_player);
			
			_bullets = new FlxGroup();
			add(_bullets);
			
			_follow = new Enemy();
			_follow.init(20, 20, _bullets, _gibs, _player);
			add(_follow);
			
			_hud = new HUD();
			add(_hud);
			
			FlxG.mouse.load(ImgCursor, 3);
			FlxG.mouse.show();
		}
		
		override public function update():void
		{
			super.update();
		}
		
		private function shrinkPlanet():void
		{
			_curPlanet.scale.x = _curPlanet.scale.y = .5;
		}
	}
}

