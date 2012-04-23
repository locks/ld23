package
{
	import Enemies.*;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	import org.flixel.plugin.photonstorm.FlxWeapon;

	public class PlayState extends FlxState
	{
		[Embed(source = 'data///crosshair.png')] private var ImgCursor:Class;

		protected var _player:Ship;
		protected var _swarm:Swarm;
		
		protected var _enemies:FlxGroup;
		
		protected var _bullets:FlxGroup;
		protected var _gibs:FlxEmitter;
		protected var _asplosions:FlxGroup;
		
		private var _hud:HUD;
		
		private var _curPlanet:Planet;
		private var _cannon:FlxWeapon;
		private var _laser:FlxWeapon;
		
		override public function create():void
		{
			_curPlanet = new Planet(FlxG.width - 100, FlxG.height - 100, Registry.ImgPlanet1);
			_curPlanet.antialiasing = true;
			add(_curPlanet);

			shrinkPlanet();
			
			_player = new Ship(FlxG.width / 2 - 40, FlxG.height / 2 - 55, _bullets);
			
			_cannon = new FlxWeapon("cannon", _player);
			_cannon.makePixelBullet(200, 8, 8, 0xFF123456);
			_cannon.group.setAll("antialiasing", true);
			_cannon.setBulletOffset(20, 20);
			_cannon.setBulletLifeSpan(1000);
			_cannon.onPreBulletKill = GrenadeBoom;
			_cannon.setFireRate(1);
			
			_laser = new FlxWeapon("laser", _player);
			_laser.makePixelBullet(200, 6, 6, 0xFF123456);
			_laser.group.setAll("antialiasing", true);
			_laser.setBulletOffset(20, 20);
			_laser.setBulletLifeSpan(1000);
			_laser.setFireRate(1);
			
			add(_cannon.group);
			add(_laser.group);
			add(_player);
			
			_bullets = new FlxGroup();
			
			_enemies = new FlxGroup();
			
			var tmp:Enemy;
			for (var i:int; i < 5; i++)
			{
				tmp = new Enemy();
				tmp.init(FlxU.floor(FlxG.random()*FlxG.camera.width), FlxU.floor(FlxG.random()*FlxG.camera.height), _bullets, _gibs, _player);
				_enemies.add(tmp);
			}
			add(_enemies);
			
			_swarm = new Swarm(FlxU.floor(FlxG.random() * FlxG.camera.width), FlxU.floor(FlxG.random() * FlxG.camera.height), 100, _player);
			add(_swarm);
			
			
			add(_bullets);
			
			_asplosions = new FlxGroup();
			add(_asplosions);
			
			_hud = new HUD();
			add(_hud);
			
			FlxG.mouse.load(ImgCursor, 3);
			FlxG.mouse.show();
		}
		
		override public function update():void
		{
			if (FlxG.mouse.pressed() && _cannon.currentBullet == null) 
			{
				_cannon.group.callAll("kill");
				_laser.setBulletAcceleration(100, 100, 200, 200);
				_laser.setBulletSpeed( 100+FlxU.getDistance(_player.getMidpoint(), new FlxPoint(FlxG.mouse.x, FlxG.mouse.y)) );
				_laser.fireAtMouse();
			}
			else if (FlxG.mouse.justPressed()) 
			{
				_cannon.setBulletAcceleration(100, 100, 200, 200);
				_cannon.setBulletSpeed( 100+FlxU.getDistance(_player.getMidpoint(), new FlxPoint(FlxG.mouse.x, FlxG.mouse.y)) );
				_cannon.fireAtMouse();
			}
			
			else
			{
				_laser.group.callAll("kill");
			}
			
			super.update();
			
		}
		
		private function shrinkPlanet():void
		{
			_curPlanet.scale.x = _curPlanet.scale.y = .5;
		}
		
		public function GrenadeBoom(bullet:FlxObject):void
		{
			var boom:Explosion = _asplosions.recycle(Explosion) as Explosion;
			boom.reset(bullet.x - 2, bullet.y - 2);
			boom.scale.x = boom.scale.y = 2;
			if (FlxU.floor(FlxG.random()*200) % 2 == 0)
			{
				boom.play("Dblue");
			}
			else
			{
				boom.play("Lblue");
			}
			
		}
		
		private function CannonEnemyCollide(haha:FlxObject, lol:FlxObject):void
		{
			haha.kill();
		}
	}
}

