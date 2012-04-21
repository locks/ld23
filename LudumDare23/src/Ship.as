package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Deviantgeek
	 */
	public class Ship extends FlxSprite
	{
		[Embed(source = 'data///mothership-spritesheet.png')] private var motherShip:Class;
		
		private var _speed:int; 
		
		public function Ship(X:int, Y:int) 
		{
			super(X, Y)

			//crappy img
			//makeGraphic(40, 40, 0xffffffff);
			loadGraphic(motherShip, true, false, 40, 40, true);
			
			addAnimation("standBy", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 30, true);
			addAnimation("standByLeft", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], 30, true);
			addAnimation("standByRight", [20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 30, true);
			play("standBy");
			
			// mass
			mass = 0.5;
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
				if (this.x + 10 > 0) {
					velocity.x = -_speed;
					play("standByLeft");
				}
			}
			else if(FlxG.keys.D || FlxG.keys.RIGHT)
			{
				if (this.x + this.width - 10 < FlxG.width) {
					velocity.x = _speed;
					play("standByRight");
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
			
			if (velocity.x < 0) play("standByLeft");
			if (velocity.x == 0) play("standBy");
			if ( velocity.x > 0) play("standByRight");

			super.update();
		}

		
	}

}