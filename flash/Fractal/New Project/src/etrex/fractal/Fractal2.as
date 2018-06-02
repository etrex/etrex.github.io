package etrex.fractal 
{
	import etrex.shape.Square;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	
	/**
	 * ...
	 * @author ETREX
	 */
	public class Fractal2 extends Sprite
	{
		public var level:int;
		public var shapeClass:Class = Square; 
		private var dataArray:Array = [];
		private var shapeArray:Array = [];
		private var spriteArray:Array = [];
		
		//巢狀陣列
		private var spriteCategory:Array = [];
		
		public function Fractal2(level:int = 3) 
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
			//取得足夠數量的shape 和 sprite
			var d:int = dataArray.length;
			var shape:Shape;
			var sprite:Sprite;
			var shapeNum:int = Math.pow(d , level);
			var spriteNum:int  = (Math.pow(d , level) - 1) / (d - 1) - 1;
			while (shapeArray.length < shapeNum)
			{
				shape = new shapeClass(); 
				shapeArray.push(shape);
			}
			while (spriteArray.length < spriteNum)
			{
				sprite = new Sprite(); 
				spriteArray.push(sprite);
			}
			
			//trace("shapeNum = " + shapeNum);
			//trace("spriteNum = " + spriteNum);
			
			//sprite
			var i:int = 0;
			for (i = 0 ; i < spriteArray.length ; i++)
			{
				sprite = spriteArray[i];
				if ( i < spriteNum)
				{
					//var l:Array = getLayer(i);
					var data:FractalData = dataArray[i % d];
					var parentIndex:int = Math.floor(i / d) - 1;
					//trace("i = " + i + ", l = " + getLayer(i) + ", index = " + getIndex(getLayer(i).splice(1)) + " " + parentIndex);
					sprite.transform.matrix = data.matrix;
					sprite.transform.colorTransform = data.colorTransform;
					if (parentIndex == -1)
						this.addChild(sprite);
					else
						spriteArray[parentIndex].addChild(sprite);
				}
				else
				{
					if (sprite.parent != null)
					{
						sprite.parent.removeChild(sprite);
					}
					else
					{
						break;
					}
				}
			}
			
			// shape
			var spriteArrayEnd:int = spriteArray.length-1;
			for (i = 0 ; i < shapeArray.length ; i++)
			{
				shape = shapeArray[i];
				if (i < shapeNum)
				{
					data = dataArray[i % d];
					parentIndex = spriteArrayEnd - Math.floor(i / d);
					spriteArray[parentIndex].addChild(shape);
					shape.transform.matrix = data.matrix;
					shape.transform.colorTransform = data.colorTransform;
				}
				else
				{
					if ( shape.parent != null)
					{
						shape.parent.removeChild(shape);
					}
					else
					{
						break;
					}
				}
			}
		}
		/*
		private function getLayer(index:int):Array {
			var d:int = dataArray.length;
			var string:String = "";
			var array:Array = [];
			var p:int = d;
			array.push(index % d);
			while (index >= p)
			{
				index -= p;
				array.push(Math.floor(index/p) % d);
				p *= d;
			}
			return array;
		}
		
		private function getIndex(array:Array):int {
			var d:int = dataArray.length;
			var p:int = 1;
			var index :int = -1;
			for (var i:int = 0 ; i < array.length ; i++)
			{
				index += p;
				index += p * array[i];
				p *= d;
			}
			return index;
		}*/
	}
}