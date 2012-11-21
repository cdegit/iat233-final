package  
{
	/**
	 * ...
	 * @author Cassandra de Git
	 * Class: Just a utils class for parsing the text from the files 
	 * Recycled from an earlier project
	 */
	public class TextParser 
	{
		
		private var data:XML;
		
		public function TextParser(data:XML) 
		{
			this.data = data;
		}
		
		// Basically, each node, upon creation, will get its appropriate info from here
		public function getDesc(name:String):String 
		{
			var tempDesc:String = "";
			var i:int = 0;
			while (data.location[i] != undefined) {
				if (data.location[i].@name == name)
				{
					tempDesc = data.location[i].desc.text();
					break;
				}
				i++;
			}
			return tempDesc;
		}
		
		public function getImg(name:String):String
		{
			var tempImg:String = "";
			var i:int = 0;
			while (data.location[i] != undefined) {
				if (data.location[i].@name == name)
				{
					tempImg = data.location[i].img.text();
					break;
				}
				i++;
			}
			return tempImg;
		}
		
	}
}