package  
{

	/**
	 * ActivitiesPanel
	 * 
	 * @author Charlie Chao
	 */
	public class ActivitiesPanel extends Panel 
	{
		// attributes
		public static const WIDTH:int = 300;
		public static const BUTTONS_OFFSET:int = 200;
		
		// components
		public var activitiesButton:Vector.<LinkedPanelButton>;
		
		public function ActivitiesPanel(sprites:Spritesheet) 
		{
			super(WIDTH, Main.CATEGORY_MAIN_MENU, sprites, "placeholder"); // TODO: icon
			x = 0;									// makes the panel fades in only
			title.text = "Activities";
		}
		
		// initializes the buttons
		override public function constructButtons(panels:Vector.<Panel>):void
		{
			
			// setup buttons
			var buttonWidth:int = (WIDTH - CommonStyle.PANEL_PADDING * 3) / 2;
			var buttonX:int = CommonStyle.PANEL_PADDING;
			var buttonY:int = BUTTONS_OFFSET + MenuButton.BUTTON_HEIGHT;
			activitiesButton = new Vector.<LinkedPanelButton>;
			activitiesButton.push(new LinkedPanelButton("TEST", buttonX, buttonY, buttonWidth, 140, spriteSheet.getSprite("placeholder"), panels[Main.PANEL_ACTIVITIES]));
			buttonX = CommonStyle.PANEL_PADDING * 2 + buttonWidth;
			activitiesButton.push(new LinkedPanelButton("Activities", buttonX, buttonY, buttonWidth, 140, spriteSheet.getSprite("placeholder"), panels[Main.PANEL_ACTIVITIES]));
			//buttonX = CommonStyle.PANEL_PADDING;
			//buttonY += MenuButton.BUTTON_HEIGHT + BUTTONS_SPACING;
			//activitiesButton.push(new LinkedPanelButton("Activities", buttonX, buttonY, buttonWidth, 140, spriteSheet.getSprite("placeholder"), panels[Main.PANEL_ACTIVITIES]));
			//buttonY += MenuButton.BUTTON_HEIGHT + BUTTONS_SPACING;
			
			// add to screen
			for each (var a:LinkedPanelButton in activitiesButton) {
				addChild(a);
			}
		}
		
	}

}