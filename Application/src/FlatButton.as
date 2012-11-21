package  
{

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * FlatButton
	 * 
	 * @author Charlie Chao
	 */
	public class FlatButton extends Sprite 
	{
		// attributes
		public var label:TextField;
		public var icon:Bitmap;
		public var buttonWidth:int;
		public var buttonHeight:int;
		public var bgColor:uint;
		public var bgColorDown:uint;
		
		public function FlatButton(labelText:String, x:int, y:int, width:int, height:int, iconData:BitmapData): void
		{
			this.x = x;
			this.y = y;
			buttonWidth = width;
			buttonHeight = height;
			bgColor = CommonStyle.BUTTON_COLOR_BG;
			bgColorDown = CommonStyle.BUTTON_COLOR_BG;
				
			// setup icon
			icon = new Bitmap(iconData);
			addChild(icon);
			
			// setup label if exists
			if (labelText != null && labelText != "") {
				label = new TextField();
				label.defaultTextFormat = CommonStyle.BUTTON_FORMAT_LABEL;
				label.autoSize = TextFieldAutoSize.CENTER;
				label.selectable = false;
				//label.embedFonts = true;
				label.text = labelText;
				addChild(label);
			}
			
			// add initial render event
			addEventListener(Event.ADDED_TO_STAGE, render);
			addEventListener(Event.ADDED_TO_STAGE, render);
		}
		
		// added to screen handler
		public function added(e:Event = null):void 
		{
			listen();
			render();
		}
		
		// draws button
		public function render(e:Event = null):void
		{
			// remove initial render event
			if (hasEventListener(Event.ADDED)) removeEventListener(Event.ADDED, render);
			
			// draw base
			graphics.clear();
			drawBackground();
			
			// determine spacing
			var horizontalSpace:int = (buttonWidth - icon.width) / 2;
			var verticalSpace:int = (buttonHeight - icon.height - ((label != null)?label.height:0)) / ((label != null)?3:2);
			
			// re-position elements
			icon.x = (horizontalSpace < 0)?0:horizontalSpace;
			icon.y = (verticalSpace < 0)?0:verticalSpace;
			if (label != null) {
				label.x = buttonWidth / 2 - label.width / 2;
				label.y = icon.y + icon.height + verticalSpace;
			}
		}
		
		// draw button background
		protected function drawBackground(down:Boolean = false):void 
		{
			graphics.beginFill((down)?bgColorDown:bgColor);
			graphics.drawRect(0, 0, buttonWidth, buttonHeight);
			graphics.endFill();
		}
		
		// button state handler
		protected function stateDown(e:MouseEvent = null):void { drawBackground(true); }
		protected function stateUp(e:MouseEvent = null):void { drawBackground(); }
		
		// attachs panel opening listener
		public function listen():void {
			addEventListener(MouseEvent.MOUSE_DOWN, stateDown);
			addEventListener(MouseEvent.MOUSE_UP, stateUp);
		}
		
		// detaches panel opening listener
		public function unlisten():void {
			if (hasEventListener(MouseEvent.MOUSE_DOWN)) removeEventListener(MouseEvent.MOUSE_DOWN, stateDown);
			if (hasEventListener(MouseEvent.MOUSE_UP)) removeEventListener(MouseEvent.MOUSE_UP, stateUp);
		}	
	}

}