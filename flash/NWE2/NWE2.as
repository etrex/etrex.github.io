//定義滑鼠功能
var mouseMode = "moveNode";
//控制項行為
//正在使用的mode以藍框標示
function setSelectedControl(control)
{
	controlContainer.selectedControl._x = control._x;
	controlContainer.selectedControl._y = control._y;
}
//設定說明文字以及滑鼠按下功能
controlContainer.moveNodeControl.info = "用來拖曳點跟線";
controlContainer.moveNodeControl.onPress = function()
{
	trace("Mode = moveNode");
	mouseMode = "moveNode";
	setSelectedControl(this);
}
controlContainer.addNodeControl.info = "點選畫面可增加點";
controlContainer.addNodeControl.onPress = function()
{
	trace("Mode = addNode");
	mouseMode = "addNode";
	setSelectedControl(this);
}
controlContainer.addEdgeControl.info = "連接兩node可增加線";
controlContainer.addEdgeControl.onPress = function()
{
	trace("Mode = addEdge");
	mouseMode = "addEdge";
	setSelectedControl(this);
}
controlContainer.deleteControl.info = "點選或拖曳刪除點跟線";
controlContainer.deleteControl.onPress = function()
{
	trace("Mode = delete");
	mouseMode = "delete";
	setSelectedControl(this);
}
controlContainer.labelControl.info = "用點選node的方式分出兩個集合";
controlContainer.labelControl.onPress = function()
{
	trace("Mode = label");
	mouseMode = "label";
	setSelectedControl(this);
}
controlContainer.cutControl.info = "在畫面上畫一條cut切出兩個集合";
controlContainer.cutControl.onPress = function()
{
	trace("Mode = cut");
	mouseMode = "cut";
	setSelectedControl(this);
}
controlContainer.BFSControl.info = "用BFS來建立樹，點選任一node為root";
controlContainer.BFSControl.onPress = function()
{
	trace("Mode = BFS");
	mouseMode = "BFS";
	setSelectedControl(this);
}
controlContainer.DFSControl.info = "用DFS來建立樹，點選任一node為root";
controlContainer.DFSControl.onPress = function()
{
	trace("Mode = DFS");
	mouseMode = "DFS";
	setSelectedControl(this);
}
//不用改mode 的 control
controlContainer.complementGraphControl.info = "切換到補圖";
controlContainer.complementGraphControl.onPress = function()
{
	trace("ComplementGraph();");
	ComplementGraph();
	reflushWeightTable();
	reflushLaplacianTable();
}
controlContainer.componentAnalysisControl.info = "分析component，以顏色標示";
controlContainer.componentAnalysisControl.onPress = function()
{
	clearLabel();
	componentAnalysis();
	fitColorByLabelAll();
	reflushWeightTable();
	reflushLaplacianTable();
}
controlContainer.saveControl.info = "將目前的graph 以XML表示在下面文字方塊內";
controlContainer.saveControl.onPress = function()
{
	getGraphXML();
}
controlContainer.loadControl.info = "讀取下面文字方塊內的XML";
controlContainer.loadControl.onPress = function()
{
	loadGraphXML();
}
controlContainer.findBipartiteControl.info = "找bipartite，若有edge出現非灰色表示找不到";
controlContainer.findBipartiteControl.onPress = function()
{
	findBipartite();
}
controlContainer.findEularianRouteControl.info = "找EularianRoute";
controlContainer.findEularianRouteControl.onPress = function()
{
	findEularianRoute();
	mouseMode = "Eular";
}
//設定滑鼠移上去顯示說明文字
function informationBoxDrag()
{
	informationBox._x = _root._xmouse;
	informationBox._y = _root._ymouse;
}
for ( var i in controlContainer){
if(controlContainer[i] != controlContainer.xmlText){	
	controlContainer[i].onRollOver = function()
	{
		informationBox.onMouseMove = informationBoxDrag;
		informationBox.text.text = this.info;
	}
	
	controlContainer[i].onRollOut =
	controlContainer[i].onDragOut =
	function()
	{
		informationBox.onMouseMove = null;
		informationBox._y = -100;
	}
}}
//滑鼠行為
this.onMouseDown = initMouseDownFunction;
function initMouseDownFunction()
{
	var mx = this._xmouse;
	var my = this._ymouse;
	
	trace("");
	trace("root.onMouseDown");
		
	//如果滑鼠點到控制項就不作事
	if ( controlContainer.hitTest(mx,my,true) == true){}
	else if ( weightTableContainer.hitTest(mx,my,true) == true){}
	else if ( laplacianTableContainer.hitTest(mx,my,true) == true){}
	
	//move Node mode
	else if ( mouseMode == "moveNode" )
	{
		//如果滑鼠有點到 node 就作 drag
		if( nodeContainer.hitTest(mx,my,true) == true)
		{
			trace("  move Node mode");
			moveNodeModeStart();
		}
		//如果滑鼠有點到 edge 就作 drag
		else if( edgeContainer.hitTest(mx,my,true) == true)
		{
			trace("  move Edge mode");
			moveEdgeModeStart();
		}
	}
	
	//add Edge mode
	else if ( mouseMode == "addEdge" )
	{
		if( nodeContainer.hitTest(mx,my,true) == true)
		{
			trace("  add Edge mode");
			addEdgeModeStart();
		}
	}
	
	//add Node mode
	else if ( mouseMode == "addNode" )
	{
		trace("  add Node mode");
		addNodeModeStart();
	}
	
	//delete mode
	else if ( mouseMode == "delete" )
	{
		trace("  delete mode");
		deleteModeStart();
	}
	
	//label mode
	else if ( mouseMode == "label" )
	{
		//如果滑鼠有點到 node 就作 drag
		if( nodeContainer.hitTest(mx,my,true) == true)
		{
			trace("  label mode");
			labelModeStart();
		}
	}
	
	//cut mode
	else if ( mouseMode == "cut" )
	{
		trace("  cut mode");
		cutModeStart();
	}
	
	//BFS mode
	else if ( mouseMode == "BFS" )
	{
		//如果滑鼠有點到 node
		if( nodeContainer.hitTest(mx,my,true) == true)
		{
			trace("  BFS mode");
			BFSModeStart();
		}
	}
	
	//DFS mode
	else if ( mouseMode == "DFS" )
	{
		//如果滑鼠有點到 node
		if( nodeContainer.hitTest(mx,my,true) == true)
		{
			trace("  DFS mode");
			DFSModeStart();
		}
	}
}
// mode行為函數
function addNodeModeStart()
{
	var mx = this._xmouse;
	var my = this._ymouse;
	var Node = newNode();
	Node._x = mx;
	Node._y = my;
	this.onMouseMove = function()
	{
		Node._x = this._xmouse;
		Node._y = this._ymouse;
	}
	this.onMouseUp = function()
	{
		this.onMouseMove = null;
		this.onMouseUp = null;
	}
}
function moveNodeModeStart()
{
	var mx = this._xmouse;
	var my = this._ymouse;
	var node = searchNode(mx,my);
	trace(node);
	this.onMouseMove = function()
	{
		moveNode(node,this._xmouse,this._ymouse);
	}
	this.onMouseUp = function()
	{
		this.onMouseMove = null;
		this.onMouseUp = null;
	}
}
function moveEdgeModeStart()
{
	var mx = this._xmouse;
	var my = this._ymouse;
	var edge = searchEdge(mx,my);
	edge.ex = edge._x - mx;
	edge.ey = edge._y - my;
	this.onMouseMove = function()
	{
		var mx = this._xmouse;
		var my = this._ymouse;
		moveEdge(edge,mx,my);
	}
	this.onMouseUp = function()
	{
		this.onMouseMove = null;
		this.onMouseUp = null;
	}
}
function addEdgeModeStart()
{
	var mx = this._xmouse;
	var my = this._ymouse;
	var startNode = searchNode(mx,my);
	trace("startNode = "+ startNode);    
	var Edge = newEdge();
	Edge._x = startNode._x;
	Edge._y = startNode._y;
	Edge.i = startNode;
	this.onMouseMove = function()
	{
		var mx = this._xmouse;
		var my = this._ymouse;
		var dx = mx - Edge._x;
		var dy = my - Edge._y;
		var rotation = Math.atan2(dy,dx)*180/Math.PI;
		var distance = Math.sqrt(dx*dx+dy*dy);
		Edge._rotation = rotation;
		Edge._xscale = distance;
		adjustWeight(Edge.weight);
		
	}
	this.onMouseUp = function()
	{
		this.onMouseMove = null;
		this.onMouseUp = null;
		var mx = this._xmouse;
		var my = this._ymouse;
		var endNode = searchNode(mx,my);
		trace("endNode = " +endNode);
		
		if(endNode == null)
		{
			trace(" 沒有連到node");
			deleteEdge(Edge);
		}
		else if(Edge.i == endNode)
		{
			trace(" 自己連到自己");
			deleteEdge(Edge);
		}
		else if(isExistEdge(Edge.i,endNode) != null)
		{
			trace(" 已經存在此邊");
			deleteEdge(Edge);
		}
		//確定增加這條線
		else
		{
			//註冊
			Edge.j = endNode;
			startNode.edgeArray.push(Edge);
			endNode.edgeArray.push(Edge);
			//完美對齊
			adjustEdge(Edge);
		}
	}
}
function deleteModeStart()
{
	var mx = this._xmouse;
	var my = this._ymouse;
	var node = searchNode(mx,my);
	var edge = searchEdge(mx,my);
	if(node != null)
		deleteNode(node);
	else if(edge != null)
		deleteEdge(edge);
		
	this.onMouseMove = function()
	{
		var mx = this._xmouse;
		var my = this._ymouse;
		var node = searchNode(mx,my);
		var edge = searchEdge(mx,my);
		if(node != null)
			deleteNode(node);
		else if(edge != null)
			deleteEdge(edge);
	}
	this.onMouseUp = function()
	{
		this.onMouseMove = null;
		this.onMouseUp = null;
	}
}
function labelModeStart()
{
	var mx = this._xmouse;
	var my = this._ymouse;
	var node = searchNode(mx,my);
	changeLabel(node);
	cutByNode();
}
function cutModeStart()
{
	//清除所有選過的edge
	clearLabel();	
	fitColorByLabelAll();
	//進入主迴圈
	tempDrawContainer.lastX = this._xmouse;
	tempDrawContainer.lastY = this._ymouse;
	this.onMouseMove = function()
	{
		var mx = this._xmouse;
		var my = this._ymouse;
		var edgeArray = searchEdgeArray(mx,my);
		for(var i in edgeArray)
		{
			edgeArray[i].label = -1;
			fitColorByLabel(edgeArray[i]);
		}
		
		var edge = searchEdgeArray((tempDrawContainer.lastX+mx)/2,(tempDrawContainer.lastY+my)/2);
		for(var i in edgeArray)
		{
			edgeArray[i].label = -1;
			fitColorByLabel(edgeArray[i]);
		}
		
		newTempDrawLine(tempDrawContainer.lastX,tempDrawContainer.lastY,mx,my);
		tempDrawContainer.lastX = mx;
		tempDrawContainer.lastY = my;
	}
	//結束
	this.onMouseUp = function()
	{
		this.onMouseMove = null;
		this.onMouseUp = null;
		//清除暫存線
		clearTempDrawContainer();
		cutByEdge();
	}
}
function BFSModeStart()
{
	var mx = this._xmouse;
	var my = this._ymouse;
	var node = searchNode(mx,my);
	BFS(node);
}
function DFSModeStart()
{
	var mx = this._xmouse;
	var my = this._ymouse;
	var node = searchNode(mx,my);
	DFS(node);
}
//graph操作函數
//新增
//新增node
function newNode()
{
	var depth = nodeContainer.getNextHighestDepth();
	var Node = nodeContainer.attachMovie("NodeMC","Node-"+ depth,depth);
	Node.i = depth;
	Node.label = 0;
	Node.edgeArray = new Array();
	
	return Node;
}
//新增edge
function newEdge()
{
	var depth = edgeContainer.getNextHighestDepth();
	var Edge = edgeContainer.attachMovie("EdgeMC","Edge-"+depth,depth);
	Edge._xscale = 1;
	Edge.label = 0;
	Edge.weight = newWeight(Edge);
	return Edge;
}
//新增edge
function newEdgeByNode(nodeI,nodeJ)
{
	var depth = edgeContainer.getNextHighestDepth();
	var Edge = edgeContainer.attachMovie("EdgeMC","Edge-"+depth,depth);
	Edge.i = nodeI;
	Edge.j = nodeJ;
	nodeI.edgeArray.push(Edge);
	nodeJ.edgeArray.push(Edge);
	Edge.label = 0;
	Edge.weight = newWeight(Edge);
	adjustEdge(Edge);
	return Edge;
}
//新增weight
function newWeight(Edge)
{
	var depth = weightContainer.getNextHighestDepth();
	var Weight = weightContainer.attachMovie("WeightMC","Weight-"+depth,depth);
	Weight.edge = Edge;
	adjustWeight(Weight);
	return Weight;
}
//新增暫存線
function newTempDrawLine(sx,sy,tx,ty)
{
	var dx = tx-sx;
	var dy = ty-sy;
	var r = Math.atan2(dy,dx)/Math.PI*180;
	var d = Math.sqrt(dx*dx+dy*dy);
	
	var depth = tempDrawContainer.getNextHighestDepth();
	var line = tempDrawContainer.attachMovie("EdgeMC","Line-"+depth,depth);
	
	line._x = sx;
	line._y = sy;
	line._rotation = r;
	line._xscale = d;
	setColor(line,1,0.5,0.5);//淡紅
}
//搜尋
//輸入滑鼠作標 輸出點到哪個node
function searchNode(mx,my)
{
	var node = null;
	for(var i in nodeContainer)
		if(nodeContainer[i].hitTest(mx,my) == true)
			node = nodeContainer[i];
	return node;
}
//找第i個node
function searchNodeFromIndex(index)
{
	for(var i in nodeContainer)
		if(nodeContainer[i].i == index)
			return nodeContainer[i];
}
//輸入滑鼠作標 輸出點到哪個edge
function searchEdge(mx,my)
{
	var edge = null;
	for(var i in edgeContainer)
		if(edgeContainer[i].hitTest(mx,my,true) == true)
			edge = edgeContainer[i];
	return edge;
}
//輸入滑鼠作標 輸出點到哪個edge
function searchEdgeArray(mx,my)
{
	var edgeArray = new Array();
	for(var i in edgeContainer)
		if(edgeContainer[i].hitTest(mx,my,true) == true)
			edgeArray.push(edgeContainer[i]);
	return edgeArray;
}
//是否存在nodeI 連到 nodeJ 的 edge
function isExistEdge(nodeI,nodeJ)
{
	for(var i in edgeContainer)
	{
		if(edgeContainer[i].i == nodeI && edgeContainer[i].j == nodeJ )
			return edgeContainer[i];
		if(edgeContainer[i].j == nodeI && edgeContainer[i].i == nodeJ )
			return edgeContainer[i];
	}
	return null;
}
// node 所有連出去的edge 的 weight 的加總
function getNodeAssoc(Node)
{
	var d = 0;
	for(var i in Node.edgeArray)
		d += Number(Node.edgeArray[i].weight.T.T.text);
	return d;
}
// 給一個node和一個edge 
// 傳回這個 node 沿著 edge 過去的那個 node
function getOpposite(node,edge)
{
	if(edge.i == node)
		return edge.j;
	if(edge.j == node)
		return edge.i;
	return null;
}
//給一個Edge 傳回 Weight 的 Value
function getWeightValue(Edge)
{
	return Number(Edge.weight.T.T.text);
}
//編輯
//把node 移動到 tx ty
function moveNode(node,tx,ty)
{
	//trace("move " + node + " to ( " + tx + " , " + ty + " )");
	node._x = tx;
	node._y = ty;
	for(var i in node.edgeArray)
	{
		adjustEdge(node.edgeArray[i]);
	}
}
//把edge 移動到 tx ty
function moveEdge(edge,tx,ty)
{
	//trace("move " + node + " to ( " + tx + " , " + ty + " )");
	var startX = tx + edge.ex;
	var startY = ty + edge.ey;
	var endX = startX + edge._xscale * Math.cos( edge._rotation / 180 * Math.PI);
	var endY = startY + edge._xscale * Math.sin( edge._rotation / 180 * Math.PI);
	moveNode(edge.i,startX,startY);
	moveNode(edge.j,endX,endY);
}
//對齊
//微調 edge, 從edge.i 連到 edge.j
function adjustEdge(Edge)
{
	var dx = Edge.j._x - Edge.i._x;
	var dy = Edge.j._y - Edge.i._y;
	var rotation = Math.atan2(dy,dx)*180/Math.PI;
	var distance = Math.sqrt(dx*dx+dy*dy);
	Edge._x = Edge.i._x;
	Edge._y = Edge.i._y;
	Edge._rotation = rotation;
	Edge._xscale = distance;
	adjustWeight(Edge.weight);
}
//Weight 對齊 Edge
function adjustWeight(Weight)
{
	var sx = Weight.edge._x;
	var sy = Weight.edge._y;
	var tx = Weight.edge._x + Weight.edge._xscale * Math.cos( Weight.edge._rotation / 180 * Math.PI);
	var ty = Weight.edge._y + Weight.edge._xscale * Math.sin( Weight.edge._rotation / 180 * Math.PI);
	//相似度
	//var d = Math.round(Math.pow(Math.E,-Weight.edge._xscale/200)*100)/100;
	//平面距離
	var d = Math.round(Math.sqrt((sx-tx)*(sx-tx)+(sy-ty)*(sy-ty)));
	Weight._x = (sx+tx)/2;
	Weight._y = (sy+ty)/2;
	Weight.T.T.text = d;
}
//切換到補圖
function ComplementGraph()
{
	for(var i in nodeContainer)
	{
		var nodeI = nodeContainer[i];
		for(var j in nodeContainer)
		{
			var nodeJ = nodeContainer[j];
			if(nodeI.i < nodeJ.i)
			{
				var edge = isExistEdge(nodeI,nodeJ);
				if(edge == null)
					newEdgeByNode(nodeI,nodeJ);
				else
					deleteEdge(edge);
			}
		}
	}
}
//刪除
//刪除node
function deleteNode(Node)
{
	//刪除該 node 連到的 edge
	for(var i in Node.edgeArray)
		deleteEdge(Node.edgeArray[i]);
	//刪除該 node
	Node.removeMovieClip();
}
//刪除edge
function deleteEdge(Edge)
{
	//刪除連到該 edge 的 node 的註冊
	for(var i in Edge.i.edgeArray)
	{
		if(Edge.i.edgeArray[i] == Edge)
		{
			Edge.i.edgeArray[i] = Edge.i.edgeArray[Edge.i.edgeArray.length-1];
			Edge.i.edgeArray.pop();
		}
	}
	for(var i in Edge.j.edgeArray)
	{
		if(Edge.j.edgeArray[i] == Edge)
		{
			Edge.j.edgeArray[i] = Edge.j.edgeArray[Edge.j.edgeArray.length-1];
			Edge.j.edgeArray.pop();
		}
	}
	deleteWeight(Edge.weight);
	Edge.removeMovieClip();
}
function deleteAll()
{
	for(var i in nodeContainer)
		nodeContainer[i].removeMovieClip();
	for(var i in edgeContainer)
		edgeContainer[i].removeMovieClip();
	for(var i in weightContainer)
		weightContainer[i].removeMovieClip();
}
//刪除weight
function deleteWeight(weight)
{
	weight.removeMovieClip();
}
//移除暫存線
function clearTempDrawContainer()
{
	for(var i in tempDrawContainer)
		tempDrawContainer[i].removeMovieClip();
}
function clearWeightTable()
{
	for(var i in weightTableContainer)
		weightTableContainer[i].removeMovieClip();
}
function clearLaplacianTable()
{
	for(var i in laplacianTableContainer)
		laplacianTableContainer[i].removeMovieClip();
}
import mx.controls.Alert;
import flash.geom.Transform;
import flash.geom.ColorTransform;
//MC上色
function setColor(MC,R,G,B)
{
	var trans:Transform = new Transform(MC);
	trans.colorTransform = new ColorTransform(R, G, B, 1, 0, 0, 0, 0);
}
//根據 label 設定對應的顏色
function fitColorByLabel(MC)
{
	if( MC.label == -1)//灰
		setColor(MC,0.5,0.5,0.5);	
	if( MC.label == 0) //白
		setColor(MC,1,1,1);
	if( MC.label == 1) //淡綠
		setColor(MC,0.5,1,0.5);
	if( MC.label == 2) //淡黃
		setColor(MC,1,1,0.3);	
	if( MC.label == 3) //淡藍
		setColor(MC,0.6,0.6,1);	
	if( MC.label == 4) //淡紅
		setColor(MC,1,0.5,0.5);	
	if( MC.label == 5) //淡紫
		setColor(MC,1,0.75,1);	
	if( MC.label == 6) //淡橘
		setColor(MC,1,0.75,0.5);	
	if( MC.label > 6) //灰
		setColor(MC,0.5,0.5,0.5);	
}
function fitColorByLabelAll()
{
	for(var i in nodeContainer)
		fitColorByLabel(nodeContainer[i]);
	for(var i in edgeContainer)
		fitColorByLabel(edgeContainer[i]);
}
//換label
function changeLabel(MC)
{
	if( MC.label == 6)
		MC.label = 1;
	else
		MC.label ++;
	fitColorByLabel(MC)
}
//清除label
function clearLabel()
{
	for(var i in nodeContainer)
		nodeContainer[i].label = 0;
	for(var i in edgeContainer)
		edgeContainer[i].label = 0;
}
//上色
function flooding(node)
{
	//找這個node的邊
	for(var i in node.edgeArray)
	{
		//若未設定顏色
		if(node.edgeArray[i].label == 0)
		{
			//設定邊的顏色
			node.edgeArray[i].label = node.label;
			//設定邊的另一端的 node 的顏色
			if(node.edgeArray[i].i == node)
			{
				node.edgeArray[i].j.label = node.label;
				flooding(node.edgeArray[i].j);
			}
			else
			{
				node.edgeArray[i].i.label = node.label;
				flooding(node.edgeArray[i].i);				
			}
		}
	}
}
//component 分析
function componentAnalysis()
{
	label = 0;
	for(var i in nodeContainer)
	{
		var node = nodeContainer[i];
		if(node.label == 0)
		{
			label ++;
			node.label = label;
			flooding(node);
		}
	}
	return label;
}
//用目前node的 label 去設定 edge 的 label
function cutByNode()
{
	for(var i in edgeContainer)
	{
		if(edgeContainer[i].i.label == edgeContainer[i].j.label)
			edgeContainer[i].label = edgeContainer[i].i.label;
		else
			edgeContainer[i].label = -1;
		fitColorByLabel(edgeContainer[i]);
	}
}
//用目前的cut 紅線去設定其他 edge 和 node 的顏色
function cutByEdge()
{
	componentAnalysis();
	fitColorByLabelAll();
}
//Bipartite 分析
function findBipartite()
{
	for(var i in nodeContainer)
		nodeContainer[i].label = -1;
	for(var i in edgeContainer)
		edgeContainer[i].label = -1;
	for(var i in nodeContainer)
	{
		var node = nodeContainer[i];
		if(node.label == -1)
		{
			trace("findBipartiteFlooding(node)");
			findBipartiteFlooding(node);
		}
	}
}
//findBipartite
function findBipartiteFlooding(node)
{
	var A = new Array();
	A.push(node);
	node.label = 4;
	var treeDepth = new Array();	
	treeDepth[node.i] = 0;
	
	while (A.length > 0)
	{
		var nodeI = A.pop();
		var color;
		if( treeDepth[nodeI.i] % 2 == 0)
			color = 2;
		else
			color = 4;
		trace ("d = " + treeDepth[nodeI.i] + "  c = " + color)
		for(var i in nodeI.edgeArray)
		{
			//拿到edge對面那個node
			var nodeJ = getOpposite(nodeI,nodeI.edgeArray[i]);
			if(nodeJ.label == -1)
			{
				nodeI.edgeArray[i].label = color;
				nodeJ.label = color;
				treeDepth[nodeJ.i] = treeDepth[nodeI.i]+1;
				A.push(nodeJ);
				trace(nodeJ);
			}
		}
	}
	cutByNode();
	fitColorByLabelAll();
}
//BFS
function BFS(root)
{
	for(var i in nodeContainer)
		nodeContainer[i].label = -1;
	for(var i in edgeContainer)
		edgeContainer[i].label = -1;
		
	var color = 4;
	var A = new Array();
	var TreeArray = newTreeArray();
	
	A.push(root);
	TreeArray[root.i][root.i] = 1;
	
	while (A.length > 0)
	{
		var nodeI = A.pop();
		nodeI.label = color;
		for(var i in nodeI.edgeArray)
		{
			//拿到edge對面那個node
			var nodeJ = getOpposite(nodeI,nodeI.edgeArray[i]);
			trace(nodeJ);
			if(nodeJ.label != color)
			{
				nodeI.edgeArray[i].label = color;
				nodeJ.label = color;
				TreeArray[nodeI.i][nodeJ.i] = 1;
				A.push(nodeJ);
			}
		}
	}
	fitColorByLabelAll();
	
	for(var i = 0 ; i < TreeArray.length ; i++)
		trace(TreeArray[i]);
	printTreeInfo(TreeArray);
}
//DFS
function DFS(root)
{
	for(var i in nodeContainer)
		nodeContainer[i].label = -1;
	for(var i in edgeContainer)
		edgeContainer[i].label = -1;
		
	var color = 2;
	root.label = color;
	var TreeArray = newTreeArray();
	TreeArray[root.i][root.i] = 1;
	
	DFSflooding(root,TreeArray);
	fitColorByLabelAll();
	
	for(var i = 0 ; i < TreeArray.length ; i++)
		trace(TreeArray[i]);
	printTreeInfo(TreeArray);
}
//DFS函數專用的遞迴函數
function DFSflooding(node,TreeArray)
{
	//找這個node的邊
	for(var i in node.edgeArray)
	{
		var nodeJ = getOpposite(node,node.edgeArray[i]);
		//若未設定顏色
		if(nodeJ.label != node.label)
		{
			//設定邊的顏色
			node.edgeArray[i].label = node.label;
			nodeJ.label = node.label;
			TreeArray[node.i][nodeJ.i] = 1;
			DFSflooding(nodeJ,TreeArray);
		}
	}
}
//建立Tree 二維矩陣
function newTreeArray()
{
	var treeArray = new Array();
	var number = 0;
	for (var i in nodeContainer)
	if(typeof(nodeContainer[i]) == "movieclip")
		number ++;
	
	for (var i = 0 ; i < number ; i++)
	{
		treeArray[i] = new Array();
		for (var j = 0 ; j < number ; j++)
			treeArray[i][j] = "0";
	}
	
	return treeArray;
}
//印出Tree 二維矩陣的資訊
function printTreeInfo(TreeArray)
{
	var size = TreeArray.length;
	var p = new Array();
	var s = new Array();
	var eb = new Array();
	var yb = new Array();
	
	for(var i = 0 ; i < size ; i++)
	{
		p[i] = "@";
		s[i] = "@";
		eb[i] = "@";
		yb[i] = "@";
	}
	
	for(var i = 0 ; i < size ; i++)
	{
		var sonArray = new Array();
		for(var j = 0 ; j < size ; j++)
		{
			if (TreeArray[i][j] == 1)
			{
				//p
				if(i != j)
				{
					p[j] = i;
					sonArray.push(j);
				}
			}
			if(sonArray.length > 0)
				s[i] = sonArray[0];
				
			if(sonArray.length > 1)
			for(var k = 0 ; k < sonArray.length ; k++)
			{
				if( k > 0)
					eb[sonArray[k]] = sonArray[k-1];
	
				if( k < sonArray.length-1)
					yb[sonArray[k]] = sonArray[k+1];
			}
		}
		trace(sonArray.length);
	}
	trace("p:"+p);
	trace("s:"+s);
	trace("eb:"+eb);
	trace("yb:"+yb);
	var str = "";
	for (var i = 0 ; i < size ; i++)
		str += TreeArray[i].toString() +"\n";
	str += "\np:" + p + "\ns:" + s + "\neb:" + eb + "\nyb:" + yb;
	controlContainer.xmlText.text = str;
}
import mx.controls.Alert;
function findEularianRoute()
{
	clearLabel();
	fitColorByLabelAll();
	
	//判斷如果是多個component 就直接跳出
	var componentNumber = componentAnalysis();
	//Alert.show("componentNumber = " + componentNumber);
	if(componentNumber > 1)
	{
		fitColorByLabelAll();
		Alert.show("系統不支援多個component以上的EularianRoute");
		return 0;
	}
	//建立weightArray
	var weightArray = newWeightArray();
	
	//印出weightArray
	controlContainer.xmlText.text = "原始 weight 矩陣\n";
	print2DArray(weightArray);
	
	//建立最短路徑matrix (另存虛擬 edge 是由哪兩個 edge 組成)
	var P = getShortestMatrix(weightArray);
	
	controlContainer.xmlText.text += "\n最短 weight 矩陣\n";
	print2DArray(weightArray);
	
	controlContainer.xmlText.text += "\n路徑矩陣\n";
	print2DArray(P);
	
	//找odd Node
	var oddArray = getOddDegreeNodeIndex(weightArray);
	//建立 odd Node pairs
	var pairs = getPairs(oddArray);
	
	controlContainer.xmlText.text += "\npairs\n";
	print2DArray(pairs);
	
	//計算 pair cost (一個pair對應到一個cost)
	var costs = new Array();
	for(var i = 0 ; i < pairs.length ; i++) // 跑pair
	{
		costs[i] = 0;
		for(var j = 0 ; j < pairs[i].length ; j+=2) //加總cost
			costs[i] += weightArray[ pairs[i][j] ][ pairs[i][j+1] ];
	}
	
	controlContainer.xmlText.text += "\ncosts\n";
	controlContainer.xmlText.text += costs.join("\n");
	
	//找出最小的cost
	var minCost = 0;
	for(var i = 1 ; i < costs.length ; i++)
		if(costs[minCost] > costs[i])
			minCost = i;
	//選到的pair到底是啥
	var currentOddPair = pairs[minCost];
	
	controlContainer.xmlText.text += "\ncurrentOddPair\n";
	controlContainer.xmlText.text += currentOddPair.join("\t");
	
	//得到每個edge可以經過幾次
	var edgeCountTable = getEdgeCountTable(P,currentOddPair);
	
	controlContainer.xmlText.text += "\nEdge可經過幾次矩陣\n";
	print2DArray(edgeCountTable);
	
	//開始找 cycles (把所有edge都用掉)
	var cycles = new Array();
	trace("sum2DArray(edgeCountTable) = " + sum2DArray(edgeCountTable));
	while(sum2DArray(edgeCountTable)>0)
	{
		trace("sum2DArray(edgeCountTable) = " + sum2DArray(edgeCountTable));
		var cycle = new Array();
		//找到第一個非零元素
		var flag = 0;
		var start;
		var from;
		for(var i = 0 ; i < edgeCountTable.length ; i++)
		{
			for(var j = 0 ; j < edgeCountTable.length ; j++)
			{
				if(Number(edgeCountTable[i][j]) > 0)	
				{
					flag = 1;
					start = i;
					from = j;
				}
				if(flag == 1) 
					break;
			}
			if(flag == 1) 
				break;
		}
		trace(" i = " + i + ", j = " + j);
		//從node i 開始記錄 往 node j 移動
		cycle.push(start);
		cycle.push(from);
		edgeCountTable[start][from]--;
		edgeCountTable[from][start]--;
		
		while (from != start)
		{
			//找出可移動的node
			var to = 0;
			for(to = 0 ; to < edgeCountTable.length ; to++)
				if( edgeCountTable[from][to] > 0)
					break;
			
			cycle.push(to);
			edgeCountTable[from][to]--;
			edgeCountTable[to][from]--;
			from = to;
		}
		cycles[cycles.length] = cycle;
	}
	
	controlContainer.xmlText.text += "\nEdge可經過幾次矩陣\n";
	print2DArray(edgeCountTable);
	
	controlContainer.xmlText.text += "\ncycles\n";
	print2DArray(cycles);
	
	//把 cycles 連成 route
	var route = getRouteFromCycles(cycles);
	route = route[0];
	
	controlContainer.xmlText.text += "\nroute\n";
	controlContainer.xmlText.text += route.join("\t");
	
	//撥放動畫
	playEularianRouteAnimation(route);
}
function playEularianRouteAnimation(routeArray)
{
	var Eular = _root.attachMovie("man","Eular",this.getNextHighestDepth());
	var node = searchNodeFromIndex(routeArray[0]);
	Eular._x = node._x;
	Eular._y = node._y;
	
	trace("node = " + node);
	var frameCount = 0;
	var n = 0;
	var m = 0;
	this.onEnterFrame = function()
	{
		m = frameCount % 20;
		n = (frameCount - m)/20;
		//trace(n + "  " + m);
		
		var nodeI = searchNodeFromIndex(routeArray[n]);
		var nodeJ = searchNodeFromIndex(routeArray[n+1]);
		if(m == 10)
		{
			var edge = isExistEdge(nodeI,nodeJ);
			edge.label++;
			fitColorByLabel(edge);
		}
		
		Eular._x = (20-m)/20*nodeI._x + m/20*nodeJ._x ;
		Eular._y = (20-m)/20*nodeI._y + m/20*nodeJ._y ;
		
		if(n < routeArray.length)
			frameCount++;
		else
			this.onEnterFrame = function()
			{
				Eular._alpha -= 5;
				if(Eular._alpha <= 0)
				{
					Eular.removeMovieClip();
					this.onEnterFrame = null;
				}
			}
	}
}
function getRouteFromCycles(cycles)
{
	while (cycles.length > 1)
	{
		//隨便選一個cycle，把他換到第1個
		var rand = int(Math.random()*cycles.length);
		var temp = cycles[rand];
		cycles[rand] = cycles[0];
		cycles[0] = temp;
	
		controlContainer.xmlText.text += "\ncycles\n";
		print2DArray(cycles);
	
		//找到其他 cycle 的起點出現在第1個cycle中的位置
		for(var i = 1 ; i < cycles.length ; i++)
		{
			var start = cycles[i][0];
			var flag = 0;
			
			//找到就merge
			for(var j = 0 ; j < cycles[0].length ; j++)
				if(start == cycles[0][j])
				{
					flag = 1;
					//merge
					var array1 = cycles[0].slice(0,j);
					var array2 = cycles[i].slice(0,cycles[i].length);
					var array3 = cycles[0].slice(j+1,cycles[0].length);
					
					if(j == 0)
						cycles[0] = array2.concat(array3);
					else
						cycles[0] = array1.concat(array2,array3);
					
					//刪除第i個cycle
					cycles[i] = cycles[cycles.length-1];
					cycles.pop();
					break;
				}
			if(flag == 1)
				break;
		}
	}
	return cycles;
}
//得到每個edge可以經過幾次
function getEdgeCountTable(P,currentOddPair)
{
	//這些pair是增加哪些edge
	var currentAddEdge = new Array();
	while(currentOddPair.length > 0)
	{
		trace("currentOddPair = " + currentOddPair);
		var i = currentOddPair.shift();
		var j = currentOddPair.shift();
		//判斷i j 是不是虛擬連線
		if(P[i][j] != -1)
		{
			currentOddPair.push(i,P[i][j]);
			currentOddPair.push(P[i][j],j);
		}
		else
		{
			currentAddEdge.push(i,j);
		}
	}
	//計算每個edge可以經過幾次
	var edgeCountTable = new Array();
	for(var i = 0 ; i < P.length ; i++)
		edgeCountTable[i] = new Array();
	for(var i = 0 ; i < P.length ; i++)
	for(var j = 0 ; j < P.length ; j++)
			edgeCountTable[i][j] = 0;
	
	for(var k in edgeContainer)
	if(typeof(edgeContainer[k]) == "movieclip")
	{
		var i = edgeContainer[k].i.i;
		var j = edgeContainer[k].j.i;
		edgeCountTable[i][j] ++;
		edgeCountTable[j][i] ++;
	}
	
	//增加edge
	while(currentAddEdge.length > 0)
	{
		var i = currentAddEdge.shift();
		var j = currentAddEdge.shift();
		edgeCountTable[i][j] ++;
		edgeCountTable[j][i] ++;
	}
	
	return edgeCountTable;
}
//建立Weight 二維矩陣 (對角線放degree)
function newWeightArray()
{
	var weightArray = new Array();
	var number = 0;
	for (var i in nodeContainer)
	if(typeof(nodeContainer[i]) == "movieclip")
			number ++;
	
	for (var i = 0 ; i < number ; i++)
	{
		weightArray[i] = new Array();
		for (var j = 0 ; j < number ; j++)
			weightArray[i][j] = "99999";
	}
	
	for(var k in edgeContainer)
	if(typeof(edgeContainer[k]) == "movieclip")
	{
		var i = edgeContainer[k].i.i;
		var j = edgeContainer[k].j.i;
		var w = getWeightValue(edgeContainer[k]);
		weightArray[i][j] = w;
		weightArray[j][i] = w;
	}
	
	for (var k in nodeContainer)
	if(typeof(nodeContainer[k]) == "movieclip")
	{
		var i = nodeContainer[k].i;
		weightArray[i][i] = nodeContainer[k].edgeArray.length;
	}
	
	return weightArray;
}
//印出2DArray資料
function print2DArray(Array)
{
	var str = "";
	for(var i = 0 ; i < Array.length ; i++)
	{
		for(var j = 0 ; j < Array[i].length ; j++)
		{
			str += Array[i][j] + "\t" ;
		}
		str += "\n";
	}
	controlContainer.xmlText.text += str;
}
//列出degree 奇數的node 的編號
function getOddDegreeNodeIndex(weightArray)
{
	var oddDegreeNodeIndexArray = new Array();
	for(var i = 0 ; i < weightArray.length ; i++)
	if(weightArray[i][i] % 2 == 1)
		oddDegreeNodeIndexArray.push(i);
	return oddDegreeNodeIndexArray;
}
//得到最短距離矩陣(因為是傳址可以直接修改內容，傳回路徑矩陣P)
function getShortestMatrix(weightArray)
{
	//Floyd's algorithm
	var N = weightArray.length;
	var P = new Array();
	for(var i = 0 ; i < N ; i++ )
		P[i] = new Array();
	for(var i = 0 ; i < N ; i++ )
	for(var j = 0 ; j < N ; j++ )
		P[i][j] = -1;
	
	//i 連到 j 透過 k
	for(var k = 0 ; k < N ; k++ )
	for(var i = 0 ; i < N ; i++ )
	for(var j = 0 ; j < N ; j++ )
	if (weightArray[i][j] > weightArray[i][k] + weightArray[k][j])
	{
		weightArray[i][j] = weightArray[i][k] + weightArray[k][j];
		P[i][j] = k;
	}
	
	return P;
}
//給資料點數量 建立pair 
function getPairs(A)
{
	//作出數列 a1,a2,...,an 必須滿足
	//a1 < a3 < a5 < ... < an-1
	//a1 < a2, a3 < a4, a5 < a6, ... an-1 < an
	//對A數列作窮舉排列
	var ans = new Array();
	Permutation(ans,new Array(),A);
	return ans;
}
function Permutation(ans,nowArray,waitingArray)
{
	//trace("");
	//trace("Permutation");
	//trace("  ans = " + ans);
	//trace("  nowArray = " + nowArray);
	//trace("  waitingArray = " + waitingArray);
		
	//排完
	if(waitingArray.length == 0)
		ans[ans.length] = nowArray;
	else
	{
		//現在要排的數字是第幾個
		var odd = (nowArray.length +1 )% 2;
		//放入下一個
		for(var i = 0 ; i < waitingArray.length ; i++)
		{
			nowArray2 = nowArray.slice(0,nowArray.length);
			waitingArray2 = waitingArray.slice(0,waitingArray.length)
			
			//如果還沒放東西
			if(nowArray.length == 0)
			{
				//waitingArray的第i個元素放進nowArray
				nowArray2[nowArray2.length] = waitingArray2[i];
				//移除waitingArray的第i個元素(最後1個移到第i個，再幹掉最後一個)
				waitingArray2[i] = waitingArray2[waitingArray2.length-1];
				waitingArray2.pop();
				//遞迴
				Permutation(ans,nowArray2,waitingArray2);
			}
			//要排的是第偶數個
			else if(odd == 0)
			{
				//要比前一個大
				if(waitingArray2[i] > nowArray2[nowArray2.length-1])
				{
					//waitingArray的第i個元素放進nowArray
					nowArray2[nowArray2.length] = waitingArray2[i];
					//移除waitingArray的第i個元素(最後1個移到第i個，再幹掉最後一個)
					waitingArray2[i] = waitingArray2[waitingArray2.length-1];
					waitingArray2.pop();
					//遞迴
					Permutation(ans,nowArray2,waitingArray2);
				}
			}
			//要排的是第奇數個
			else
			{
				//要比前前一個大
				if(waitingArray2[i] > nowArray2[nowArray2.length-2])
				{
					//waitingArray的第i個元素放進nowArray
					nowArray2[nowArray2.length] = waitingArray2[i];
					//移除waitingArray的第i個元素(最後1個移到第i個，再幹掉最後一個)
					waitingArray2[i] = waitingArray2[waitingArray2.length-1];
					waitingArray2.pop();
					//遞迴
					Permutation(ans,nowArray2,waitingArray2);
				}
			}
		}
	}
}
//陣列加總
function sum2DArray(A)
{
	var sum = 0;
	for(var i = 0 ; i < A.length ; i++)
	for(var j = 0 ; j < A.length ; j++)
		sum += A[i][j];
	return sum;
}
/*註1
node.id 是用來讓edge找到對應的node 
因為深度值有可能會在node重複的增加減少後產生錯誤
所以 node.id 不能覆蓋代表深度的 node.i
*/
function getGraphXML()
{
	var str;
	str = "<graph>\n";
	var nodeStr = "";
	var tempStr = "";
	for(var i in nodeContainer)
	{if(typeof(nodeContainer[i]) == "movieclip"){
		tempStr = "";
		var node = nodeContainer[i];
		tempStr += "   <node ";
		tempStr += "id=\"" + node.i + "\" "; //註1
		tempStr += "x=\"" + node._x + "\" ";
		tempStr += "y=\"" + node._y + "\" ";
		tempStr += "label=\"" + node.label + "\" ";
		tempStr += "/>";
		nodeStr = tempStr + "\n" + nodeStr;
	}else 
	trace(nodeContainer[i] + "     " + typeof(nodeContainer[i]));
	}
	str += nodeStr;
	for(var i in edgeContainer)
	{if(typeof(edgeContainer[i]) == "movieclip"){
		var edge = edgeContainer[i];
		str += "   <edge ";
		str += "iid=\"" + edge.i.i + "\" ";
		str += "jid=\"" + edge.j.i + "\" ";
		str += "label=\"" + edge.label + "\" ";
		str += "/>\n";
	}}
	str += "</graph>";
	controlContainer.xmlText.text = str;
}
function loadGraphXML()
{
	deleteAll();
	var myXml = new XML();
	myXml.ignoreWhite = true;
	myXml.parseXML(controlContainer.xmlText.text);
	var rootNode = myXml.firstChild;
	for(var node = rootNode.firstChild ; node != null ; node = node.nextSibling)
	{
		if(node.nodeName == "node")
			newNodeByXML(node);
		if(node.nodeName == "edge")
			newEdgeByXML(node);
	}
	fitColorByLabelAll();
}
function newNodeByXML(xml)
{
	trace("newNodeByXML(xml)");
	trace("xml = " + xml);
	var node = newNode();
	node._x = Number(xml.attributes.x);
	node._y = Number(xml.attributes.y);
	node.id = Number(xml.attributes.id);
	node.label = Number(xml.attributes.label);
}
function newEdgeByXML(xml)
{
	trace("newEdgeByXML(xml)");
	trace("xml = " + xml);
	var nodeI = searchNodeById(Number(xml.attributes.iid));
	var nodeJ = searchNodeById(Number(xml.attributes.jid));
	var edge = newEdgeByNode(nodeI,nodeJ);
	edge.label = Number(xml.attributes.label);
}
function searchNodeById(id)
{
	var node = null;
	for(var i in nodeContainer)
		if(nodeContainer[i].id == id)
			node = nodeContainer[i];
	return node;
}
