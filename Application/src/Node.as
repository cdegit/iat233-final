package  
{
	import flash.display.Sprite;
	import flash.geom.Vector3D;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	/**
	 * ...
	 * @author Eduardo Gonzalez
	 */
	public class Node extends Sprite
	{
		private var pos:Vector3D;
		private var index:int;
		public var fillColor:Number = 0x000000;
		public var selected:Boolean = false;
		
		public function Node(idx:int,n_Pos:Vector3D)
		{
			index=idx;
			pos=n_Pos;
			this.x=n_Pos.x;
			this.y = n_Pos.y;
		}
		
		public function render():void
		{

		}
 
		public function getIndex():int
		{
			return index;
		}
		public function setPos(n_Pos:Vector3D):void
		{
			pos=n_Pos;
		}
 
		public function getPos():Vector3D
		{
			return pos;
		}
		
	}

}