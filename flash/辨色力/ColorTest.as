package 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import CountService;
	/**
	 * ...
	 * @author ETREX
	 */
	public class ColorTest extends MovieClip
	{
		var AnswerR:int;
		var AnswerG:int;
		var AnswerB:int;
		var AnswerI:int;
		var startTime:int;
		var score:int;
		public function ColorTest()
		{
			this.removeChild(frame2);
			this.removeChild(frame3);
			frame1.Start.buttonMode = true;
			frame1.Start.addEventListener(MouseEvent.CLICK , StartClickHandler);

			frame2.Next.buttonMode = true;
			frame2.Rsilder.buttonMode = true;
			frame2.Gsilder.buttonMode = true;
			frame2.Bsilder.buttonMode = true;
			frame2.Rsilder.addEventListener(MouseEvent.MOUSE_DOWN, silderDownHandler);
			frame2.Gsilder.addEventListener(MouseEvent.MOUSE_DOWN, silderDownHandler);
			frame2.Bsilder.addEventListener(MouseEvent.MOUSE_DOWN, silderDownHandler);
			frame2.Next.addEventListener(MouseEvent.CLICK, NextCilckHandler);
			
			frame3.Start.buttonMode = true;
			frame3.Start.addEventListener(MouseEvent.CLICK , StartClickHandler);
			frame3.RGBfit.buttonMode = true;
			frame3.RGBfit.addEventListener(MouseEvent.CLICK, function() {
				navigateToURL(new URLRequest("http://webetrex.appspot.com/colorTest/RGBfitAlpha.html"), "_blank");
			});
			
			etrex.buttonMode = true;
			etrex.addEventListener(MouseEvent.CLICK, function() {
				navigateToURL(new URLRequest("http://etrex.blogspot.com/"), "_blank");
			});
		}
		public function StartClickHandler(event:MouseEvent):void {
			startTime = new Date().getTime()/1000;
			frame2Init();
		}
		
		public function frame2Init():void {
			if (this.contains(frame1))	this.removeChild(frame1);
			if (this.contains(frame3))	this.removeChild(frame3);
			this.addChild(frame2);
			frame2.Rsilder.x =31;
			frame2.Gsilder.x =31;
			frame2.Bsilder.x =31;
			score = 0;
			AnswerI = 1;
			SetAnswer();
			OnSildeHandler(new Event(""));
		}
		
		public function frame3Init():void {
			this.removeChild(frame2);
			this.addChild(frame3);
			var time:int = new Date().getTime()/1000  -  startTime; 
			frame3.scoreText.text = score;
			frame3.timeText.text = Math.floor(time/60) +"分" + (time%60) + "秒";
			CountService.AddHistogram("gameAlpha",score, null);
		}
		
		public function NextCilckHandler(event:MouseEvent):void {
			if (AnswerI < 5)
			{
				var diff = computeDifference();
				score += diff;
				SetAnswer();
				AnswerI ++;
			}
			else
			{
				frame3Init();
			}
		}
		
		public function computeDifference():int{
			var r = frame2.Rsilder.x -31;
			var g = frame2.Gsilder.x -31;
			var b = frame2.Bsilder.x -31;
			var diff = Math.floor(Math.sqrt((AnswerR - r) * (AnswerR - r) + (AnswerG - g) * (AnswerG - g) + (AnswerB - b) * (AnswerB - b)));
			return diff;
		}
		
		public function SetAnswer():void {
			AnswerR = Math.floor(Math.random() * 256);
			AnswerG = Math.floor(Math.random() * 256);
			AnswerB = Math.floor(Math.random() * 256);
			SetColor(frame2.ColorBox, AnswerR, AnswerG, AnswerB);
		}
		
		public function silderDownHandler(event:MouseEvent):void {
			var silder:Sprite = Sprite(event.currentTarget);
			silder.startDrag(false, new Rectangle(31, silder.y, 255, 0));
			frame2.addEventListener(Event.ENTER_FRAME, OnSildeHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, silderUpHandler);
		}
		public function silderUpHandler(event:MouseEvent):void {
			frame2.Rsilder.stopDrag();
			frame2.Gsilder.stopDrag();
			frame2.Bsilder.stopDrag();
			frame2.removeEventListener(Event.ENTER_FRAME, OnSildeHandler);
		}
		public function OnSildeHandler(event:Event):void {
			var r = frame2.Rsilder.x -31;
			var g = frame2.Gsilder.x -31;
			var b = frame2.Bsilder.x -31;
			SetColor(frame2.Rsilder,r,0,0);
			SetColor(frame2.Gsilder,0,g,0);
			SetColor(frame2.Bsilder,0,0,b);
			SetColor(frame2.UserColorBox, r, g, b);
		}
		
		public function SetColor(displayObject:DisplayObject, r:int, g:int, b:int):void {
			displayObject.transform.colorTransform = new ColorTransform(r / 255, g / 255, b / 255);
		}
	}
}