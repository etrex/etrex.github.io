//�w�q�ƹ��\��
var mouseMode = "moveNode";
//����欰
//���b�ϥΪ�mode�H�ŮؼХ�
function setSelectedControl(control)
{
	controlContainer.selectedControl._x = control._x;
	controlContainer.selectedControl._y = control._y;
}
//�]�w������r�H�ηƹ����U�\��
controlContainer.moveNodeControl.info = "�Ψө즲�I��u";
controlContainer.moveNodeControl.onPress = function()
{
	trace("Mode = moveNode");
	mouseMode = "moveNode";
	setSelectedControl(this);
}
controlContainer.addNodeControl.info = "�I��e���i�W�[�I";
controlContainer.addNodeControl.onPress = function()
{
	trace("Mode = addNode");
	mouseMode = "addNode";
	setSelectedControl(this);
}
controlContainer.addEdgeControl.info = "�s����node�i�W�[�u";
controlContainer.addEdgeControl.onPress = function()
{
	trace("Mode = addEdge");
	mouseMode = "addEdge";
	setSelectedControl(this);
}
controlContainer.deleteControl.info = "�I��Ω즲�R���I��u";
controlContainer.deleteControl.onPress = function()
{
	trace("Mode = delete");
	mouseMode = "delete";
	setSelectedControl(this);
}
controlContainer.labelControl.info = "���I��node���覡���X��Ӷ��X";
controlContainer.labelControl.onPress = function()
{
	trace("Mode = label");
	mouseMode = "label";
	setSelectedControl(this);
}
controlContainer.cutControl.info = "�b�e���W�e�@��cut���X��Ӷ��X";
controlContainer.cutControl.onPress = function()
{
	trace("Mode = cut");
	mouseMode = "cut";
	setSelectedControl(this);
}
controlContainer.BFSControl.info = "��BFS�ӫإ߾�A�I����@node��root";
controlContainer.BFSControl.onPress = function()
{
	trace("Mode = BFS");
	mouseMode = "BFS";
	setSelectedControl(this);
}
controlContainer.DFSControl.info = "��DFS�ӫإ߾�A�I����@node��root";
controlContainer.DFSControl.onPress = function()
{
	trace("Mode = DFS");
	mouseMode = "DFS";
	setSelectedControl(this);
}
//���Χ�mode �� control
controlContainer.complementGraphControl.info = "������ɹ�";
controlContainer.complementGraphControl.onPress = function()
{
	trace("ComplementGraph();");
	ComplementGraph();
	reflushWeightTable();
	reflushLaplacianTable();
}
controlContainer.componentAnalysisControl.info = "���Rcomponent�A�H�C��Х�";
controlContainer.componentAnalysisControl.onPress = function()
{
	clearLabel();
	componentAnalysis();
	fitColorByLabelAll();
	reflushWeightTable();
	reflushLaplacianTable();
}
controlContainer.saveControl.info = "�N�ثe��graph �HXML��ܦb�U����r�����";
controlContainer.saveControl.onPress = function()
{
	getGraphXML();
}
controlContainer.loadControl.info = "Ū���U����r�������XML";
controlContainer.loadControl.onPress = function()
{
	loadGraphXML();
}
controlContainer.findBipartiteControl.info = "��bipartite�A�Y��edge�X�{�D�Ǧ��ܧ䤣��";
controlContainer.findBipartiteControl.onPress = function()
{
	findBipartite();
}
controlContainer.findEularianRouteControl.info = "��EularianRoute";
controlContainer.findEularianRouteControl.onPress = function()
{
	findEularianRoute();
	mouseMode = "Eular";
}
//�]�w�ƹ����W�h��ܻ�����r
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
//�ƹ��欰
this.onMouseDown = initMouseDownFunction;
function initMouseDownFunction()
{
	var mx = this._xmouse;
	var my = this._ymouse;
	
	trace("");
	trace("root.onMouseDown");
		
	//�p�G�ƹ��I�챱��N���@��
	if ( controlContainer.hitTest(mx,my,true) == true){}
	else if ( weightTableContainer.hitTest(mx,my,true) == true){}
	else if ( laplacianTableContainer.hitTest(mx,my,true) == true){}
	
	//move Node mode
	else if ( mouseMode == "moveNode" )
	{
		//�p�G�ƹ����I�� node �N�@ drag
		if( nodeContainer.hitTest(mx,my,true) == true)
		{
			trace("  move Node mode");
			moveNodeModeStart();
		}
		//�p�G�ƹ����I�� edge �N�@ drag
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
		//�p�G�ƹ����I�� node �N�@ drag
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
		//�p�G�ƹ����I�� node
		if( nodeContainer.hitTest(mx,my,true) == true)
		{
			trace("  BFS mode");
			BFSModeStart();
		}
	}
	
	//DFS mode
	else if ( mouseMode == "DFS" )
	{
		//�p�G�ƹ����I�� node
		if( nodeContainer.hitTest(mx,my,true) == true)
		{
			trace("  DFS mode");
			DFSModeStart();
		}
	}
}
// mode�欰���
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
			trace(" �S���s��node");
			deleteEdge(Edge);
		}
		else if(Edge.i == endNode)
		{
			trace(" �ۤv�s��ۤv");
			deleteEdge(Edge);
		}
		else if(isExistEdge(Edge.i,endNode) != null)
		{
			trace(" �w�g�s�b����");
			deleteEdge(Edge);
		}
		//�T�w�W�[�o���u
		else
		{
			//���U
			Edge.j = endNode;
			startNode.edgeArray.push(Edge);
			endNode.edgeArray.push(Edge);
			//�������
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
	//�M���Ҧ���L��edge
	clearLabel();	
	fitColorByLabelAll();
	//�i�J�D�j��
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
	//����
	this.onMouseUp = function()
	{
		this.onMouseMove = null;
		this.onMouseUp = null;
		//�M���Ȧs�u
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
//graph�ާ@���
//�s�W
//�s�Wnode
function newNode()
{
	var depth = nodeContainer.getNextHighestDepth();
	var Node = nodeContainer.attachMovie("NodeMC","Node-"+ depth,depth);
	Node.i = depth;
	Node.label = 0;
	Node.edgeArray = new Array();
	
	return Node;
}
//�s�Wedge
function newEdge()
{
	var depth = edgeContainer.getNextHighestDepth();
	var Edge = edgeContainer.attachMovie("EdgeMC","Edge-"+depth,depth);
	Edge._xscale = 1;
	Edge.label = 0;
	Edge.weight = newWeight(Edge);
	return Edge;
}
//�s�Wedge
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
//�s�Wweight
function newWeight(Edge)
{
	var depth = weightContainer.getNextHighestDepth();
	var Weight = weightContainer.attachMovie("WeightMC","Weight-"+depth,depth);
	Weight.edge = Edge;
	adjustWeight(Weight);
	return Weight;
}
//�s�W�Ȧs�u
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
	setColor(line,1,0.5,0.5);//�H��
}
//�j�M
//��J�ƹ��@�� ��X�I�����node
function searchNode(mx,my)
{
	var node = null;
	for(var i in nodeContainer)
		if(nodeContainer[i].hitTest(mx,my) == true)
			node = nodeContainer[i];
	return node;
}
//���i��node
function searchNodeFromIndex(index)
{
	for(var i in nodeContainer)
		if(nodeContainer[i].i == index)
			return nodeContainer[i];
}
//��J�ƹ��@�� ��X�I�����edge
function searchEdge(mx,my)
{
	var edge = null;
	for(var i in edgeContainer)
		if(edgeContainer[i].hitTest(mx,my,true) == true)
			edge = edgeContainer[i];
	return edge;
}
//��J�ƹ��@�� ��X�I�����edge
function searchEdgeArray(mx,my)
{
	var edgeArray = new Array();
	for(var i in edgeContainer)
		if(edgeContainer[i].hitTest(mx,my,true) == true)
			edgeArray.push(edgeContainer[i]);
	return edgeArray;
}
//�O�_�s�bnodeI �s�� nodeJ �� edge
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
// node �Ҧ��s�X�h��edge �� weight ���[�`
function getNodeAssoc(Node)
{
	var d = 0;
	for(var i in Node.edgeArray)
		d += Number(Node.edgeArray[i].weight.T.T.text);
	return d;
}
// ���@��node�M�@��edge 
// �Ǧ^�o�� node �u�� edge �L�h������ node
function getOpposite(node,edge)
{
	if(edge.i == node)
		return edge.j;
	if(edge.j == node)
		return edge.i;
	return null;
}
//���@��Edge �Ǧ^ Weight �� Value
function getWeightValue(Edge)
{
	return Number(Edge.weight.T.T.text);
}
//�s��
//��node ���ʨ� tx ty
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
//��edge ���ʨ� tx ty
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
//���
//�L�� edge, �qedge.i �s�� edge.j
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
//Weight ��� Edge
function adjustWeight(Weight)
{
	var sx = Weight.edge._x;
	var sy = Weight.edge._y;
	var tx = Weight.edge._x + Weight.edge._xscale * Math.cos( Weight.edge._rotation / 180 * Math.PI);
	var ty = Weight.edge._y + Weight.edge._xscale * Math.sin( Weight.edge._rotation / 180 * Math.PI);
	//�ۦ���
	//var d = Math.round(Math.pow(Math.E,-Weight.edge._xscale/200)*100)/100;
	//�����Z��
	var d = Math.round(Math.sqrt((sx-tx)*(sx-tx)+(sy-ty)*(sy-ty)));
	Weight._x = (sx+tx)/2;
	Weight._y = (sy+ty)/2;
	Weight.T.T.text = d;
}
//������ɹ�
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
//�R��
//�R��node
function deleteNode(Node)
{
	//�R���� node �s�쪺 edge
	for(var i in Node.edgeArray)
		deleteEdge(Node.edgeArray[i]);
	//�R���� node
	Node.removeMovieClip();
}
//�R��edge
function deleteEdge(Edge)
{
	//�R���s��� edge �� node �����U
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
//�R��weight
function deleteWeight(weight)
{
	weight.removeMovieClip();
}
//�����Ȧs�u
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
//MC�W��
function setColor(MC,R,G,B)
{
	var trans:Transform = new Transform(MC);
	trans.colorTransform = new ColorTransform(R, G, B, 1, 0, 0, 0, 0);
}
//�ھ� label �]�w�������C��
function fitColorByLabel(MC)
{
	if( MC.label == -1)//��
		setColor(MC,0.5,0.5,0.5);	
	if( MC.label == 0) //��
		setColor(MC,1,1,1);
	if( MC.label == 1) //�H��
		setColor(MC,0.5,1,0.5);
	if( MC.label == 2) //�H��
		setColor(MC,1,1,0.3);	
	if( MC.label == 3) //�H��
		setColor(MC,0.6,0.6,1);	
	if( MC.label == 4) //�H��
		setColor(MC,1,0.5,0.5);	
	if( MC.label == 5) //�H��
		setColor(MC,1,0.75,1);	
	if( MC.label == 6) //�H��
		setColor(MC,1,0.75,0.5);	
	if( MC.label > 6) //��
		setColor(MC,0.5,0.5,0.5);	
}
function fitColorByLabelAll()
{
	for(var i in nodeContainer)
		fitColorByLabel(nodeContainer[i]);
	for(var i in edgeContainer)
		fitColorByLabel(edgeContainer[i]);
}
//��label
function changeLabel(MC)
{
	if( MC.label == 6)
		MC.label = 1;
	else
		MC.label ++;
	fitColorByLabel(MC)
}
//�M��label
function clearLabel()
{
	for(var i in nodeContainer)
		nodeContainer[i].label = 0;
	for(var i in edgeContainer)
		edgeContainer[i].label = 0;
}
//�W��
function flooding(node)
{
	//��o��node����
	for(var i in node.edgeArray)
	{
		//�Y���]�w�C��
		if(node.edgeArray[i].label == 0)
		{
			//�]�w�䪺�C��
			node.edgeArray[i].label = node.label;
			//�]�w�䪺�t�@�ݪ� node ���C��
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
//component ���R
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
//�Υثenode�� label �h�]�w edge �� label
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
//�Υثe��cut ���u�h�]�w��L edge �M node ���C��
function cutByEdge()
{
	componentAnalysis();
	fitColorByLabelAll();
}
//Bipartite ���R
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
			//����edge�ﭱ����node
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
			//����edge�ﭱ����node
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
//DFS��ƱM�Ϊ����j���
function DFSflooding(node,TreeArray)
{
	//��o��node����
	for(var i in node.edgeArray)
	{
		var nodeJ = getOpposite(node,node.edgeArray[i]);
		//�Y���]�w�C��
		if(nodeJ.label != node.label)
		{
			//�]�w�䪺�C��
			node.edgeArray[i].label = node.label;
			nodeJ.label = node.label;
			TreeArray[node.i][nodeJ.i] = 1;
			DFSflooding(nodeJ,TreeArray);
		}
	}
}
//�إ�Tree �G���x�}
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
//�L�XTree �G���x�}����T
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
	
	//�P�_�p�G�O�h��component �N�������X
	var componentNumber = componentAnalysis();
	//Alert.show("componentNumber = " + componentNumber);
	if(componentNumber > 1)
	{
		fitColorByLabelAll();
		Alert.show("�t�Τ��䴩�h��component�H�W��EularianRoute");
		return 0;
	}
	//�إ�weightArray
	var weightArray = newWeightArray();
	
	//�L�XweightArray
	controlContainer.xmlText.text = "��l weight �x�}\n";
	print2DArray(weightArray);
	
	//�إ̵߳u���|matrix (�t�s���� edge �O�ѭ���� edge �զ�)
	var P = getShortestMatrix(weightArray);
	
	controlContainer.xmlText.text += "\n�̵u weight �x�}\n";
	print2DArray(weightArray);
	
	controlContainer.xmlText.text += "\n���|�x�}\n";
	print2DArray(P);
	
	//��odd Node
	var oddArray = getOddDegreeNodeIndex(weightArray);
	//�إ� odd Node pairs
	var pairs = getPairs(oddArray);
	
	controlContainer.xmlText.text += "\npairs\n";
	print2DArray(pairs);
	
	//�p�� pair cost (�@��pair������@��cost)
	var costs = new Array();
	for(var i = 0 ; i < pairs.length ; i++) // �]pair
	{
		costs[i] = 0;
		for(var j = 0 ; j < pairs[i].length ; j+=2) //�[�`cost
			costs[i] += weightArray[ pairs[i][j] ][ pairs[i][j+1] ];
	}
	
	controlContainer.xmlText.text += "\ncosts\n";
	controlContainer.xmlText.text += costs.join("\n");
	
	//��X�̤p��cost
	var minCost = 0;
	for(var i = 1 ; i < costs.length ; i++)
		if(costs[minCost] > costs[i])
			minCost = i;
	//��쪺pair�쩳�Oԣ
	var currentOddPair = pairs[minCost];
	
	controlContainer.xmlText.text += "\ncurrentOddPair\n";
	controlContainer.xmlText.text += currentOddPair.join("\t");
	
	//�o��C��edge�i�H�g�L�X��
	var edgeCountTable = getEdgeCountTable(P,currentOddPair);
	
	controlContainer.xmlText.text += "\nEdge�i�g�L�X���x�}\n";
	print2DArray(edgeCountTable);
	
	//�}�l�� cycles (��Ҧ�edge���α�)
	var cycles = new Array();
	trace("sum2DArray(edgeCountTable) = " + sum2DArray(edgeCountTable));
	while(sum2DArray(edgeCountTable)>0)
	{
		trace("sum2DArray(edgeCountTable) = " + sum2DArray(edgeCountTable));
		var cycle = new Array();
		//���Ĥ@�ӫD�s����
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
		//�qnode i �}�l�O�� �� node j ����
		cycle.push(start);
		cycle.push(from);
		edgeCountTable[start][from]--;
		edgeCountTable[from][start]--;
		
		while (from != start)
		{
			//��X�i���ʪ�node
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
	
	controlContainer.xmlText.text += "\nEdge�i�g�L�X���x�}\n";
	print2DArray(edgeCountTable);
	
	controlContainer.xmlText.text += "\ncycles\n";
	print2DArray(cycles);
	
	//�� cycles �s�� route
	var route = getRouteFromCycles(cycles);
	route = route[0];
	
	controlContainer.xmlText.text += "\nroute\n";
	controlContainer.xmlText.text += route.join("\t");
	
	//����ʵe
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
		//�H�K��@��cycle�A��L�����1��
		var rand = int(Math.random()*cycles.length);
		var temp = cycles[rand];
		cycles[rand] = cycles[0];
		cycles[0] = temp;
	
		controlContainer.xmlText.text += "\ncycles\n";
		print2DArray(cycles);
	
		//����L cycle ���_�I�X�{�b��1��cycle������m
		for(var i = 1 ; i < cycles.length ; i++)
		{
			var start = cycles[i][0];
			var flag = 0;
			
			//���Nmerge
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
					
					//�R����i��cycle
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
//�o��C��edge�i�H�g�L�X��
function getEdgeCountTable(P,currentOddPair)
{
	//�o��pair�O�W�[����edge
	var currentAddEdge = new Array();
	while(currentOddPair.length > 0)
	{
		trace("currentOddPair = " + currentOddPair);
		var i = currentOddPair.shift();
		var j = currentOddPair.shift();
		//�P�_i j �O���O�����s�u
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
	//�p��C��edge�i�H�g�L�X��
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
	
	//�W�[edge
	while(currentAddEdge.length > 0)
	{
		var i = currentAddEdge.shift();
		var j = currentAddEdge.shift();
		edgeCountTable[i][j] ++;
		edgeCountTable[j][i] ++;
	}
	
	return edgeCountTable;
}
//�إ�Weight �G���x�} (�﨤�u��degree)
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
//�L�X2DArray���
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
//�C�Xdegree �_�ƪ�node ���s��
function getOddDegreeNodeIndex(weightArray)
{
	var oddDegreeNodeIndexArray = new Array();
	for(var i = 0 ; i < weightArray.length ; i++)
	if(weightArray[i][i] % 2 == 1)
		oddDegreeNodeIndexArray.push(i);
	return oddDegreeNodeIndexArray;
}
//�o��̵u�Z���x�}(�]���O�ǧ}�i�H�����ק鷺�e�A�Ǧ^���|�x�}P)
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
	
	//i �s�� j �z�L k
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
//������I�ƶq �إ�pair 
function getPairs(A)
{
	//�@�X�ƦC a1,a2,...,an ��������
	//a1 < a3 < a5 < ... < an-1
	//a1 < a2, a3 < a4, a5 < a6, ... an-1 < an
	//��A�ƦC�@�a�|�ƦC
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
		
	//�Ƨ�
	if(waitingArray.length == 0)
		ans[ans.length] = nowArray;
	else
	{
		//�{�b�n�ƪ��Ʀr�O�ĴX��
		var odd = (nowArray.length +1 )% 2;
		//��J�U�@��
		for(var i = 0 ; i < waitingArray.length ; i++)
		{
			nowArray2 = nowArray.slice(0,nowArray.length);
			waitingArray2 = waitingArray.slice(0,waitingArray.length)
			
			//�p�G�٨S��F��
			if(nowArray.length == 0)
			{
				//waitingArray����i�Ӥ�����inowArray
				nowArray2[nowArray2.length] = waitingArray2[i];
				//����waitingArray����i�Ӥ���(�̫�1�Ӳ����i�ӡA�A�F���̫�@��)
				waitingArray2[i] = waitingArray2[waitingArray2.length-1];
				waitingArray2.pop();
				//���j
				Permutation(ans,nowArray2,waitingArray2);
			}
			//�n�ƪ��O�İ��ƭ�
			else if(odd == 0)
			{
				//�n��e�@�Ӥj
				if(waitingArray2[i] > nowArray2[nowArray2.length-1])
				{
					//waitingArray����i�Ӥ�����inowArray
					nowArray2[nowArray2.length] = waitingArray2[i];
					//����waitingArray����i�Ӥ���(�̫�1�Ӳ����i�ӡA�A�F���̫�@��)
					waitingArray2[i] = waitingArray2[waitingArray2.length-1];
					waitingArray2.pop();
					//���j
					Permutation(ans,nowArray2,waitingArray2);
				}
			}
			//�n�ƪ��O�ĩ_�ƭ�
			else
			{
				//�n��e�e�@�Ӥj
				if(waitingArray2[i] > nowArray2[nowArray2.length-2])
				{
					//waitingArray����i�Ӥ�����inowArray
					nowArray2[nowArray2.length] = waitingArray2[i];
					//����waitingArray����i�Ӥ���(�̫�1�Ӳ����i�ӡA�A�F���̫�@��)
					waitingArray2[i] = waitingArray2[waitingArray2.length-1];
					waitingArray2.pop();
					//���j
					Permutation(ans,nowArray2,waitingArray2);
				}
			}
		}
	}
}
//�}�C�[�`
function sum2DArray(A)
{
	var sum = 0;
	for(var i = 0 ; i < A.length ; i++)
	for(var j = 0 ; j < A.length ; j++)
		sum += A[i][j];
	return sum;
}
/*��1
node.id �O�Ψ���edge��������node 
�]���`�׭Ȧ��i��|�bnode���ƪ��W�[��֫Უ�Ϳ��~
�ҥH node.id �����л\�N��`�ת� node.i
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
		tempStr += "id=\"" + node.i + "\" "; //��1
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
