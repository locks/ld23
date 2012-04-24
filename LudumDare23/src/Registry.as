package  
{
	import com.increpare.bfxr.Bfxr;
	
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
		
		public static var Energy:int = 10;
		public static var Planets:Array = new Array( new Planet(0, 0, ImgPlanet1), new Planet(0, 0, ImgPlanet2) );

		public static var CurrentPlanet:Planet = new Planet(0, 0, ImgPlanet1);
		
		public static const strClick:String                          = ",0.5,,0.1943,,0.1338,0.3,0.2706,,,,,,,,,,,,,0.1321,,,,,1,,,0.1,,,,masterVolume";
		public static const strGrenadeExplosion:String = "5,0.5,0.0875,0.29,0.4293,0.669,0.8687,0.0432,,,0.0689,0.4646,0.1533,0.3665,0.9053,0.3669,0.4894,0.8367,-0.1104,0.5097,0.6901,-0.9844,0.4128,-0.6226,-0.0119,0.7156,-0.9204,0.531,0.0307,0.2362,0.0001,-0.9999,masterVolume";
		public static const strExplosion:String                 = "3,0.5,,0.1405,0.6076,0.436,0.3,0.0781,,0.1245,,,,,,,,,,,,,0.7781,0.212,-0.2204,1,,,,,,,masterVolume";
		public static const strLaser:String                        = "1,0.5,,0.1552,,0.39,0.3,0.2319,,0.2369,,,,,,,,,,,,,0.5827,,,1,,,,,,,masterVolume;"
		public function Registry() 
		{
		}
		
	}

}