package 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.net.navigateToURL;
	
	import CountService;
	/**
	 * ...
	 * @author ETREX
	 */
	public class RGBFitAlpha extends MovieClip
	{
		var AnswerR:int;
		var AnswerG:int;
		var AnswerB:int;
		var myTimer:Timer;
		var score:int;
		var count:int;
		var thredhold : int;
		public function RGBFitAlpha()
		{
			thredhold = 40;
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
			etrex.buttonMode = true;
			etrex.addEventListener(MouseEvent.CLICK, function() {
				navigateToURL(new URLRequest("http://etrex.blogspot.com/"), "_blank");
			});

			myTimer = new Timer(1000, 60);
            myTimer.addEventListener("timer", timerHandler);
            myTimer.addEventListener("timerComplete", timerCompleteHandler);
		}
		public function StartClickHandler(event:MouseEvent):void {
			frame2Init();
		}
		
		public function frame2Init():void {
			if(this.contains(frame1)) this.removeChild(frame1);
			if(this.contains(frame3)) this.removeChild(frame3);
			this.addChild(frame2);
			score = 0;
			count = 0;
			frame2.Rsilder.x = 25;
			frame2.Gsilder.x = 25;
			frame2.Bsilder.x = 25;
			frame2.time.text = 60;
			
			SetAnswer();
			myTimer.reset();
            myTimer.start();
			OnSildeHandler(new Event(""));			
		}
		
		public function timerHandler(event:TimerEvent):void {
			frame2.time.text = frame2.time.text - 1;
		}		
		public function timerCompleteHandler(event:TimerEvent):void {
			frame3Init();
		}
		
		public function frame3Init():void {
			this.removeChild(frame2);
			this.addChild(frame3);
			frame3.scoreText.text = score;
			frame3.countText.text = count;
			CountService.AddHistogram("RGBFitAlpha",score, null);
		}
		
		public function NextCilckHandler(event:MouseEvent):void {
			score += 10 + thredhold - computeDifference();
			count ++;
			SetAnswer();
		}
		
		public function computeDifference():int{
			var r = Math.floor((frame2.Rsilder.x -25)/2);
			var g = Math.floor((frame2.Gsilder.x -25)/2);
			var b = Math.floor((frame2.Bsilder.x -25)/2);
			var diff = Math.floor(Math.sqrt((AnswerR - r) * (AnswerR - r) + (AnswerG - g) * (AnswerG - g) + (AnswerB - b) * (AnswerB - b)));
			return diff;
		}
		
		public function SetAnswer():void {
			AnswerR = Math.floor(Math.random() * 256);
			AnswerG = Math.floor(Math.random() * 256);
			AnswerB = Math.floor(Math.random() * 256);
			SetColor(frame2.ColorBox, AnswerR, AnswerG, AnswerB);
			frame2.Next.visible = false;
		}
		
		public function silderDownHandler(event:MouseEvent):void {
			var silder:Sprite = Sprite(event.currentTarget);
			silder.startDrag(false, new Rectangle(25, silder.y, 510, 0));
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
			var r = Math.floor((frame2.Rsilder.x -25)/2);
			var g = Math.floor((frame2.Gsilder.x -25)/2);
			var b = Math.floor((frame2.Bsilder.x -25)/2);
			SetColor(frame2.Rsilder,r,0,0);
			SetColor(frame2.Gsilder,0,g,0);
			SetColor(frame2.Bsilder,0,0,b);
			SetColor(frame2.UserColorBox, r, g, b);
			var diff = computeDifference();
			if (diff < thredhold)
				frame2.Next.visible = true;
			else
				frame2.Next.visible = false;
		}
		
		public function SetColor(displayObject:DisplayObject, r:int, g:int, b:int):void {
			displayObject.transform.colorTransform = new ColorTransform(r / 255, g / 255, b / 255);
		}
	}
}