package idv.etrex.rander 
{
	import flash.display.Graphics;
	import idv.etrex.point.IPoint2D;
	/**
	 * ...
	 * @author etrex
	 */
	public class PolygonRenderer implements IRenderer 
	{
		public function draw(g:Graphics, vector: Vector.<IPoint2D>, size:Number=1, color:uint=0, alpha:Number = 1):void
		{
			var size2:int = size / 2;
			for each(var p:IPoint2D in vector)
			{
				g.beginFill(color,alpha);
				g.drawEllipse(p.x - size2, p.y - size2, size, size);
				g.endFill();
			}
		}
	}

}