package  
{
	import flash.events.Event;
	import idv.etrex.point.Point2D;
	import idv.etrex.point.Point2DRandomFilter;
	import idv.etrex.rander.CircleRenderer;
	
	/**
	 * ...
	 * @author etrex
	 */
	public class CircleRendererTest extends RendererTest 
	{
		protected var pointNumber:int = 3;
		protected var color:uint = 0xFFFFFF;
		public function CircleRendererTest() 
		{
			shape.filters = [ new BlurFilter(10, 10)];
			renderer = new CircleRenderer();
		}
		
		override protected function onEnterFrameHandler(e:Event):void {
			var p:Point2D = new Point2D(shape.mouseX, shape.mouseY);
			for (var i:int = 0; i < pointNumber ; i++)
			{
				p.filters = [new Point2DRandomFilter(10, 10, 4)];
				points.push(p);
			}
			shape.graphics.clear();
			renderer.draw(shape.graphics, points, 10, color);
		}
		
	}

}