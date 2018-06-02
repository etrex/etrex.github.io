package idv.etrex.point 
{
	/**
	 * ...
	 * @author etrex
	 */
	public class Point2DScaleFilter implements IPoint2DFilter
	{
		public var scaleX :Number;
		public var scaleY :Number;
		public function Point2DScaleFilter(scaleX:Number = 1, scaleY:Number = 1) 
		{
			this.scaleX = scaleX;
			this.scaleY = scaleY;
		}
		
		public function xFilter(x:Number):Number {
			return x * scaleX;
		}
		
		public function yFilter(y:Number):Number {
			return y * scaleY;
		}
	}

}