package  
{

	/**
	 * InfoButton
	 * 
	 * @author Charlie Chao
	 */
	public class InfoButton extends LinkedPanelButton 
	{
		// attributes
		public static var infoPanel:Panel;		// global info button reference to info panel
		public var infoID:String;				// id for info panel
			
		public function InfoButton(labelText:String, x:int, y:int, width:int, height:int, iconData:BitmapData, infoID:String)
		{
			super(labelText, x, y, width, height, iconData);
			linkedPanel = infoPanel;
			
			// add click event
			listen();
		}
		
		// opens panel
		override public function openPanel(e:MouseEvent):void 
		{
			dispatchEvent(new PanelEvent(PanelEvent.PANEL_OPEN, infoID));
		}
		
	}

}