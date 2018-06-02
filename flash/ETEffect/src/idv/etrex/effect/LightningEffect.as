package idv.etrex.effect 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import idv.etrex.point.Point2D;
	import idv.etrex.point.Point2DRandomFilter;
	import idv.etrex.point.Point2DScaleFilter;
	import idv.etrex.rander.IRenderer;
	import idv.etrex.rander.LineRenderer;
	/**
	 * ...
	 * @author etrex
	 */
	public class LightningEffect extends Sprite
	{
		private var pointNumber : int;
		private var lightningHeight: int;
		private var lightningSize: int;
		private var lightningNumber: int;
		private var color:uint ;
		private var points:Vector.<Point2D> = new Vector.<Point2D>();
		private var render:IRenderer = new LineRenderer();
		
		private var scaleFilter:Point2DScaleFilter = new Point2DScaleFilter();
		public function LightningEffect(lightningHeight:int = 100, lightningSize:int = 2, lightningNumber:int = 1, pointNumber:int = 10, color:uint = 0xffffff) 
		{
			this.lightningHeight = lightningHeight;
			this.lightningSize = lightningSize;
			this.lightningNumber = lightningNumber;
			this.pointNumber = pointNumber;
			this.color = color;
			
			for (var i:int = 0; i < pointNumber ; i++)
			{
				var t :Number = i / (pointNumber-1);
				var p:Point2D = new Point2D(0, -t * lightningHeight);
				p.filters = [new Point2DRandomFilter(t * t * lightningHeight + lightningHeight/10, 0, 4), scaleFilter];
				points.push(p);
			}
		}
		public function add(x:int,y:int):void {
			var sprite:Sprite = new Sprite();
			sprite.x = x;
			sprite.y = y;
			this.addChild(sprite);
			drawLight(sprite.graphics);
			sprite.addEventListener(Event.ENTER_FRAME , onEnterFrameHandler);
		}
		
		private function onEnterFrameHandler(e:Event):void {
			var sprite:Sprite = Sprite(e.target);
			sprite.alpha += (0 - sprite.alpha) * 0.2;
			if ( sprite.alpha <= 0)
			{
				sprite.removeEventListener(Event.ENTER_FRAME , onEnterFrameHandler);
				this.removeChild(sprite);
			}
		}
		
		private function drawLight(g:Graphics):void {
			g.clear();
			scaleFilter.scaleY = Math.random()*0.3+0.7;
			for (var i:int = 0 ; i < lightningNumber ; i++)
				render.draw(g, points, lightningSize , color, 1);
		}
		
		
	}

}