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
		
		override public function create():void
		{
			_player = new Ship(FlxG.width / 2 - 40, FlxG.height / 2 - 40, _bullets);
			
			add(_player);
			//add(_swarms);
			
			_follow = new Enemy();
			_follow.init(20, 20, _bullets, _gibs, _player);
			add(_follow);
			
			
			//newSwarm(10, 10);
		}
		
		override public function update():void
		{
			
			super.update();
		}
		
		protected  function newSwarm(x:int, y:int):void
		{
			_swarms.add(new FlxSprite(x, y));
			
			for (var i:int = 0; i < 10; i++)
			{
				_swarms.add(new FlxSprite(x + FlxG.random() * 50, y + FlxG.random() * 50));
			}

		}
	}
}

