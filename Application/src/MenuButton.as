package  
{
	import flash.display.BitmapData;
	import flash.events.Event;

	/**
	 * MenuButton
	 * 
	 * @author Charlie Chao
	 */
	public class MenuButton extends LinkedPanelButton 
	{
		
		// constants
		public static const BUTTON_HEIGHT:int = 48;
		
		public function MenuButton(labelText:String, x:int, y:int, width:int, iconData:BitmapData, linkedPanel:Panel)
		{
			super(labelText, x, y, width, BUTTON_HEIGHT, iconData, linkedPanel);
			label.defaultTextFormat = CommonStyle.MAIN_MENU_FORMAT_TITLE;
			label.text = labelText;
		}
		
		override public function render(e:Event = null):void 
		{
			super.render(e);
			
			// determine spacing
			var space:int = (buttonHeight - icon.height) / 2;
			
			// re-position elements
			icon.x = (space < 0)?0:space;
			icon.y = (space < 0)?0:space;
			if (label != null) {
				label.x = CommonStyle.PANEL_PADDING + icon.width;
				label.y = buttonHeight / 2 - label.height / 2;
			}
		}
		
	}

}