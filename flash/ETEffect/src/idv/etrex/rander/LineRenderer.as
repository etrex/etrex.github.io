package idv.etrex.rander 
{
	import flash.display.Graphics;
	import idv.etrex.point.IPoint2D;
	/**
	 * ...
	 * @author etrex
	 */
	public class LineRenderer implements IRenderer
	{
		public function draw(g:Graphics, vector: Vector.<IPoint2D>, size:Number = 1, color:uint = 0, alpha:Number = 1):void {
			g.lineStyle(size, color, alpha);
			if (vector.length == 0 ) return;
			g.moveTo(vector[0].x, vector[0].y);
			for each(var p:IPoint2D in vector)
			{
				
				g.lineTo(p.x, p.y);
			}
		}
	}

}