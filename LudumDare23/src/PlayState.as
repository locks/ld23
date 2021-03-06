package
{
	
	import Enemies.*;
	import org.flixel.plugin.photonstorm.FX.*;
	import org.flixel.plugin.photonstorm.FlxSpecialFX;
	import org.flixel.plugin.photonstorm.PNGEncoder;
	
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	import org.flixel.plugin.photonstorm.FlxWeapon;
	import org.flixel.plugin.photonstorm.FlxMath;
	
	import com.increpare.bfxr.Bfxr;

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
		
		protected var sndGrenade:Bfxr;
		protected var sndExplosion:Bfxr;
		protected var sndLaser:Bfxr;

		private var dx:int;
		private var dy:int;
		private var radius:int;

		private var stars:FlxSprite;
		private var starfield:StarfieldFX;
		
		private var levelOver:Boolean;
		private var levelOverTimer:Number = 1;
		
		private var isFiring:Boolean = false;
		
		override public function create():void
		{
			if (FlxG.getPlugin(FlxSpecialFX) == null)
			{
				FlxG.addPlugin(new FlxSpecialFX);
			}
			
			// Creates a 2D scrolling starfield with 200 stars in it, the full screen size
			starfield = FlxSpecialFX.starfield();
			stars = starfield.create(0, 0, FlxG.width, FlxG.height, 200, StarfieldFX.STARFIELD_TYPE_2D);
			add(stars);
			add(starfield.sprite);
			
			_curPlanet = FlxG.getRandom(Registry.Planets) as Planet;
			_curPlanet.reset(FlxG.width - 250, FlxG.height - 250);
			_curPlanet.antialiasing = true;
			_curPlanet.immovable = true;
			_curPlanet.centerOffsets();
			_curPlanet.scale.x = _curPlanet.scale.y = .8;
			add(_curPlanet);
			
			_player = new Ship(FlxG.width / 2 - 40, FlxG.height / 2 - 55, _bullets);
			
			_cannon = new FlxWeapon("cannon", _player);
			//_cannon.makePixelBullet(200, 8, 8, 0xFF123456);
			_cannon.makeAnimatedBullet(2, ImgGrenade, 8, 8, [0,1], 10, true, 20, 20);
			//_cannon.group.setAll("antialiasing", true);
			//_cannon.setBulletOffset(20, 20);
			_cannon.setBulletLifeSpan(1000);
			_cannon.onPreBulletKill = GrenadeBoom;
			_cannon.onFireCallback = lol;
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
			
			sndGrenade = new Bfxr();
			sndGrenade.Load(Registry.strGrenadeExplosion);
			sndGrenade.CacheMutations(0.05, 2);
			
			sndExplosion = new Bfxr();
			sndExplosion.Load(Registry.strExplosion);
			sndExplosion.CacheMutations(0.05, 5);
			
			sndLaser = new Bfxr();
			sndLaser.Load(Registry.strLaser);
			sndLaser.CacheMutations(0.05, 5);
			
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
				isFiring = true;
			}
			else 
			{
				isFiring = false;
			}
			
			if (FlxG.mouse.pressed()) 
			{
				Registry.Energy -= 1;
				sndLaser.Play(0.3);
				_laser.fireAtMouse();
				isFiring = true;
			}
			else
			{
				isFiring = false;
				_laser.group.callAll("kill");
			}
			
			if (levelOver)
			{
				Registry.Energy = 1500;
				levelOverTimer -= FlxG.elapsed;
				if (levelOverTimer <= 0)
					FlxG.switchState(new ScoreState());
			}
			
			if (Registry.Energy <= 0)
			{
				FlxG.switchState(new GameOverState());
			}
			
			if (isFiring == false && Registry.Energy < 1500)
			{
				Registry.Energy += 1.5;
			}
			
			super.update();
			
			//FlxG.collide(_cannon.group, _enemies, CannonEnemyCollide);
			//FlxG.collide(_asplosions, _enemies, CannonEnemyCollide);
			if (_curPlanet.isShrunk() == true)
			{
				FlxG.overlap(_player, _curPlanet, collectPlanet);
			}
			else
			{
				FlxG.overlap(_laser.group, _swarm, LaserSwarmCollide);
				FlxG.overlap(_laser.group, _enemies, LaserObjectCollide);
				FlxG.overlap(_laser.group, _curPlanet, LaserPlanetCollide);
				FlxG.overlap(_bullets, _player, playerHit);
				FlxG.overlap(_swarm, _player, playerHit);
			}
			
			
		}
		
		public function GrenadeBoom(bullet:FlxObject):void
		{
			var boom:Grenade = _asplosions.recycle(Grenade) as Grenade;
			boom.reset(bullet.x - boom.width / 2, bullet.y -  boom.height / 2);
				
			sndGrenade.Play();
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
			if (swarmlet.health <= 25)
			{
				var boom:Explosion = _asplosions.recycle(Explosion) as Explosion;
				boom.reset(swarmlet.x - boom.width / 2, swarmlet.y -  boom.height / 2);
				boom.explode("small");
				sndExplosion.Play(0.5);
				swarmlet.hurt(25);
			}
			else
			{
				swarmlet.hurt(25);
				sndExplosion.Play(0.3);
			}
		}
		
		private function GrenadeObjectCollide(grenade:Grenade, enemy:FlxObject):void
		{
			if (enemy.health <= 30)
			{
				var boom:Explosion = _asplosions.recycle(Explosion) as Explosion;
				boom.reset(enemy.x - boom.width / 2, enemy.y -  boom.height / 2);
				boom.explode("large");
				sndExplosion.Play(0.8);
				enemy.hurt(30);
			}
			else 
			{
				sndExplosion.Play(0.3);
				enemy.hurt(20);
			}
		}
		
		private function LaserSwarmCollide(laser:FlxObject, swarmlet:Swarmlet):void
		{
			if (swarmlet.health <= 1)
			{
				var boom:Explosion = _asplosions.recycle(Explosion) as Explosion;
				boom.reset(swarmlet.x - boom.width / 2, swarmlet.y -  boom.height / 2);
				boom.explode("small");
				sndExplosion.Play(0.2);
				swarmlet.kill();
			}
			swarmlet.hurt(1);
		}
		
		private function LaserObjectCollide(laser:FlxObject, enemy:FlxObject):void
		{
			if (enemy.health <= 1)
			{
				var boom:Explosion = _asplosions.recycle(Explosion) as Explosion;
				boom.reset(enemy.x - boom.width / 2, enemy.y -  boom.height / 2);
				boom.explode("large");
				sndExplosion.Play(0.5);
				enemy.kill();
			}
			enemy.hurt(1);
		}
		
		private function LaserPlanetCollide(laser:FlxObject, planet:Planet):void
		{
			dx = laser.x - planet.getMidpoint().x;
			dy = laser.y - planet.getMidpoint().y;
			radius = 100 * planet.scale.x;
			
			//collision check for laser and planet
			if (dx*dx+dy*dy < radius*radius) 
			{
				laser.kill();
				planet.shrink();
			}
		}
		
		private function collectPlanet(ship:Ship, planet:Planet):void
		{
			planet.kill();
			ship.play("charge");
			levelOver = true;
			FlxG.score += 5000;
		}
		
		override public function destroy():void
		{
			//	Important! Clear out the plugin, otherwise resources will get messed right up after a while
			FlxSpecialFX.clear();

			super.destroy();
		}
		
		private function playerHit(object1:FlxObject, Object2:FlxObject):void
		{
			if (object1.ID = 1)
			{
				Registry.Energy -=50;
				object1.kill();
			}
			else
			{
				Registry.Energy -= 0.000000001;
				object1.kill();
			}
		}
		
		private function lol():void
		{
			Registry.Energy -= 100;
		}
	}
}

