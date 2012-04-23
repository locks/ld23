package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Deviantgeek
	 */
	public class Planet extends FlxSprite
	{
		private var _visited:Boolean;
		
		public function Planet(X:int,Y:int, planet:Class)
		{
			super(X, Y, planet);
			
			this.health = 100;
		}
		
		public function shrink(factor:Number = 0.001):void
		{
			if (isShrunk()) return;
			
			flicker(0.1);
			
			health;
			
			_point = getMidpoint();
			
			scale.x -= factor;
			scale.y -= factor;
			
			centerOffsets();
		}
		
		public function isShrunk():Boolean
		{
			return (scale.x < .15);
		}
		
	}

}