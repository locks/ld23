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
		
		private var _hud:HUD;
		
		private var _curPlanet:Planet;
		
		override public function create():void
		{
			_curPlanet = new Planet(FlxG.width - 100, FlxG.height - 100, Registry.ImgPlanet1);
			add(_curPlanet);
			
			shrinkPlanet();
			
			_player = new Ship(FlxG.width / 2 - 40, FlxG.height / 2 - 55, _bullets);
			add(_player);
			
			_bullets = new FlxGroup();
			add(_bullets);
			
			_follow = new Enemy();
			_follow.init(20, 20, _bullets, _gibs, _player);
			add(_follow);
			
			_hud = new HUD();
			add(_hud)
			
			
		}
		
		override public function update():void
		{
			super.update();
		}
		
		private function shrinkPlanet():void
		{
			_curPlanet.scale.x = _curPlanet.scale.y = .5;
			_curPlanet.x -= 150;
			_curPlanet.y -= 125;
		}
	}
}

