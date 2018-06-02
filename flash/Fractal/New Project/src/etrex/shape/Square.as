package etrex.shape 
{
	import flash.display.Shape;
	
	/**
	 * ...
	 * @author ETREX
	 */
	public class Square extends Shape
	{
		
		public function Square() 
		{
			this.graphics.beginFill(0x0, 1);
			this.graphics.drawRect( 0, 0, 100, 100);
			this.graphics.endFill();
		}
		
	}

}