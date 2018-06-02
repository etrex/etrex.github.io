package  
{
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import idv.etrex.point.Point2D;
	import idv.etrex.point.Point2DRandomFilter;
	import idv.etrex.rander.CircleRenderer;
	import idv.etrex.rander.LineRenderer;
	
	/**
	 * ...
	 * @author etrex
	 */
	public class LineRendererTest extends RendererTest 
	{
		protected var pointNumber:int = 3;
		protected var color:uint = 0xFFFFFF;
		public function LineRendererTest() 
		{
			shape.filters = [ new GlowFilter(0x00FFFF)];
			renderer = new LineRenderer();
		}
		
		override protected function onEnterFrameHandler(e:Event):void {
			var p:Point2D = new Point2D(shape.mouseX, shape.mouseY);
			for (var i:int = 0; i < pointNumber ; i++)
			{
				p.filters = [new Point2DRandomFilter(50, 50, 4)];
				points.push(p);
			}
			shape.graphics.clear();
			renderer.draw(shape.graphics, points, 4, color);
		}
		
	}

}