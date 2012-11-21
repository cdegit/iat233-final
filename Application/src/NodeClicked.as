package  
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Cassandra de Git and Charlie Chao
	 */
	public class NodeClicked extends Event 
	{
		public static const NODE_CLICKED:String = "node clicked";
		public var node:Node;
		
		public function NodeClicked(type:String, node:Node, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			this.node = node;
			
		} 
		
		public override function clone():Event 
		{ 
			return new NodeClicked(type, node, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("NodeClicked", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}