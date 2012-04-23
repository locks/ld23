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
		[Embed(source = "data/explosionsmedium-blue.png")]private var ImgMedium:Class;
		[Embed(source = "data/explosionsSmall.png")]private var ImgSmall:Class;
		[Embed(source = "data/explosionBig.png")]private var ImgLarge:Class;

		private var lifespan:Number = 1/3;
		private var origlifespan:Number = lifespan;
		
		public function Explosion() 
		{
			super(0, 0);
			
			loadGraphic(ImgMedium, true, false, 20, 20);
			
			addAnimation("smallYellow", [0, 1, 2, 3, 4, 5, 6, 7, 8], 30, false);
			addAnimation("smallOrange", [9, 10, 11, 12, 13, 14, 15, 16, 17], 30, false);

			addAnimation("mediumDark", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 30, false);
			addAnimation("mediumLight", [10, 11, 12, 13, 14, 15, 16, 17, 18, 19], 30, false);
			
			addAnimation("largeLight", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 30, false);
			addAnimation("largeDark", [12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23], 30, false);
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
		
		public function explode(size:String = "medium"):void
		{
			var rand:Boolean  = FlxU.floor(FlxG.random() * 200) % 2 == 0;
			
			changeGraphic(size);
			
			if (size == "small")      rand ? play("smallYellow") : play("smallOrange");
			if (size == "medium") rand ? play("mediumDark") : play("mediumLight");
			if (size == "large")       rand ? play("largeLight") : play("largeDark");
		}
		
		private function changeGraphic(size:String):void
		{
			if (size == "small")     loadGraphic(ImgSmall, true, false, 14, 14);
			if (size == "medium") {
				loadGraphic(ImgMedium, true, false, 20, 20);
				
				scale.x = 2;
				scale.y = 2;
				width *= 2;
				height *= 2;
				centerOffsets(true);
			}
			if (size == "large") loadGraphic(ImgLarge, true, false, 66, 72);
		}
		
	}

}