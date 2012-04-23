package Enemies 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Ricardo Mendes
	 */
	public class Swarm extends FlxGroup
	{
		private var _player:Ship;
		
		private var x:int;
		private var y:int;
		
		public function Swarm(X:Number=0,Y:Number=0,Size:Number=0,ThePlayer:Ship=null) 
		{
			super(Size);
			_player = ThePlayer;
			x = X;
			y = Y;
			
			var tmp:Swarmlet
			for (var i:int; i < 100; i++)
			{
				tmp = new Swarmlet();
				tmp.init(FlxU.floor(FlxG.random() * 50) + x, FlxU.floor(FlxG.random() * 50) + y, _player);
				FlxG.log(tmp.x);
				add(tmp);
			}
		}
		
		override public function update():void
		{
			super.update();
		}
	}

}