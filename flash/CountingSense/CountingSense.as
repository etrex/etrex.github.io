package  
{
	import animation.AnimationBase;
	import emitters.CircleEmitter;
	import flash.display.Sprite;
	import idv.cjcat.stardust.common.clocks.SteadyClock;
	import idv.cjcat.stardust.common.emitters.Emitter;
	import idv.cjcat.stardust.common.handlers.ParticleHandler;
	import idv.cjcat.stardust.twoD.handlers.DisplayObjectHandler;
	import idv.cjcat.stardust.twoD.initializers.DisplayObjectClass;
	
	/**
	 * ...
	 * @author etrex
	 */
	public class CountingSense extends Sprite 
	{
		public var animationBase:AnimationBase = new AnimationBase();
		public var ballEmitter:CircleEmitter = new CircleEmitter(new DisplayObjectClass(Ball), 50);
		
		public function CountingSense() 
		{
			animationBase.emitter = ballEmitter;
			animationBase.x = 400;
			animationBase.y = 260;
			this.addChild(animationBase);
			
		}
		
	}

}