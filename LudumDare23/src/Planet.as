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
		}
		
	}

}