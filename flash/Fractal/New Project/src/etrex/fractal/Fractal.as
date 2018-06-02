package etrex.fractal 
{
	import etrex.shape.Square;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	/**
	 * ...
	 * @author ETREX
	 */
	public class Fractal extends Sprite
	{
		public var level:int;
		public var shapeClass:Class = Square; 
		private var dataArray:Array = [];
		private var shapeArray:Array = [];
		
		public function Fractal(level:int = 3) 
		{
			this.level = level;
		}
		
		public function addFractalData(fractalData:FractalData):void {
			if (dataArray.indexOf(fractalData) == -1)
				dataArray.push(fractalData);
		}
		public function removeFractalData(fractalData:FractalData):void {
			var dataIndex:int = dataArray.indexOf(fractalData);
			if (dataIndex != -1)
				dataArray.splice(dataIndex,1);			
		}
		
		public function draw():void {
			//取得足夠數量的shape
			var shape:Shape;
			var shapeNum : int = Math.pow(dataArray.length , level);
			while (shapeArray.length < shapeNum)
			{
				shape = new shapeClass(); 
				shapeArray.push(shape);
			}
			//trace("length = " + shapeArray.length);
			var i:int = 0;
			for (i = 0 ; i < shapeArray.length ; i ++)
			{
				shape = shapeArray[i];
				if(i < Math.pow(dataArray.length , level+1))
				{
					this.addChild(shape);
					shape.transform.matrix = getMatrix(i);
				}
				else
				{
					if ( this.contains(shape))
						this.removeChild(shape);
				}
			}
		}
		
		private function getMatrix(index:int):Matrix {
			//trace("index = " + index);
			var matrix:Matrix = new Matrix();
			for (var i:int = 0 ; i < level ; i++)
			{
				var dataIndex:int = index % dataArray.length;
				//trace("   " + dataIndex);
				var data:FractalData = dataArray[dataIndex];
				matrix.concat(data.matrix);
				index = Math.floor(index / dataArray.length);
			}
			return matrix;
		}
	}
}