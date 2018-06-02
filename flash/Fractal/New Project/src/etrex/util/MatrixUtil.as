package etrex.util 
{
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author ETREX
	 */
	public class MatrixUtil
	{
		public static function toXML(matrix:Matrix):XML {
			var xmlData :XML = <Matrix/>;
			xmlData.@a = matrix.a;
			xmlData.@b = matrix.b;
			xmlData.@c = matrix.c;
			xmlData.@d = matrix.d;
			xmlData.@tx = matrix.tx;
			xmlData.@ty = matrix.ty;
			return xmlData;
		}
		public static function loadXML(xmlData:XML):Matrix {
			var matrix:Matrix = new Matrix();
			matrix.a = parseFloat(xmlData.@a);
			matrix.b = parseFloat(xmlData.@b);
			matrix.c = parseFloat(xmlData.@c);
			matrix.d = parseFloat(xmlData.@d);
			matrix.tx = parseFloat(xmlData.@tx);
			matrix.ty = parseFloat(xmlData.@ty);
			return matrix;
		}
	}

}