package  
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import idv.etrex.point.IPoint2D;
	import idv.etrex.point.Point2D;
	import idv.etrex.point.Point2DRandomFilter;
	import idv.etrex.rander.CircleRenderer;
	import idv.etrex.rander.IRenderer;
	
	/**
	 * ...
	 * @author etrex
	 */
	public class RendererTest extends Sprite 
	{
		protected var shape:Shape = new Shape();
		protected var renderer:IRenderer;
		protected var points:Vector.<IPoint2D> = new Vector.<IPoint2D>();
		public function RendererTest() 
		{
			stage.addEventListener(MouseEvent.MOUSE_DOWN, function():void {
				stage.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			});
			stage.addEventListener(MouseEvent.MOUSE_UP, function():void {
				stage.removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			});
			this.addChild(shape);
		}
		
		protected function onEnterFrameHandler(e:Event):void {
		}
	}

}