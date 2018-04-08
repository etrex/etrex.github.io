
import flash.events.MouseEvent;

//計算距離
function d(A,B)
{
	return Math.round(Math.sqrt((A.x - B.x)*(A.x - B.x)+(A.y - B.y)*(A.y - B.y)));
}

var g = this.graphics;

//畫三角形
function drawTriangle(A,B,C,TA,TB,TC)
{
	g.lineStyle(1,0,0.7);
	g.moveTo(A.x,A.y);
	g.lineTo(B.x,B.y);
	g.lineTo(C.x,C.y);
	g.lineTo(A.x,A.y);
	TA.text = d(B,C);
	TB.text = d(A,C);
	TC.text = d(A,B);
	TA.x = (B.x + C.x )/2 - TA.width/2;
	TB.x = (A.x + C.x )/2 - TB.width/2;
	TC.x = (A.x + B.x )/2 - TC.width/2;
	TA.y = (B.y + C.y )/2 - TA.height/2;
	TB.y = (A.y + C.y )/2 - TB.height/2;
	TC.y = (A.y + B.y )/2 - TC.height/2;
}

//根據 stage大小控制 XY 軸
function updateXYLine()
{
	var w = stage.stageWidth;
	var h = stage.stageHeight;
	XLine.y = h/2;
	YLine.x = w/2;
	//trace(w,h);
}


//每個frame 更新畫面
this.addEventListener(Event.ENTER_FRAME, function(){
	g.clear();
	updateXYLine();
	drawTriangle(A,B,C,TA,TB,TC);
	var O = ComputeTrianglePosition(d(B,C),d(A,C),d(A,B));
	D.x = YLine.x + O.A.x;
	D.y = XLine.y -O.A.y;
	E.x = YLine.x + O.B.x;
	E.y = XLine.y -O.B.y;
	F.x = YLine.x + O.C.x;
	F.y = XLine.y -O.C.y;
	drawTriangle(D,E,F,TD,TE,TF);
});

//滑鼠控制拖曳ABC
A.buttonMode = true;
B.buttonMode = true;
C.buttonMode = true;
function MouseDown(e:MouseEvent){
	e.target.startDrag();
}
A.addEventListener(MouseEvent.MOUSE_DOWN, MouseDown);
B.addEventListener(MouseEvent.MOUSE_DOWN, MouseDown);
C.addEventListener(MouseEvent.MOUSE_DOWN, MouseDown);
stage.addEventListener(MouseEvent.MOUSE_UP,function(){
	A.stopDrag();
	B.stopDrag();
	C.stopDrag();
});

//給三邊長計算三角形座標
function ComputeTrianglePosition(a,b,c)
{
	var O = {};
	var A = {};
	var B = {};
	var C = {};
	A.x = 0;
	A.y = 0;
	B.x = c;
	B.y = 0;
	C.x = (b*b+c*c-a*a) / (2*c);
	C.y = Math.sqrt( b*b - C.x*C.x );
	O.A = A;
	O.B = B;
	O.C = C;
	//trace("A = " + PointToString(A) + " B = " +  PointToString(B) + " C = " +  PointToString(C));
	return O;
}

function PointToString(A)
{
	return "(" + A.x + ", "+ A.y + ")";
}