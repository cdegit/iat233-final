package  
{

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TransformGestureEvent;
	import flash.geom.Matrix;
	import assets.Map;
	import flash.geom.Vector3D;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	/**
	 * MapLayer
	 * Shows the map layer.
	 * @author Charlie Chao
	 */
	public class MapLayer extends Sprite 
	{
		
		// attributes
		private var map:Map;
		private var dragging:Boolean;
		private var px:int;
		private var py:int;
		
		private var scaleLevel:Number = 1;
		
		// graph stuff
		public var graph:Graph = new Graph();
		public var nodes:Array = new Array();
		
		public var edges:Array = new Array();
		
		private var currentNodes:Array = new Array();
		private var astar:Astar;
		private var edge:Edge;
		
		private var nodeLoader:URLLoader = new URLLoader();
		
		private var label:TextField;
		
		private var data:XML;
		private var xmlLoaded:Boolean = false;
		private var textParser:TextParser;
		
		public function MapLayer() 
		{
			map = new Map();
			addChild(map);
			addEventListener(Event.ADDED_TO_STAGE, added);
			
			loadXml();
			
			addEventListener(NodeClicked.NODE_CLICKED, nodeClickedHandler);
			nodeLoader.addEventListener(Event.COMPLETE, onLoaded);
			
			label = new TextField();
			label.text = String(scaleLevel);
			addChild(label);
		}
		
		// added to screen handler
		public function added(e:Event = null):void 
		{
			// attach event listeners for manipulating the map
			parent.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			parent.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
			
			addEventListener(TransformGestureEvent.GESTURE_ZOOM, onZoom);
		}
		
		// zooms map elements to specified position
		private function zoomMap(originX:int, originY:int, zoom:Number):void
		{
			var m:Matrix = transform.matrix;
			m.translate(-originX, -originY);			
			m.scale(zoom, zoom);
			m.translate(originX, originY);
			transform.matrix = m;
		}
		
		// mouse down handler
		private function mouseDown(e:MouseEvent):void
		{
			dragging = true;
			px = stage.mouseX;
			py = stage.mouseY;
		}
		
		// mouse move handler
		private function mouseMove(e:MouseEvent):void
		{
			// handle map dragging
			if (dragging) {
				var dx:int = (stage.mouseX - px);
				var dy:int = (stage.mouseY - py);
				x += dx;
				y += dy;
				px = stage.mouseX;
				py = stage.mouseY;
			}
		}
		
		// mouse up handler
		private function mouseUp(e:MouseEvent):void
		{
			dragging = false;	// stops dragging the map
		}
		
		// mouse wheel handler
		public function mouseWheel(e:MouseEvent):void
		{
			// handle map zoom
			if (e.delta > 0) zoomMap(stage.mouseX, stage.mouseY, 1.2);
			else zoomMap(stage.mouseX, stage.mouseY, 0.8);
		}
		
		public function onZoom(e:TransformGestureEvent):void
		{
			var tempScale:Number = (e.scaleX + e.scaleY) / 2;
			if (tempScale < 1) {
				tempScale = -tempScale;
			} else {
				tempScale -= 1;
			}
			scaleLevel += tempScale;
			zoomMap(e.localX, e.localY, (e.scaleX + e.scaleY) / 2);
			label.text = String(scaleLevel);
		}
		
		
		// Put the graph stuff into here? Should work with nodes' x, y?
		
		public function nodeClickedHandler(event:NodeClicked):void
		{
			currentNodes.push(event.node);
			if (currentNodes.length >= 2) 
			{
				graph.redraw();
				//We create a new Astar search that will look a path from the clicked nodes
				astar= new Astar(graph,currentNodes[0].getIndex(), currentNodes[1].getIndex());
				astar.getPath();
				currentNodes = new Array();
			}
		}
		
		public function onLoaded(event:Event):void
		{
			// process it here
			var data:Array = event.target.data.split('\n');
			var i:int, j:int;
			var d:Array;
			//nodes.length = 0; // resets current nodes
			for (i = 0; i < data.length; i++) {
				// add node to model
				d = (String)(data[i]).split(",");
				//nodes.push(new Node(d[1], d[2], d[0]));
				// d[0] is name of node
				trace(d[1] + ", " + d[2]);
				nodes.push([d[1], d[2], d[0]]);
			}
			
			for (i = 0; i < nodes.length; i++) {
				// add connected nodes to each node in the model
				d = (String)(data[i]).split(",");
				for (j = 3; j < d.length; j++) 
				{
					//nodes[i].addNode(nodes[d[j]]);
					edges.push([i, d[j]]);
				}
			}
			//dispatchEvent(new NodeEvent(NodeEvent.NODE_UPDATE));
			
			createMap();
		}
		
		public function createMap():void 
		{
			//A loop in order to create all the nodes
            for(var a:int=0;a<nodes.length;a++)
            {
				var node:Node;
				if (nodes[a][2].length > 0) {
					//make it a location instead
					var desc:String;
					var img:String;
					
					//while (!xmlLoaded) {
						// Wait for the xml to load
						//there must be a better way to do this
					//}
					
					if (xmlLoaded) {
						desc = textParser.getDesc(nodes[a][2]);
						img = textParser.getImg(nodes[a][2]);
					}
					var imgLabel:TextField = new TextField();
					imgLabel.text = String("image location:" + img);
					addChild(imgLabel);
					node = new Location(Graph.getNextIndex(), new Vector3D(nodes[a][0], nodes[a][1]), nodes[a][2], desc, img);
				} else {
					node = new Node(Graph.getNextIndex(), new Vector3D(nodes[a][0], nodes[a][1]));
				}
				node.render();
                graph.addNode(node);
                addChild(node);
            }
			
			
          //Another loop to create all the edges between nodes
            for(var b:int=0;b<edges.length;b++)
            {
                var from:int = edges[b][0];
                var to:int = edges[b][1];
 
                edge = new Edge(from,to,Vector3D.distance(graph.getNode(from).getPos(),graph.getNode(to).getPos()));
                graph.addEdge(edge);
                //Since the drawEdge method requires the position vectors, we get the nodes
                //from the graph with their index and then get their position with getPos()
                edge.drawEdge(graph.getNode(from).getPos(),graph.getNode(to).getPos());
                addChild(edge);
            }
		}
		
		private function loadXml():void
		{
			var myLoader:URLLoader = new URLLoader();
			myLoader.load(new URLRequest("locations.xml"));
			myLoader.addEventListener(Event.COMPLETE, processXML);
			function processXML(e:Event):void {
				data = new XML(myLoader.data);
				data.ignoreWhitespace=true;
				myLoader.removeEventListener(Event.COMPLETE, processXML);
				textParser = new TextParser(data);
				xmlLoaded = true;
				nodeLoader.load(new URLRequest("nodes4.nl"));
			}
		}
		
	}

}