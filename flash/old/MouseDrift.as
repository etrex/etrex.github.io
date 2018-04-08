class MouseDrift extends MovieClip 
{
	var Shadow;
	var MC;
	var IntervalID;
	function MouseDrift()
	{
		MC = this.createEmptyMovieClip("MC",this.getNextHighestDepth());
		Shadow = 5;
		for(var i = 0;i <= Shadow ; i++)
		{
			MC.createEmptyMovieClip("A"+i,i);
			DrawArrow(MC["A" + i]);
		}
		for(var i = Shadow;i >=0 ; i--)
			MC["A" + i]._alpha = 80 * i/Shadow;
		
		MC["A" + 0]._alpha = 0;
		MC["A" + Shadow].Drotation = 0;
		MC["A" + Shadow].Lrotation = 0;
		MC["A" + Shadow].Rrotation = 0;
		MC["A" + Shadow]._x = 100;
		MC["A" + Shadow]._y = 100;
		IntervalID = setInterval(this,"timeLoop",20);
	}
	public function Remove()
	{
		clearInterval(IntervalID);
		MC.removeMovieClip();
	}
	private	function timeLoop()
	{	
		Drift();
		for(var i = 0; i < Shadow ; i++)
			copyValue(MC["A" + i],MC["A" + (i+1)])
		MC["A" + Shadow]._x = _xmouse;
		MC["A" + Shadow]._y = _ymouse;
	}	
	private function Drift()
	{
		var point = { x:MC["A" + Shadow]._x,y:MC["A" + Shadow]._y};
		_root.localToGlobal(point);
		var deltaX =  _xmouse - point.x;
		var deltaY =  _ymouse - point.y;
		//L表上一次的角度值
		MC["A" + Shadow].Lrotation = MC["A" + Shadow].Rrotation;
		//R表本次的角度值 //滑鼠移動才變化
		if(Math.abs(deltaX) > 0 || Math.abs(deltaY) > 0 )
			MC["A" + Shadow].Rrotation = Math.atan2(deltaY,deltaX) * 180 / Math.PI + 360;
		//離心力
		
		MC["A" + 0]._rotation = (MC["A" + Shadow].Rrotation - MC["A" + Shadow].Lrotation) ;
		//trace(_parent.temp);
		MC["A" + Shadow].Drotation += MC["A" + 0]._rotation * 1/10 ;
		MC["A" + Shadow].Drotation *= 0.97;
		//角度變化
		if(Math.abs(deltaX) > 0 || Math.abs(deltaY) > 0 )
			MC["A" + Shadow]._rotation = MC["A" + Shadow].Rrotation + MC["A" + Shadow].Drotation * 2;
		else
			MC["A" + Shadow]._rotation += MC["A" + Shadow].Drotation;
	}
	private function copyValue(A,B)
	{
		A._x = B._x;
		A._y = B._y;
		A._rotation = B._rotation;	
	}
	private function DrawArrow(mc)
	{
	    mc.lineStyle(0 , 0xFFFFFF);
	    mc.beginFill(0x000000);
	    mc.moveTo(0, 0);
	    mc.lineTo(-12, -6);
	    mc.lineTo(-9, -2);
	    mc.lineTo(-18,-2);
	    mc.lineTo(-18,2);
	    mc.lineTo(-9, 2);
	    mc.lineTo(-12, 6);
	    mc.lineTo(0, 0);
	    mc.endFill();
	}
}