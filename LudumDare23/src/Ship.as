package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Deviantgeek
	 */
	public class Ship extends FlxSprite
	{
		private var _speed:int; 
		
		public function Ship(X:int, Y:int) 
		{
			super(X, Y)

			//crappy img
			makeGraphic(40, 40, 0xffffffff);  
			
			_speed = 150;
		}
		
		override public function update():void
		{
			//MOVEMENT
			velocity.x = 0;
			velocity.y = 0;
			
			if(FlxG.keys.A)
			{
				velocity.x = -_speed;
			}
			else if(FlxG.keys.D)
			{
				velocity.x = _speed;
			}
			if(FlxG.keys.W)
			{
				velocity.y = -_speed;
			}
			else if(FlxG.keys.S)
			{
				velocity.y = _speed;
			}

			super.update();
		}

		
	}

}