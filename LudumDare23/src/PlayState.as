package
{

	import org.flixel.*;

	public class PlayState extends FlxState
	{
		private var _ship:Ship;
		private var _sf:StarField;
		private var _hud:HUD;
		
		override public function create():void
		{
			
			_sf = new StarField();
			add(_sf);
			
			_ship = new Ship(FlxG.width / 2 - 40, FlxG.height / 2 - 55)
			add(_ship);
			
			_hud = new HUD();
			add(_hud)

		}
		
		override public function update():void
		{
			super.update();
		}
	}
}

