package
{
	import org.flixel.*;
	import Enemies.Enemy;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	import org.flixel.plugin.photonstorm.FlxWeapon;

	public class PlayState extends FlxState
	{
		[Embed(source = 'data///crosshair.png')] private var ImgCursor:Class;

		protected var _player:Ship;
		protected var _swarms:FlxGroup;
		
		protected var _follow:Enemy;
		
		protected var _bullets:FlxGroup;
		protected var _gibs:FlxEmitter;
		protected var _asplosions:FlxGroup;
		
		private var _hud:HUD;
		
		private var _curPlanet:Planet;
		private var _cannon:FlxWeapon;
		
		override public function create():void
		
		{
			_curPlanet = new Planet(FlxG.width - 100, FlxG.height - 100, Registry.ImgPlanet1);
			_curPlanet.antialiasing = true;
			add(_curPlanet);

			shrinkPlanet();
			
			_player = new Ship(FlxG.width / 2 - 40, FlxG.height / 2 - 55, _bullets);
			
			_cannon = new FlxWeapon("cannon", _player);
			_cannon.makePixelBullet(20, 4, 4, 0xFF123456);
			_cannon.setBulletOffset(20, 20);
			_cannon.setBulletLifeSpan(1000);
			_cannon.onPreBulletKill = GrenadeBoom;
			_cannon.setFireRate(1000);
			
			add(_cannon.group);
			add(_player);
			
			_bullets = new FlxGroup();
			
			_follow = new Enemy();
			_follow.init(20, 20, _bullets, _gibs, _player);
			add(_follow);
			add(_bullets);
			
			
			
			_asplosions = new FlxGroup();
			
			_hud = new HUD();
			add(_hud);
			
			FlxG.mouse.load(ImgCursor, 3);
			FlxG.mouse.show();
		}
		
		override public function update():void
		{
			if (FlxG.mouse.justPressed()) 
			{
				_cannon.setBulletAcceleration(100, 100, 200, 200);
				_cannon.setBulletSpeed( 100+FlxU.getDistance(_player.getMidpoint(), new FlxPoint(FlxG.mouse.x, FlxG.mouse.y)) );
				_cannon.fireAtMouse();
				
			}
			
			
			super.update();
		}
		
		private function shrinkPlanet():void
		{
			_curPlanet.scale.x = _curPlanet.scale.y = .5;
		}
		
		public function GrenadeBoom():void
		{
			FlxG.log("yays");
			//var boom:Explosion = _asplosions.recycle(Explosion) as Explosion;
			var boom:Explosion = new Explosion;
			FlxG.log(boom.x)
			boom.x = (5);
			boom.y = (5);
		}
	}
}

