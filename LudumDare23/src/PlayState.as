package
{
	import org.flixel.*;
	import Enemies.Enemy;

	public class PlayState extends FlxState
	{
		protected var _player:Ship;
		protected var _swarms:FlxGroup;
		
		protected var _follow:Enemy;
		
		protected var _bullets:FlxGroup;
		protected var _gibs:FlxEmitter;
		
		private var _sf:StarField;
		private var _hud:HUD;
		
		override public function create():void
		{
			
			_sf = new StarField();
			add(_sf);
			
			_player = new Ship(FlxG.width / 2 - 40, FlxG.height / 2 - 55, _bullets);
			add(_player);
			
			_bullets = new FlxGroup();
			add(_bullets);
			
			_follow = new Enemy();
			_follow.init(20, 20, _bullets, _gibs, _player);
			add(_follow);
			
			_hud = new HUD();
			add(_hud)

			Registry.Fuel = 14;
		}
		
		override public function update():void
		{
			super.update();
		}
		
	}
}

