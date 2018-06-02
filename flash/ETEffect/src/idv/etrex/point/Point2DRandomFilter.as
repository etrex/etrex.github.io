package idv.etrex.point 
{
	/**
	 * ...
	 * @author etrex
	 */
	public class Point2DRandomFilter implements IPoint2DFilter
	{
		public var randomX :Number;
		public var randomY :Number;
		public var randomTime :int;
		public function Point2DRandomFilter(randomX:Number = 10, randomY:Number = 10, randomTime:int=1) 
		{
			this.randomX = randomX;
			this.randomY = randomY;
			this.randomTime = randomTime;
		}
		
		public function xFilter(x:Number):Number {
			var r:Number = 0; 
			for (var i:int = 0 ; i < randomTime ; i++)
				r += Math.random();
			r /= randomTime;
			r -= 0.5;
			return x + r * randomX;
		}
		
		public function yFilter(y:Number):Number {
			var r:Number = 0; 
			for (var i:int = 0 ; i < randomTime ; i++)
				r += Math.random();
			r /= randomTime;
			r -= 0.5;
			return y + r * randomY;
		}
		
	}

}