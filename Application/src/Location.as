package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.geom.Vector3D;
	import flash.events.TouchEvent;
	import flash.events.MouseEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Cassandra de Git and Charlie Chao
	 */
	public class Location extends Node 
	{
		private var facility:String;
		
		private var facilityBitmapData:BitmapData;
		private var facilityBitmap:Bitmap;
		
		private var desc:String;
		private var img:String;
		
		// Should also have an associated image, plus the info for the pop up?
		
		public function Location(idx:int, n_Pos:Vector3D, name:String, desc:String, img:String) 
		{
			super(idx, n_Pos);
			//this.addEventListener(TouchEvent.TOUCH_TAP, clickHandler);
			this.addEventListener(MouseEvent.CLICK, clickHandler);
			
			this.facility = name;
			this.desc = desc;
			this.img = img;
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, imgLoadComplete);
			loader.load(new URLRequest(img));
			
		}
		
		public function imgLoadComplete(event:Event):void 
		{
			//facilityBitmapData = new BitmapData(48, 38, false);
			facilityBitmapData = event.target.content.bitmapData;
			facilityBitmap = new Bitmap(facilityBitmapData);
			this.addChild(facilityBitmap);
		}
		
		override public function render():void
		{
			graphics.beginFill(fillColor);
			graphics.drawCircle(0, 0, 10);
			graphics.endFill();
		}
		
		public function getFacility():String
		{
			return facility;
		}
		
		private function clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new NodeClicked(NodeClicked.NODE_CLICKED, this, true));
		}
	}

}