package  
{
	import flash.display.BitmapData;
	import flash.events.MouseEvent;

	/**
	 * LinkedPanelButton
	 * 
	 * @author Charlie Chao
	 */
	public class LinkedPanelButton extends FlatButton 
	{
		// attributes
		public var linkedPanel:Panel;
		
		public function LinkedPanelButton(labelText:String, x:int, y:int, width:int, height:int, iconData:BitmapData, linkedPanel:Panel)
		{
			super(labelText, x, y, width, height, iconData);
			this.linkedPanel = linkedPanel;
			
			// add click event
			listen();
		}
		
		// opens panel
		public function openPanel(e:MouseEvent):void 
		{
			dispatchEvent(new PanelEvent(PanelEvent.PANEL_OPEN));
		}
		
		// attachs panel opening listener
		override public function listen():void {
			super.listen();
			addEventListener(MouseEvent.MOUSE_UP, openPanel);
		}
		
		// detaches panel opening listener
		override public function unlisten():void {
			super.unlisten();
			if (hasEventListener(MouseEvent.MOUSE_UP)) removeEventListener(MouseEvent.MOUSE_DOWN, openPanel);
		}		
	}

}