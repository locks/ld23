package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Deviantgeek
	 */
	public class Explosion extends FlxSprite
	{
		[Embed(source = "data/explosionsmedium-blue.png")]private var ImgAsplode:Class;
		
		public function Explosion() 
		{
			super(0, 0)
			loadGraphic(ImgAsplode, true, false, 20, 20);
			addAnimation("Dblue", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 40, false);
			addAnimation("Lblue", [10, 11, 12, 13, 14, 15, 16, 17, 18, 19], 40, false);
		}
		
		override public function update():void
		{
			FlxG.log("pre");
			super.update();
			FlxG.log("post");
			play("Dblue");
		}
	}

}