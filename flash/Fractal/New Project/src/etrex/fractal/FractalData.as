package etrex.fractal 
{
	import etrex.util.MatrixUtil;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author ETREX
	 */
	public class FractalData
	{
		public var matrix:Matrix = new Matrix();
		public var colorTransform:ColorTransform = new ColorTransform();
		public function get alpha():Number {
			return colorTransform.alphaOffset;
		}
		public function set alpha(value:Number):void {
			colorTransform.alphaOffset = value;
		}
		public function get r():Number {
			return colorTransform.redOffset;
		}
		public function set r(value:Number):void {
			colorTransform.redOffset = value;
		}
		public function FractalData() 
		{
			
		}
		
		public function toXML():XML {
			var xmlData:XML = <FractalData/>;
			xmlData.appendChild(MatrixUtil.toXML(matrix));
			return xmlData;
		}
		public function fromXML(xmlData:XML):void {
			matrix = MatrixUtil.loadXML(xmlData.Matrix[0]);
		}
		public function toString():String {
			return "FractalData : matrix=" + matrix; 
		}
	}

}