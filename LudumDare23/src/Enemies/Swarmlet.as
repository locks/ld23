package Enemies 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Deviantgeek
	 */
	public class Swarmlet extends FlxParticle
	{
		[Embed(source = "../data/swarm.png")]private var ImgSwarmlet:Class;
		public function Swarmlet() 
		{
			super();
			
			loadGraphic(ImgSwarmlet);
           
            exists = false;
		}
		
		override public function update():void
		{
			
		}
		
	}

}