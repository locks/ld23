


package  
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import org.flixel.FlxG;
	import org.flixel.system.FlxPreloader
	
	public class FlxFactory extends FlxPreloader
	{
		[Embed(source="data/loading_bar.png")]private var ImgBar:Class;
		[Embed(source='data/loading_bit.png')]private var ImgBit:Class;
		
		protected var tmp:Bitmap;
		/**
		* @private
		*/
		protected var _bits:Array;
		
		public function FlxFactory() 
		{
			super();
		}
		
		override protected function create():void
		{
			_min = 0;
			if(!FlxG.debug)
				_min = minDisplayTime * 1000;
				
			//create buffer
			_buffer = new Sprite();
			_buffer.scaleX = 2;
			_buffer.scaleY = 2;
			addChild(_buffer);
			
			//create bmpBar
			_bmpBar = new ImgBar();
			_bmpBar.x = (stage.stageWidth/_buffer.scaleX-_bmpBar.width)/2;
			_bmpBar.y = (stage.stageHeight/_buffer.scaleY-_bmpBar.height)/2;
			_buffer.addChild(_bmpBar);
			
			//create bits
			_bits = new Array();
			for(var i:uint = 0; i < 9; i++)
			{
			tmp = new ImgBit();
			tmp.visible = false;
			tmp.x = _bmpBar.x+2+i*3;
			tmp.y = _bmpBar.y+2;
			_bits.push(tmp);
			_buffer.addChild(tmp);
			}
		}
		
		override protected function update(Percent:Number):void
		{
			var i:int
			var limit:uint = Percent*10;
			for (i = 0; i < limit && (i < _bits.length); i++ )
				_bits[i].visible = true;
		}
		
		override protected function destroy():void
		{
			super.destroy();
			tmp = null;
			_bits = null;
		}
	}
}
