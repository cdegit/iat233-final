package 
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.geom.Vector3D;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.plugins.HexColorsPlugin;
	
	/**
	 * ...
	 * @author Cassandra de Git and Charlie Chao
	 */
	public class Main extends Sprite 
	{
		
		// constants
		public static const CATEGORY_MAIN_MENU:int = 0;
		public static const CATEGORY_QUICK_FIND:int = 1;
		public static const CATEGORY_ROUTE_PLANNER:int = 2;	
		
		public static const PANEL_MAIN_MENU:int = 0;
		public static const PANEL_ACTIVITIES:int = 1;
		public static const PANEL_FACILITIES:int = 2;
		public static const PANEL_QUICK_FIND:int = 3;
		public static const PANEL_ROUTE_PLANNER:int = 4;
		
		// resources
		[Embed(source='assets/DINEngschriftStd.otf', fontName='DIN', mimeType='application/x-font')] 
		public var fontDIN:Class;
		public var spriteSheet:Spritesheet;
		
		// UI elements
		public var mapLayer:MapLayer;
		public var activePanel:Panel;
		public var panels:Vector.<Panel>;
		public var panelMainMenu:MainMenuPanel;
		public var panelActivities:ActivitiesPanel;
		public var panelFacilities:FacilitiesPanel;
		public var panelQuickFind:QuickFindPanel;
		public var panelRoutePlanner:RoutePlannerPanel;
		public var sideButtons:Vector.<SideButton>;
		
		/*
		public var graph:Graph = new Graph();
		public var nodes:Array = new Array();
		
		public var edges:Array = new Array();
		
		private var currentNodes:Array = new Array();
		private var astar:Astar;
		private var edge:Edge;
		
		private var nodeLoader:URLLoader = new URLLoader();
		*/
		
		public function Main():void 
		{
			// stage setup
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			TweenPlugin.activate([HexColorsPlugin]);					// allows hex color tweening for the TweenLite plugin
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.GESTURE;
			
			/*
			addEventListener(NodeClicked.NODE_CLICKED, nodeClickedHandler);
			nodeLoader.addEventListener(Event.COMPLETE, onLoaded);
			nodeLoader.load(new URLRequest("nodes4.nl"));
			*/
			
			// entry point
			// new to AIR? please read *carefully* the readme.txt files!
			
			// load spritesheet
			spriteSheet = new Spritesheet("assets.json");
			spriteSheet.addEventListener(StateEvent.READY, initializeUI);

		}
		
		private function initializeUI(e:StateEvent):void 
		{
			// remove event listener
			spriteSheet.removeEventListener(StateEvent.READY, initializeUI);
			
			// initialize UI
			try {
				// map
				mapLayer = new MapLayer();
				
				// panels
				panels = new Vector.<Panel>;
				panels.push(new MainMenuPanel(spriteSheet));
				panels.push(new ActivitiesPanel(spriteSheet));
				panels.push(new FacilitiesPanel(spriteSheet));
				panels.push(new QuickFindPanel(spriteSheet));
				panels.push(new RoutePlannerPanel(spriteSheet));
				// construct buttons with the panels initialized
				for each (var p:Panel in panels) { p.constructButtons(panels); }
				
				// side buttons
				sideButtons = new Vector.<SideButton>;
				sideButtons.push(new SideButton(0, 0, CommonStyle.SIDE_BUTTON_SIZE, CommonStyle.SIDE_BUTTON_SIZE, spriteSheet.getSprite("side_button_main_menu"), panels[PANEL_MAIN_MENU]));
				sideButtons.push(new SideButton(0, 0, CommonStyle.SIDE_BUTTON_SIZE, CommonStyle.SIDE_BUTTON_SIZE, spriteSheet.getSprite("side_button_quick_find"), panels[PANEL_QUICK_FIND]));
				sideButtons.push(new SideButton(0, 0, CommonStyle.SIDE_BUTTON_SIZE, CommonStyle.SIDE_BUTTON_SIZE, spriteSheet.getSprite("side_button_route_planner"), panels[PANEL_ROUTE_PLANNER]));
				
				// add components to stage
				addChild(mapLayer);
				addChild(sideButtons[CATEGORY_MAIN_MENU]);
				addChild(sideButtons[CATEGORY_QUICK_FIND]);
				addChild(sideButtons[CATEGORY_ROUTE_PLANNER]);
				//addChild(new FlatButton("TEST", 0, 0, 100, 100, spriteSheet.getSprite("placeholder")));
			} catch (e:TypeError) {
				trace("Could not load sprite data!\n" + e.message);
			}
			
			// position UI elements based on screen size
			stage.addEventListener(Event.RESIZE, resizeUI);
			stage.addEventListener(PanelEvent.PANEL_OPEN, panelHandler);
			resizeUI();
			
			// attach user input
			
		}
		
		// re-adjust UI elements position
		private function resizeUI(e:Event = null):void 
		{
			// side buttons
			sideButtons[CATEGORY_MAIN_MENU].x = sideButtons[CATEGORY_QUICK_FIND].x = sideButtons[CATEGORY_ROUTE_PLANNER].x = stage.stageWidth - CommonStyle.SIDE_BUTTON_SIZE;
			sideButtons[CATEGORY_MAIN_MENU].y = sideButtons[CATEGORY_QUICK_FIND].y = sideButtons[CATEGORY_ROUTE_PLANNER].y = stage.stageHeight / 2 - CommonStyle.SIDE_BUTTON_SIZE / 2;
			sideButtons[CATEGORY_MAIN_MENU].y -=  CommonStyle.SIDE_BUTTON_SIZE + CommonStyle.SIDE_BUTTON_SPACING;
			sideButtons[CATEGORY_ROUTE_PLANNER].y += CommonStyle.SIDE_BUTTON_SIZE + CommonStyle.SIDE_BUTTON_SPACING;
			
			// active panel
			if (activePanel != null) activePanel.render();
		}
		
		// handles panel opening
		private function panelHandler(e:PanelEvent = null):void 
		{
			var target:LinkedPanelButton = LinkedPanelButton(e.target);
			// set side buttons state
			var i:int;
			for (i = 0; i < sideButtons.length; i++) {
				if (target.linkedPanel == null || i != target.linkedPanel.category) 
					sideButtons[i].setState(false);
			}
			// show panel
			if (target.linkedPanel != null && activePanel != target.linkedPanel) { // panel is not visible...
				if (this.contains(target.linkedPanel)) target.linkedPanel.fadeIn();	// fades panel in if it is still on screen
				else addChild(target.linkedPanel);									// adds panel to screen
				if (activePanel != null) {
					// set previous panel
					if (activePanel.previousPanel != target.linkedPanel)
						target.linkedPanel.previousPanel = activePanel;
					// fade out previous panel
					activePanel.fadeOut(); // fades out previously open panel
				}
				activePanel = target.linkedPanel;									// sets new active panel
			} else { // button linked to no panel...
				// close the panel
				if (activePanel != null) activePanel.fadeOut();
				activePanel = null;
				for each (var p:Panel in panels) { p.previousPanel = null; }
			}
		}
		
		// closes app
		private function deactivate(e:Event):void 
		{
			// auto-close
			NativeApplication.nativeApplication.exit();
		}
		
		/*
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
					node = new Location(Graph.getNextIndex(), new Vector3D(nodes[a][0], nodes[a][1]), nodes[a][2]);
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
		*/
		
	}
	
}