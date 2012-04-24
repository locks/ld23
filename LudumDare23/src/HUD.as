package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Deviantgeek
	 */
	public class HUD extends FlxGroup
	{
		[Embed(source = "data/bar-outline.png")]private var ImgFrame:Class;
		[Embed(source = "data/fuel unit.png")]private var ImgFuel:Class;
		
		private var _FuelGroup:FlxGroup = new FlxGroup(15);
		private var _frame:FlxSprite;
		
		public function HUD() 
		{
			 _frame = new FlxSprite(2, FlxG.height - 18, ImgFrame);
			add(_frame);
			
			var tmp:FlxSprite;
			for (var i:int = 0; i < 15; i++)
			{
				tmp = new FlxSprite(4+i*8, FlxG.height - 16);
				tmp.loadGraphic(ImgFuel, true, false, 7, 12);
				tmp.addAnimation("full", [0]);
				tmp.addAnimation("half", [1]);
				tmp.addAnimation("empty", [2]);
				tmp.moves = false;
				tmp.solid = false;
				tmp.play("full");
				_FuelGroup.add(tmp);
			}
			add(_FuelGroup);
		}
		
		override public function update():void
		{
			var index:int = 0;
			
			var filled:int = Registry.Energy / 100;
			var half:int = Registry.Energy % 100;
			
			//FlxG.log(filled);
			
			for each (var tank:FlxSprite in _FuelGroup.members)
			{
				if (filled > 0) {
					tank.play("full");
					filled--;
					//FlxG.log('filled');
				} else {
					if (half > 0) {
						//FlxG.log("half");
						tank.play("half");
						half = 0;
					} else {
						//FlxG.log("empty");
						tank.play("empty");
					}
				}
			}
			
			//for (var i:uint = 0; i < filled; ++i)
			//{
				//_FuelGroup.members[i].play("full");
				//index++;
			//}
			//
			//if (i > 0 && i < 50) {
				//_FuelGroup.members[index].play("half");
				//index++;
			//}
			//
			//for (var j:uint = index; j < _FuelGroup.members.length; ++j) _FuelGroup.members[j].play("empty");
			
			/*
			var l:uint = _FuelGroup.length;
			for(var i:uint = 0; i < l; i++)
			{
				if(i-1 < Registry.Fuel)
					_FuelGroup[i].play("full");
				else
					_FuelGroup[i].play("empty");
			}
			super.update();
			*/
			super.update();
			
		}
	}

}