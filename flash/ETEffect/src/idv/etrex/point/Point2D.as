package idv.etrex.point 
{
	/**
	 * ...
	 * @author etrex
	 */
	public class Point2D implements IPoint2D
	{
		private var _x:Number;
		private var _y:Number;
		
		public var filters:Array;
		public function Point2D(x:Number = 0, y :Number = 0 ) 
		{
			_x = x;
			_y = y;
		}
		
		public function get x():Number {
			var value:Number = _x;
			for each(var filter:IPoint2DFilter in filters)
				value = filter.xFilter(value);
			return value;
		}
		
		public function get y():Number {
			var value:Number = _y;
			for each(var filter:IPoint2DFilter in filters)
				value = filter.yFilter(value);
			return value;
		}
		public function set x(value:Number):void{
			_x = value;
		}
		
		public function set y(value:Number):void{
			_y = value;
		}
	}
}