package
{

	import org.flixel.*;

	public class PlayState extends FlxState
	{
		private var _ship:Ship;
		
		override public function create():void
		{
			_ship = new Ship(FlxG.width / 2 - 40, FlxG.height / 2 - 40)
			add(_ship);
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}

