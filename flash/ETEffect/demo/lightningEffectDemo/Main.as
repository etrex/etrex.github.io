package 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.ui.Mouse;
	import idv.etrex.color.Hue;
	import idv.etrex.effect.LightningEffect;
	import idv.etrex.rander.IRenderer;
	import idv.etrex.rander.LineRenderer;
	import idv.etrex.rander.RectRenderer;
	import idv.etrex.point.Point2D;
	
	/**
	 * ...
	 * @author etrex
	 */
	public class Main extends Sprite 
	{
		private var lightningEffect:LightningEffect ;
		private var color:Hue = new Hue();
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			lightningEffect = new LightningEffect(800, 2 , 1, 10); 
			var glowFilter:GlowFilter = new GlowFilter(0x8080FF, 1, 20, 20, 2);
			
			this.addChild(lightningEffect);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
			stage.addEventListener(Event.ENTER_FRAME, function():void {
				color.h += 1 / 2000;
				glowFilter.color = color.getColor();
				lightningEffect.filters = [glowFilter];
			});
		}
		
		private function onMouseDownHandler(e:MouseEvent):void {
			Mouse.hide();
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}
		private function onMouseUpHandler(e:MouseEvent):void {
			Mouse.show();
			stage.removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}
		private function onEnterFrameHandler(e:Event):void {
			lightningEffect.add(this.mouseX, this.mouseY);
		}
		
	}
	
}