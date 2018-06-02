package idv.etrex.rander 
{
	import flash.display.Graphics;
	import idv.etrex.point.IPoint2D;
	
	/**
	 * ...
	 * @author etrex
	 */
	public interface IRenderer
	{
		function draw(g:Graphics, vector: Vector.<IPoint2D>, size:Number = 1, color:uint = 0, alpha:Number = 1):void ;
	}
	
}