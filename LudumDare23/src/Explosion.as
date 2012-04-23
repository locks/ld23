package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	/**
	 * ...
	 * @author Deviantgeek
	 */
	public class Explosion extends FlxSprite
	{
		[Embed(source = "data/explosionsmedium-blue.png")]private var ImgAsplode:Class;

		private var lifespan:Number = 1/3;
		private var origlifespan:Number = lifespan;
		
		public function Explosion() 
		{
			super(0, 0)
			loadGraphic(ImgAsplode, true, false, 20, 20);
			addAnimation("Dblue", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 30, false);
			addAnimation("Lblue", [10, 11, 12, 13, 14, 15, 16, 17, 18, 19], 30, false);
		}
		
		override public function update():void
		{
			
			lifespan -= FlxG.elapsed;
			if (lifespan <= 0)
			{
				kill();
			}
				
			super.update();
		}
		
		override public function kill():void
		{
			super.kill();
			lifespan = origlifespan;
		}
	}

}