package animation 
{
	import flash.events.Event;
	import flash.display.Sprite;
	import idv.cjcat.stardust.common.clocks.Clock;
	import idv.cjcat.stardust.common.emitters.Emitter;
	import idv.cjcat.stardust.common.handlers.ParticleHandler;
	import idv.cjcat.stardust.twoD.emitters.Emitter2D;
	import idv.cjcat.stardust.twoD.handlers.DisplayObjectHandler;
	
	/**
	 * ...
	 * @author etrex
	 */
	public class AnimationBase extends Sprite
	{
		private var _emitter:Emitter;
		public function get emitter():Emitter {
			return _emitter;
		}
		public function set emitter(value:Emitter):void {
			if (value != null)
			{
				_emitter = value;
				_emitter.particleHandler = new DisplayObjectHandler(this);
				if(this.hasEventListener(Event.ENTER_FRAME) == false)
					this.addEventListener(Event.ENTER_FRAME, mainLoop);
			}
			else
			{
				_emitter = null;
				if(this.hasEventListener(Event.ENTER_FRAME) == true)
					this.removeEventListener(Event.ENTER_FRAME, mainLoop);
			}
		}
		public function AnimationBase(e:Emitter = null) 
		{
			emitter = e;
		}
		private function mainLoop(e:Event):void {
			emitter.step();
		}
		
	}

}