package  
{

	/**
	 * QuickFindPanel
	 * 
	 * @author Charlie Chao
	 */
	public class QuickFindPanel extends Panel 
	{
		// attributes
		public static const WIDTH:int = 260;
		
		public function QuickFindPanel(sprites:Spritesheet) 
		{
			super(WIDTH, Main.CATEGORY_QUICK_FIND, sprites, "placeholder"); // TODO: icon
			title.text = "Quick Find";
		}
		
	}

}