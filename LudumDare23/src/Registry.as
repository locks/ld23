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
		[Embed(source = "data/planets/planet1.gif")] public static var ImgPlanet1:Class;
		[Embed(source = "data/planets/planet2.gif")] public static var ImgPlanet2:Class;
		
		public static var Fuel:int = 15;
		public static var Planets:Array = new Array( new Planet(0, 0, ImgPlanet1), new Planet(0, 0, ImgPlanet2) );

		public static var CurrentPlanet:Planet = new Planet(0, 0, ImgPlanet1);
		
		public function Registry() 
		{
			Planets = [ImgPlanet1];
		}
		
	}

}