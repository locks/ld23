package
{
	import org.flixel.*;
	import Enemies.Enemy;
	import org.flixel.plugin.photonstorm.FlxWeapon;

	public class PlayState extends FlxState
	{
		protected var _player:Ship;
		protected var _swarms:FlxGroup;
		
		protected var _follow:Enemy;
		
		protected var _bullets:FlxGroup;
		protected var _gibs:FlxEmitter;
		
		private var _hud:HUD;
		
		private var _cannon:FlxWeapon;
		
		override public function create():void
		{
			
			_player = new Ship(FlxG.width / 2 - 40, FlxG.height / 2 - 55, _bullets);
			
			_cannon = new FlxWeapon("cannon", _player);
			_cannon.makePixelBullet(20, 4, 4, 0xFF123456);
			_cannon.setFireRate(1000);
			
			add(_cannon.group);
			add(_player);
			
			_bullets = new FlxGroup();
			add(_bullets);
			
			_follow = new Enemy();
			_follow.init(20, 20, _bullets, _gibs, _player);
			add(_follow);
			
			_hud = new HUD();
			add(_hud);

			Registry.Fuel = 14;
		}
		
		override public function update():void
		{
			if (FlxG.mouse.justPressed()) {
				_cannon.setBulletAcceleration(100, 100, 200, 200);
				_cannon.setBulletSpeed( 100 + FlxU.getDistance(_player.getMidpoint(), new FlxPoint(FlxG.mouse.x, FlxG.mouse.y)) );
				_cannon.fireAtMouse();
			}
			
			super.update();
		}
		
	}
}

