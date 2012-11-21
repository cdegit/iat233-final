package  
{
	import flash.display.Sprite;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Eduardo Gonzalez
	 */
	public class Edge extends Sprite
    {
        private var from:int;     //The index of the node from which this edge departs
        private var to:int;       //The index of the node from which this edge arrives
        private var cost:Number;  //The cost of crossing through this node (i.e. the distance)
 
        public function Edge(n_From:int,n_To:int,n_Cost:Number=1.0)
        {
            from=n_From;
            to=n_To;
            cost=n_Cost;
            this.z=1;
        }
 
        public function getFrom():int
        {
            return from;
        }
 
        public function setFrom(n_From:int):void
        {
            from=n_From;
        }
 
        public function getTo():int
        {
            return to;
        }
 
        public function setTo(n_To:int):void
        {
            to=n_To;
        }
 
        public function setCost(n_Cost:Number):void
        {
            cost=n_Cost;
        }
 
        public function getCost():Number
        {
            return cost;
        }
        /*
          Since the edge is just a line that connects the nodes,
          we will use this method to draw the edge, the style refers to how we will
          want the edge to be
        */
        public function drawEdge(fromPos:Vector3D,toPos:Vector3D,style:String="normal"):void
        {
            switch(style)
            {
                case "normal":
                //If it is normal, create a gray line
                    this.graphics.clear();
                    this.graphics.lineStyle(1, 0x999999, 1);
                    this.graphics.moveTo(fromPos.x,fromPos.y);
                    this.graphics.lineTo(toPos.x,toPos.y);
                    break;
                case "path":
                //If it is a line from the path, create a black line
                    this.graphics.clear();
                    this.graphics.lineStyle(2, 0x000000,1);
                    this.graphics.moveTo(fromPos.x,fromPos.y);
                    this.graphics.lineTo(toPos.x,toPos.y);
                    break;
				/*
                case "visited":
                //If it is a line used by the algorithm, create a red line
                    this.graphics.clear();
                    this.graphics.lineStyle(1, 0xFF0000,1);
                    this.graphics.moveTo(fromPos.x,fromPos.y);
                    this.graphics.lineTo(toPos.x,toPos.y);
                    break;
				*/
            }
        }
    }
}
