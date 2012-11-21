package  
{
	
	import flash.events.Event;
	
	/**
	 * PanelEvent
	 * Updates a panel.
	 * @author Charlie Chao
	 */
	public class PanelEvent extends Event 
	{
		
		public static const PANEL_OPEN:String = "panelOpen";
		public var infoID:String;
		
		public function PanelEvent(type:String, infoID:String = null) 
		{ 
			super(type, true, false);
			this.infoID = infoID;
		} 
		
		public override function clone():Event 
		{ 
			return new PanelEvent(type);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("PanelEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}