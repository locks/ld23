package
{
	import Enemies.*;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	import org.flixel.plugin.photonstorm.FlxWeapon;

	public class PlayState extends FlxState
	{
		[Embed(source = 'data///crosshair.png')] private var ImgCursor:Class;
		[Embed(source = 'data///laserAnim.png')] private var ImgLaser:Class;
		[Embed(source = 'data///grenade.png')] private var ImgGrenade:Class;

		protected var _player:Ship;
		protected var _swarm:Swarm;
		
		protected var _enemies:FlxGroup;
		
		protected var _bullets:FlxGroup;
		protected var _gibs:FlxEmitter;
		protected var _asplosions:FlxGroup;
		
		protected var _grenade:FlxSprite;
		
		private var _hud:HUD;
		
		private var _curPlanet:Planet;
		private var _cannon:FlxWeapon;
		private var _laser:FlxWeapon;
		
		override public function create():void
		{
			_curPlanet = new Planet(FlxG.width - 200, FlxG.height - 200, Registry.ImgPlanet1);
			_curPlanet.antialiasing = true;
			_curPlanet.immovable = true;
			_curPlanet.height = 80;
			_curPlanet.width   = 80;
			_curPlanet.centerOffsets();
			add(_curPlanet);
			
			shrinkPlanet();
			
			_player = new Ship(FlxG.width / 2 - 40, FlxG.height / 2 - 55, _bullets);
			_player.allowCollisions = 0;
			
			_cannon = new FlxWeapon("cannon", _player);
			//_cannon.makePixelBullet(200, 8, 8, 0xFF123456);
			_cannon.makeAnimatedBullet(2, ImgGrenade, 8, 8, [0,1], 10, true, 20, 20);
			//_cannon.group.setAll("antialiasing", true);
			//_cannon.setBulletOffset(20, 20);
			_cannon.setBulletLifeSpan(1000);
			_cannon.onPreBulletKill = GrenadeBoom;
			_cannon.setFireRate(1000);
			
			//var boom:Explosion = _asplosions.recycle(Explosion) as Explosion;
			//boom.reset(bullet.x - 2, bullet.y - 2);
			//
			//boom.scale.x = boom.scale.y = 2;
			//boom.width = boom.scale.x * 2;
			//boom.height = 2;
			
			_laser = new FlxWeapon("laser", _player);
			//_laser.makePixelBullet(200, 6, 6, 0xFF123456);
			_laser.makeAnimatedBullet(200, ImgLaser, 6, 6, [1, 2, 3, 4, 5, 6], 30, true, 20, 20);
			_laser.group.setAll("antialiasing", true);
			_laser.setBulletOffset(20, 20);
			_laser.setBulletSpeed(200);
			_laser.setBulletLifeSpan(1000);
			
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
			if (FlxG.keys.SPACE) 
			{
				_cannon.setBulletAcceleration(200, 200, 300, 300);
				_cannon.setBulletSpeed( 100 + FlxU.getDistance(_player.getMidpoint(), new FlxPoint(FlxG.mouse.x, FlxG.mouse.y)) );
				_cannon.fireAtMouse();
			}
			
			if (FlxG.mouse.pressed()) 
			{
				_laser.fireAtMouse();
			}
			else
			{
				_laser.group.callAll("kill");
			}
			
			super.update();
			
			//FlxG.collide(_cannon.group, _enemies, CannonEnemyCollide);
			//FlxG.collide(_asplosions, _enemies, CannonEnemyCollide);
			FlxG.collide(_laser.group, _swarm, LaserSwarmCollide);
			FlxG.overlap(_laser.group, _curPlanet, LaserPlanetCollide);
		}
		
		private function shrinkPlanet():void
		{
			_curPlanet.scale.x = _curPlanet.scale.y = .5;
		}
		
		public function GrenadeBoom(bullet:FlxObject):void
		{
			var boom:Grenade = _asplosions.recycle(Grenade) as Grenade;
			boom.reset(bullet.x - boom.width / 2, bullet.y -  boom.height / 2);
				
			boom.detonate();
			
			FlxG.overlap(boom, _enemies, GrenadeObjectCollide);
			FlxG.overlap(boom, _swarm, GrenadeSwarmCollide);
			//FlxG.collide(boom, _swarm, LaserSwarmCollide);
		}
		
		private function CannonEnemyCollide(haha:FlxObject, lol:FlxObject):void
		{
			haha.kill();
			lol.kill();
		}
		
		private function GrenadeSwarmCollide(grenade:Grenade, swarmlet:Swarmlet):void
		{
			var boom:Explosion = _asplosions.recycle(Explosion) as Explosion;
			boom.reset(swarmlet.x - boom.width / 2, swarmlet.y -  boom.height / 2);
			
			boom.explode("small");

			swarmlet.kill();
		}
		
		private function GrenadeObjectCollide(grenade:Grenade, enemy:FlxObject):void
		{
			var boom:Explosion = _asplosions.recycle(Explosion) as Explosion;
			boom.reset(enemy.x - boom.width / 2, enemy.y -  boom.height / 2);
			
			boom.explode("large");
			
			enemy.kill();
		}
		
		private function LaserSwarmCollide(laser:FlxObject, swarmlet:Swarmlet):void
		{
			//laser.kill();
			
			var boom:Explosion = _asplosions.recycle(Explosion) as Explosion;
			boom.reset(swarmlet.x - boom.width / 2, swarmlet.y -  boom.height / 2);
			
			boom.explode("small");

			swarmlet.kill();
		}
		
		private function LaserPlanetCollide(laser:FlxObject, planet:Planet):void
		{
			//laser.kill();
			
			planet.shrink();
			
			//planet.scale.x = 0.01 + 0.01 * planet.health ;
			//planet.scale.y = 0.01 + 0.01 * planet.health ;
			//shrinkPlanet(0.9);
		}
	}
}

