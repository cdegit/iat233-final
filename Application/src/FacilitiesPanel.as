package  
{

	/**
	 * FacilitiesPanel
	 * 
	 * @author Charlie Chao
	 */
	public class FacilitiesPanel extends Panel 
	{
		// attributes
		public static const WIDTH:int = 300;
		
		public function FacilitiesPanel(sprites:Spritesheet) 
		{
			super(WIDTH, Main.CATEGORY_MAIN_MENU, sprites, "placeholder"); // TODO: icon
			x = 0;									// makes the panel fades in only
			title.text = "Points of Interest";
		}
		
	}

}