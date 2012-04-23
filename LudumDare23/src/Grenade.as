package  
{
	/**
	 * ...
	 * @author Ricardo Mendes
	 */
	public class Grenade extends Explosion 
	{
		
		public function Grenade() 
		{
			//scaleSprite(2);
			super();			
		}
		
		protected function scaleSprite(factor:Number = 2):void
		{
			scale.x = scale.y = factor;
			
			width  *= factor;
			height *= factor;
			
			centerOffsets();
		}
		
		public function detonate():void
		{
			super.explode("medium");
		}
		
	}

}