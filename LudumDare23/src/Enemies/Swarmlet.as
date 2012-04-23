package Enemies 
{
	import flash.geom.Point;
	
	import org.flixel.*;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSave;
	import org.flixel.FlxSprite;
	
	public class Swarmlet extends FlxParticle
	{
		[Embed(source = '../data/swarm.png')] private var ImgSwarmlet:Class;

    //References to other game objects:
    protected var _player:Ship;		//The player object

    //We use this number to figure out how fast the ship is flying
    protected var _thrust:Number;

    //These are "timers" - numbers that count down until we want something interesting to happen.
    protected var _timer:Number;		//Helps us decide when to fly and when to stop flying.
    protected var _shotClock:Number;	//Helps us decide when to shoot.

    //This object isn't strictly necessary, and is only used with getMidpoint().
    //By passing this object, we can avoid a potentially costly allocation of
    //a new FlxPoint() object by the getMidpoint() function.
    protected var _playerMidpoint:FlxPoint;

    //This is the constructor for the enemy class.  Because we are
    //recycling enemies, we don't want our constructor to have any
    //required parameters.
    public function Swarmlet()
    {
      super();
	  loadGraphic(ImgSwarmlet);
	  addAnimation("explodeYellow", [1, 2, 3, 4, 5, 6, 7, 8, 9], 40);
	  addAnimation("explodeOrange", [1, 2, 3, 4, 5, 6, 7, 8, 9], 40);
	  
      //These parameters help control the ship's
      //speed and direction during the update() loop.
      maxAngular = 120;
      angularDrag = 40;
      drag.x = 35;
      _thrust = 0;
      _playerMidpoint = new FlxPoint();
    }

    //Each time an Swarmlet is recycled (in this game, by the Spawner object)
    //we call init() on it afterward.  That allows us to set critical parameters
    //like references to the player object and the ship's new position.
    public function init(xPos:int,yPos:int,ThePlayer:Ship):void
    {
      _player = ThePlayer;

      reset(xPos - width/2,yPos - height/2);
      angle = angleTowardPlayer();
      health = 2;	//Enemies take 2 shots to kill
      _timer = 0;
    }

    //Called by flixel to help clean up memory.
    override public function destroy():void
    {
      super.destroy();

      _player = null;

      _playerMidpoint = null;
    }

    //This is the main flixel update function or loop function.
    //Most of the Swarmlet's logic or behavior is in this function here.
    override public function update():void
    {
		//Then, rotate toward that angle.
		//We could rotate instantly toward the player by simply calling:
		//angle = angleTowardPlayer();
		//However, we want some less predictable, more wobbly behavior.
		var da:int = FlxU.floor(angleTowardPlayer() + FlxG.random() * 20);
		if(da < angle)
			angularAcceleration = -FlxU.floor(angleTowardPlayer() + FlxG.random() * 20);
		else if(da > angle)
			angularAcceleration = FlxU.floor(angleTowardPlayer() + FlxG.random() * 20);
		else
			angularAcceleration = 0;
 

		//Set the bot's movement speed and direction
		//based on angle and whether the jets are on.
		_thrust = FlxU.computeVelocity(_thrust,FlxU.floor(FlxG.random()*100),drag.x,60);
		FlxU.rotatePoint(0, _thrust, 0, 0, angle, velocity);
		
	  
      //Then call FlxSprite's update() function, to automate
      // our motion and animation and stuff.
      super.update();
    }

    //This function is called when player bullets hit the Enemy.
    //The enemy is told to flicker, points are awarded to the player,
    //and damage is dealt to the Enemy.
    override public function hurt(Damage:Number):void
    {
      //FlxG.play(SndHit);
      flicker(0.2);
      FlxG.score += 10;
      super.hurt(Damage);
    }

    //Called to kill the enemy.  A cool sound is played,
    //the jets are turned off, bits are exploded, and points are rewarded.
    override public function kill():void
    {
      if(!alive) return;
      //FlxG.play(SndExplode);
      super.kill();
	  
      flicker(0);
      FlxG.score += 200;
    }

    //A helper function that returns the angle between
    //the Enemy's midpoint and the player's midpoint.
    protected function angleTowardPlayer():Number
    {
      return FlxU.getAngle(getMidpoint(_point),(_player.getMidpoint(_playerMidpoint)));
    }
	}

}