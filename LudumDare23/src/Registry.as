package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Deviantgeek
	 */
	public class Registry 
	{
		[Embed(source = "data/planets/planet1.gif")]public static var ImgPlanet1:Class;
		
		public static var Fuel:int = 15
		public static var _planets:Array;
		
		public function Registry() 
		{
			_planets = [ImgPlanet1]
		}
		
	}

}