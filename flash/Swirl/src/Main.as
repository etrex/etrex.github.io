package 
{
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author etrex
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var s:Sprite = new Sprite();
			var b:Ball = new Ball();
			s.x = 400;
			s.y = 300;
			this.addChild(s);
			s.addChild(b);
			//b.r = 100;
			TweenMax.to(b, 5, { r:300,theta:Math.PI*10 } );
			
		}
		
	}
	
}