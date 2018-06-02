package 
{
	import etrex.fractal.Fractal;
	import etrex.fractal.Fractal2;
	import etrex.fractal.FractalData;
	import etrex.fractal.FractalEditor;
	import etrex.shape.Square;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	
	/**
	 * ...
	 * @author ETREX
	 */
	public class Main extends Sprite 
	{
		//private var f:Fractal = new Fractal(8);
		private var f2:Fractal2 = new Fractal2(4);
		private var fe:FractalEditor = new FractalEditor();
			
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			
			var fd1:FractalData = new FractalData();
			var fd2:FractalData = new FractalData();
			var fd3:FractalData = new FractalData();
			var fd4:FractalData = new FractalData();
			fd1.colorTransform = new ColorTransform(0.5, 0.5, 0.5, 0.5, 0xff, 0, 0, 0);
			fd2.colorTransform = new ColorTransform(0.5, 0.5, 0.5, 0.5, 0, 0xff, 0, 0);
			fd3.colorTransform = new ColorTransform(0.5, 0.5, 0.5, 0.5, 0, 0, 0xff, 0);
			fd4.colorTransform = new ColorTransform(0.5, 0.5, 0.5, 0.5, 0xff, 0x00, 0xff, 100);
			
			f2.addFractalData(fd1);
			f2.addFractalData(fd2);
			f2.addFractalData(fd3);
			f2.addFractalData(fd4);
			fe.addFractalData(fd1);
			fe.addFractalData(fd2);
			fe.addFractalData(fd3);
			fe.addFractalData(fd4);
			
			fe.x = 200;
			fe.y = 200;
			
			fe.addEventListener(Event.CHANGE, dataChange);
			var square:Square = new Square();
			square.x = 200;
			square.y = 200;
			square.alpha = 0.1;
			this.addChild(square);
			
			//f.x = 800;
			//f.y = 200;
			//f.draw();
			//this.addChild(f);
			
			f2.x = 800;
			f2.y = 200;
			f2.draw();
			this.addChild(f2);
			
			this.addChild(fe);
		}
		
		private function dataChange(e:Event):void {
			//f.draw();
			f2.draw();
		}
	}
	
}