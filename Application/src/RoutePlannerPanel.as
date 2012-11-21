package  
{

	/**
	 * RoutePlannerPanel
	 * 
	 * @author Charlie Chao
	 */
	public class RoutePlannerPanel extends Panel 
	{
		// attributes
		public static const WIDTH:int = 260;
		
		public function RoutePlannerPanel(sprites:Spritesheet) 
		{
			super(WIDTH, Main.CATEGORY_ROUTE_PLANNER, sprites, "placeholder"); // TODO: icon
			title.text = "Route Planner";
		}
		
	}

}