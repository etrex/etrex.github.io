package etrex.fractal 
{
	import com.senocular.display.TransformTool;
	import etrex.shape.Square;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author ETREX
	 */
	public class FractalEditor extends Sprite
	{
		public var transformTool:TransformTool = new TransformTool();
		public var shapeClass:Class = Square; 
		private var dataArray:Array = [];
		private var spriteArray:Array = [];
		private var stageRef:Stage;
		public function FractalEditor() 
		{
			transformTool.addEventListener(TransformTool.CONTROL_MOVE, drag);
		}
		
		public function addFractalData(fractalData:FractalData):void {
			if (dataArray.indexOf(fractalData) == -1)
				dataArray.push(fractalData);
			draw();
		}
		public function removeFractalData(fractalData:FractalData):void {
			var dataIndex:int = dataArray.indexOf(fractalData);
			if (dataIndex != -1)
				dataArray.splice(dataIndex, 1);
			draw();
		}
		
		//選取拖曳
		private function select(e:MouseEvent):void {
			trace("select");
			trace("e.target = " + e.currentTarget);
			if (spriteArray.indexOf(e.currentTarget) != -1)
			{
				transformTool.target = e.currentTarget as Sprite;
				transformTool.registration = transformTool.boundsCenter;
			}
		}
		
		//拖曳時
		private function drag(e:Event):void {
			//更新 fractalData
			var dataIndex:int = spriteArray.indexOf(transformTool.target);
			var fractalData:FractalData = dataArray[dataIndex];
			fractalData.matrix = transformTool.target.transform.matrix;
			trace(fractalData);
			this.dispatchEvent(new Event(Event.CHANGE));
		}
		
		//更新畫面
		private function draw():void {
			//取得足夠數量的shape
			var shape:Shape;
			var sprite:Sprite;
			while (spriteArray.length < dataArray.length )
			{
				shape = new shapeClass();
				sprite = new Sprite();
				sprite.addChild(shape);
				sprite.addEventListener(MouseEvent.MOUSE_DOWN, select);
				spriteArray.push(sprite);
			}
			var i:int = 0;
			for (i = 0 ; i < spriteArray.length ; i ++)
			{
				sprite = spriteArray[i];
				if(i < dataArray.length)
				{
					sprite.transform.colorTransform = dataArray[i].colorTransform;
					this.addChild(sprite);
				}
				else
				{
					if ( this.contains(sprite))
						this.removeChild(sprite);
				}
			}
			this.addChild(transformTool);
		}
	}
}