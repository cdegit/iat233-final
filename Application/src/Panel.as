package  
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Sine;
	import fl.containers.ScrollPane;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	/**
	 * Panel
	 * Common side panel.
	 * @author Charlie Chao
	 */
	public class Panel extends Sprite
	{
		// constants
		
		// attributes
		public var panelWidth:int;
		public var category:int;					// side button category
		protected var contentPane:ScrollPane;		// buttons scrollable panel
		protected var spriteSheet:Spritesheet;		// sprite sheet reference
		
		//components
		protected var title:TextField;
		protected var icon:Bitmap;
		protected var backButton:LinkedPanelButton;
		protected var closeButton:LinkedPanelButton;
		
		// animation
		protected var tweenIn:TweenLite;			// fade/slide in animaton
		protected var tweenOut:TweenLite;			// fade/slide out animation
		
		public function Panel(width:int, panelCategory:int, sprites:Spritesheet, iconName:String) 
		{
			panelWidth = width;
			x = -panelWidth;			// sets initial panel location off-screen
			alpha = 0;					// sets initial panel opacity to zero
			category = panelCategory;
			spriteSheet = sprites;
			
			// setup animation
			tweenIn = new TweenLite(this, 0.35, { x: 0, alpha: 1 } );
			tweenIn.paused = true;
			tweenOut = new TweenLite(this, 0.35, { alpha: 0, onComplete: dispose } );	
			tweenOut.paused = true;
			
			// setup internal elements
			contentPane = new ScrollPane();
			contentPane.horizontalScrollPolicy = "off";
			contentPane.verticalScrollPolicy = "off";
			
			// setup back button
			backButton = new LinkedPanelButton("", 0, 0, CommonStyle.PANEL_BUTTON_SIZE, CommonStyle.PANEL_BUTTON_SIZE, spriteSheet.getSprite("placeholder"), null);
			closeButton = new LinkedPanelButton("", 0, 0, CommonStyle.PANEL_BUTTON_SIZE, CommonStyle.PANEL_BUTTON_SIZE, spriteSheet.getSprite("placeholder"), null);
			
			// setup icon
			icon = new Bitmap(spriteSheet.getSprite(iconName));
			icon.x = CommonStyle.PANEL_PADDING;
			icon.y = CommonStyle.PANEL_TITLE_OFFSET + (CommonStyle.PANEL_TITLE_HEIGHT - icon.height) / 2;
			addChild(icon);
			
			// setup title text
			title = new TextField();
			title.x = CommonStyle.PANEL_PADDING * 2 + icon.width;
			title.y = CommonStyle.PANEL_TITLE_OFFSET;
			title.defaultTextFormat = CommonStyle.PANEL_FORMAT_TITLE;
			//title.embedFonts = true;
			title.autoSize = TextFieldAutoSize.LEFT;
			title.selectable = false;
			title.text = "Panel";
			
			
			//addChild(contentPane);
			addChild(icon);
			addChild(title);
			addChild(backButton);
			addChild(closeButton);
			
			// add initial render event
			addEventListener(Event.ADDED_TO_STAGE, added);
		}
		
		// added to screen handler
		public function added(e:Event = null):void 
		{
			// TODO: add button listeners
			fadeIn();
			render();
		}
		
		// renders panel
		public function render():void 
		{
			// remove initial render event
			if (hasEventListener(Event.ADDED)) removeEventListener(Event.ADDED, render);
			
			// draw background
			graphics.clear();
			graphics.beginFill(CommonStyle.PANEL_COLOR_BG);
			graphics.drawRect(0, 0, panelWidth, stage.stageHeight);
			graphics.endFill();
			
			// draw title bar
			graphics.beginFill(CommonStyle.PANEL_COLOR_TITLE_BAR);
			graphics.drawRect(0, CommonStyle.PANEL_TITLE_OFFSET, panelWidth, CommonStyle.PANEL_TITLE_HEIGHT);
			graphics.endFill();
			
			// update internal elements
			contentPane.width = panelWidth;
			contentPane.height = stage.stageHeight;
			
			closeButton.x = panelWidth - CommonStyle.PANEL_BUTTON_SIZE;
		}
		
		// fades in panel
		public function fadeIn():void 
		{
			tweenOut.pause();
			tweenIn.restart();
		}
		
		// fades out panel
		public function fadeOut():void
		{
			tweenIn.pause();
			tweenOut.restart();
		}
		
		// set previous panel
		public function set previousPanel(panel:Panel):void {
			backButton.linkedPanel = panel;
		}
		
		// get previous panel
		public function get previousPanel():Panel {
			return backButton.linkedPanel;
		}
		
		// overridable function for initializing buttons, which requires the panel list to be filled in Main to be called
		public function constructButtons(panels:Vector.<Panel>):void { }
		
		// removes the panel from screen and removes all the listeners
		private function dispose():void 
		{
			if (parent != null)	parent.removeChild(this);
		}
		
	}

}