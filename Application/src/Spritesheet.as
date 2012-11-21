package  
{
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * Spritesheet
	 * @author Charlie Chao
	 */
	public class Spritesheet extends EventDispatcher
	{
		
		// attributes
		private var jsonLoader:URLLoader;
		private var jsonData:Object;
		private var imageLoader:Loader;
		private var source:String;
		private var sprites:Vector.<SpriteData>;
		
		// constructor
		public function Spritesheet(source:String):void
		{
			this.source = source;
			jsonLoader = new URLLoader();
			jsonLoader.addEventListener(Event.COMPLETE, jsonLoaded);
			jsonLoader.load(new URLRequest(source));
		}
		
		// loads json data
		public function jsonLoaded(e:Event):void 
		{
			// get json data
			var data:Object = JSON.parse(String(URLLoader(jsonLoader).data));
			jsonData = data.frames;			
			
			// close json loader
			jsonLoader.close();
			jsonLoader = null;
			
			// start image loader
			imageLoader = new Loader();
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaded);
			imageLoader.load(new URLRequest(source.replace(".json", ".png")));
		}
		
		// loads image data and fill in 
		public function imageLoaded(e:Event):void 
		{
			// get image data
			var data:BitmapData = Bitmap(LoaderInfo(e.target).content).bitmapData;
			
			// extract sprites
			sprites = new Vector.<SpriteData>;
			var spriteName:String;
			var bitmap:BitmapData;
			for each (var o:Object in jsonData) {
				spriteName = String(o.filename).substr(0, -4);
				bitmap = new BitmapData(o.frame.w, o.frame.h);
				bitmap.copyPixels(data, new Rectangle(o.frame.x, o.frame.y, o.frame.w, o.frame.h), new Point(0, 0));
				sprites.push(new SpriteData(spriteName, bitmap));
			}
			
			// close image loader
			jsonData = null;
			imageLoader = null;
			
			// alert app that the spritesheet is ready
			dispatchEvent(new StateEvent(StateEvent.READY));
		}
		
		// gets sprite bitmap by name
		public function getSprite(spriteName:String):BitmapData
		{
			for (var i:int = 0; i < sprites.length; i++) {
				if (sprites[i].name == spriteName) return sprites[i].data;
			}
			return null;
		}
		
	}

}