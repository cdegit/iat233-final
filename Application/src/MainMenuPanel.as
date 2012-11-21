package  
{
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	/**
	 * MainMenuPanel
	 * 
	 * @author Charlie Chao
	 */
	public class MainMenuPanel extends Panel 
	{
		// attributes
		public static const WIDTH:int = 300;
		public static const BUTTONS_OFFSET:int = 200;
		public static const BUTTONS_SPACING:int = 20;
		
		// components
		private var buttonActivities:MenuButton;
		private var buttonFacilities:MenuButton;
		private var buttonEvents:MenuButton;
		private var buttonsAbout:MenuButton;
		
		public function MainMenuPanel(sprites:Spritesheet) 
		{
			super(WIDTH, Main.CATEGORY_MAIN_MENU, sprites, "placeholder"); // TODO: icon
			title.text = "Main Menu";
		}
		
		// initializes the buttons
		override public function constructButtons(panels:Vector.<Panel>):void
		{
			// setup buttons
			var buttonWidth:int = WIDTH - CommonStyle.PANEL_PADDING * 2;
			var buttonY:int = BUTTONS_OFFSET + MenuButton.BUTTON_HEIGHT;
			buttonActivities = new MenuButton("Activities", CommonStyle.PANEL_PADDING, buttonY, buttonWidth, spriteSheet.getSprite("placeholder"), panels[Main.PANEL_ACTIVITIES]);
			buttonY += MenuButton.BUTTON_HEIGHT + BUTTONS_SPACING;
			buttonFacilities = new MenuButton("Points of Interest", CommonStyle.PANEL_PADDING, buttonY, buttonWidth, spriteSheet.getSprite("placeholder"), panels[Main.PANEL_FACILITIES]);
			buttonY += MenuButton.BUTTON_HEIGHT + BUTTONS_SPACING;
			buttonEvents = new MenuButton("Events", CommonStyle.PANEL_PADDING, buttonY, buttonWidth, spriteSheet.getSprite("placeholder"), null);
			buttonY += MenuButton.BUTTON_HEIGHT + BUTTONS_SPACING;
			buttonsAbout = new MenuButton("About", CommonStyle.PANEL_PADDING, buttonY, buttonWidth, spriteSheet.getSprite("placeholder"), null);
			
			// add to screen
			addChild(buttonActivities);
			addChild(buttonFacilities);
			addChild(buttonEvents);
			addChild(buttonsAbout);
		}
		
		// renders panel
		//override public function render():void 
		//{
			//super.render();			
		//}
		//
		// added to screen handler
		//override public function added(e:Event = null):void 
		//{
			//super.added(e);
		//}
		
	}

}