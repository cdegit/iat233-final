package  
{
	import flash.text.TextFormat;
	/**
	 * ColorScheme
	 * Static storage of UI element colours.
	 * @author Charlie Chao
	 */
	public class CommonStyle 
	{
		/**
		 * Colors
		 */
		
		// panels
		public static const PANEL_COLOR_BG:uint = 0x222222;
		public static const PANEL_COLOR_TITLE_BAR:uint = 0xFFFFFF;
		public static const PANEL_COLOR_TITLE:uint = 0x222222;
		//buttons
		public static const BUTTON_COLOR_LABEL:uint = 0xFFFFFF;
		public static const BUTTON_COLOR_BG:uint = 0xFFFFFF;
		public static const BUTTON_COLOR_BG_DOWN:uint = 0xCCCCCC;
		// side buttons
		public static const SIDE_BUTTON_COLOR_BG:uint = 0x222222;
		public static const SIDE_BUTTON_COLOR_BG_OVER:uint = 0x444444;
		public static const SIDE_BUTTON_COLOR_BAR:uint = 0xF48A01;
		// main menu
		public static const MAIN_MENU_COLOR_TITLE:uint = 0x222222;
		
		/**
		 * Fonts
		 */
		
		// panels
		public static const PANEL_FORMAT_TITLE:TextFormat = new TextFormat("DIN Engschrift Std", 36, PANEL_COLOR_TITLE);
		// buttons
		public static const BUTTON_FORMAT_LABEL:TextFormat = new TextFormat("Arial", 12, PANEL_COLOR_TITLE);
		// main menu
		public static const MAIN_MENU_FORMAT_TITLE:TextFormat = new TextFormat("DIN Engschrift Std", 24, MAIN_MENU_COLOR_TITLE);
		
		/**
		 * Metrics
		 */
		
		// panels
		public static const PANEL_PADDING:int = 15;
		public static const PANEL_TITLE_OFFSET:int = 160;
		public static const PANEL_TITLE_HEIGHT:int = 48;
		// side buttons
		public static const SIDE_BUTTON_SIZE:int = 48;
		public static const SIDE_BUTTON_SPACING:int = 10;
		// panel buttons
		public static const PANEL_BUTTON_SIZE:int = 32;
		
	}

}