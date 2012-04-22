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
		
		private static var _noAccel:FlxPoint = new FlxPoint(0, 0);
		
		public function Ship(X:int, Y:int, Bullets:FlxGroup) 
		{
			super(X, Y)

			//crappy img
			//makeGraphic(40, 40, 0xffffffff);
			loadGraphic(motherShip, true, false, 40, 40, true);
			
			addAnimation("standBy", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 30, true);
			addAnimation("standByLeft", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], 30, true);
			addAnimation("standByRight", [20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 30, true);
			play("standBy");
			
			// inertia variables
			mass = 0.5;
			
			acceleration.x = 0;
			acceleration.y = 0;
			
			maxVelocity.x = 100;
			maxVelocity.y = 100;
			
			drag.x = maxVelocity.x * 2;
			drag.y = maxVelocity.y * 2;
		}
		
		override public function update():void
		{
			acceleration.x = 0;
			acceleration.y = 0;
			
			if(FlxG.keys.A || FlxG.keys.LEFT)
			{
				if (this.x + 10 > 0) {
					acceleration.x = -maxVelocity.x * 4;
				}
			}
			else if(FlxG.keys.D || FlxG.keys.RIGHT)
			{
				if (this.x + this.width - 10 < FlxG.width) {
					acceleration.x = maxVelocity.x * 4;
				}
			}
			
			if(FlxG.keys.W || FlxG.keys.UP)
			{
				if (this.y + 10 > 0) {
					acceleration.y = -maxVelocity.y * 4;
				}
			}
			else if(FlxG.keys.S || FlxG.keys.DOWN)
			{
				if (this.y + this.height - 10 < FlxG.height) {
					acceleration.y = maxVelocity.y * 4;
				}
			}
			
			/*
			if (FlxG.keys.SPACE)
			{
				replaceColor(0x301DC2FF, 0xc21d1dF);
				drawFrame(true);
			}
			*/
			
			//if (velocity.x  < 0) play("standByLeft");
			//if (velocity.x == 0) play("standBy");
			//if (velocity.x  > 0) play("standByRight");

			super.update();
		}

		
	}

}
