package  
{
	
	import com.greensock.TweenLite;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * SideButton
	 * A side button for quick access.
	 * @author Charlie Chao
	 */
	public class SideButton extends LinkedPanelButton 
	{
		
		// constants
		public static const BAR_WIDTH:int = 6;
		
		// attributes
		private var active:Boolean;
		
		// animation
		private var tween:TweenLite;
		public var barX:int = 0;
		
		public function SideButton(x:int, y:int, width:int, height:int, iconData:BitmapData, linkedPanel:Panel) 
		{
			super(null, x, y, width, height, iconData, linkedPanel);
			bgColor = CommonStyle.SIDE_BUTTON_COLOR_BG;
			bgColorDown = CommonStyle.SIDE_BUTTON_COLOR_BG_OVER;
			
			// setup animation
			tween = new TweenLite(this, 0.2, {barX: -BAR_WIDTH, hexColors:{bgColor: bgColorDown}, onUpdate: updateBar});
			tween.paused = true;
		}
		
		// opens panel
		override public function openPanel(e:MouseEvent):void 
		{
			if (!active) setState(true);
			dispatchEvent(new PanelEvent(PanelEvent.PANEL_OPEN));
		}
		
		// updates state bar
		private function updateBar():void 
		{
			graphics.clear();
			graphics.beginFill(CommonStyle.SIDE_BUTTON_COLOR_BAR);
			graphics.drawRect(barX, 0, BAR_WIDTH, buttonHeight);
			graphics.endFill();
			drawBackground();
		}
		
		// sets button state
		public function setState(active:Boolean):void 
		{
			this.active = active;
			if (this.active) tween.restart();
			else tween.reverse();
		}
		
	}

}