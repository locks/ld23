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
			loadGraphic(motherShip, true, true, 40, 40, false);
			addAnimation("standBy", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], 40, true);
			play("standBy");
			
			// mass
			// acceleration
			// maxSpeed
			
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
					this.facing = 0;
				}
			}
			else if(FlxG.keys.D || FlxG.keys.RIGHT)
			{
				if (this.x + this.width - 10 < FlxG.width) {
					velocity.x = _speed;
					this.facing = 1;
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

			super.update();
		}

		
	}

}