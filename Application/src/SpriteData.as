package  
{
	
	import flash.display.BitmapData;
	
	/**
	 * SpriteData
	 * Stores sprite name and bitmap.
	 * @author Charlie Chao
	 */
	public class SpriteData 
	{
		public var name:String;
		public var data:BitmapData;
		
		public function SpriteData(spriteName:String, bitmap:BitmapData) 
		{
			this.name = spriteName;
			data = bitmap;
		}
		
	}

}