package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Deviantgeek
	 */
	public class Ship extends FlxSprite
	{
		[Embed(source = 'data///mothership.png')] private var motherShip:Class;
		
		private var _speed:int; 
		
		public function Ship(X:int, Y:int) 
		{
			super(X, Y)

			//crappy img
			//makeGraphic(40, 40, 0xffffffff);
			loadGraphic(motherShip, true, false, 40, 55, true);
			
			addAnimation("standBy", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 30, true);
			addAnimation("unscrew", [20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45], 30, false);
			addAnimation("screw", [45, 44, 43, 42, 41, 40, 39, 38, 37, 36, 35, 34, 33, 32, 31, 30, 29], 30, false);
			addAnimation("charge", [20, 21, 22, 23, 24, 25, 26, 27, 28], 30, false);
			play("standBy");
			
			// elasticity (makes it so when you hit another ship you bounce away slightly)
			elasticity = 1.5;
			// acceleration
			acceleration = new FlxPoint(30, 30);
			// maxSpeed
			maxVelocity = new FlxPoint(150, 150);
			
			
			
			_speed = 150;
		}
		
		override public function update():void
		{
			//MOVEMENT
			velocity.x = 0;
			velocity.y = 0;
			
			if(FlxG.keys.A || FlxG.keys.LEFT)
			{
				if (this.x + 20 > 0) {
					velocity.x = -_speed;
				}
			}
			else if(FlxG.keys.D || FlxG.keys.RIGHT)
			{
				if (this.x + this.width - 20 < FlxG.width) {
					velocity.x = _speed;
				}
			}
			if(FlxG.keys.W || FlxG.keys.UP)
			{
				if(this.y + 10 > 0) velocity.y = -_speed;
			}
			else if(FlxG.keys.S || FlxG.keys.DOWN)
			{
				if(this.y + this.height - 10 < FlxG.height) velocity.y = _speed;
			}
			
			
			if (FlxG.keys.SPACE)
			{
				play("unscrew");
			}
			//else if (velocity.x == 0) play("standBy");

			super.update();
		}

		
	}

}