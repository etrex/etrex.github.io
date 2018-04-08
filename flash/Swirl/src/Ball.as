package  
{
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * ...
	 * @author etrex
	 */
	public class Ball extends Sprite
	{
		
		public function Ball() 
		{
			this.graphics.beginFill(0);
			this.graphics.drawCircle(0,0,10);
			this.graphics.endFill();
		}
		
		public var _r:Number = 0;
		public function get r():Number {
			return _r;
		}
		public function set r(value:Number):void {
			_r = value;
			polarTransform();
		}
		
		public var _theta:Number = 0;
		public function get theta():Number {
			return _theta;
		}
		public function set theta(value:Number):void {
			_theta = value;
			polarTransform();
		}
		public function polarTransform():void {
			var p:Point = Point.polar(_r, _theta);
			this.x = p.x;
			this.y = p.y;
		}
		
		
	}

}