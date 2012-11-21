package  
{
	import Edge;
    import Graph;
    import flash.geom.Vector3D;
    import IndexedPriorityQ;
	/**
	 * ...
	 * @author Eduardo Gonzalez
	 */
 
    public class Astar {
        private var graph:Graph
        private var SPT:Vector.<Edge>
        private var G_Cost:Vector.<Number>    //This vector will store the G cost of each node
        private var F_Cost:Vector.<Number>    //This vector will store the F cost of each node
        private var SF:Vector.<Edge>
        private var source:int;
        private var target:int;
 
        public function Astar(n_graph:Graph,src:int,tar:int)
        {
            graph=n_graph;
            source=src;
            target=tar;
            SPT= new Vector.<Edge>(graph.numNodes());
            G_Cost = new Vector.<Number>(graph.numNodes());
            F_Cost = new Vector.<Number>(graph.numNodes());
            SF = new Vector.<Edge>(graph.numNodes());
            search();
        }
        private function search():void
        {
            //The pq is now sorted depending on the F cost vector
            var pq:IndexedPriorityQ = new IndexedPriorityQ(F_Cost)
            pq.insert(source);
            while(!pq.isEmpty())
            {
                var NCN:int = pq.pop();
                SPT[NCN]=SF[NCN];
                if(SPT[NCN])
                {
                SPT[NCN].drawEdge(
                    graph.getNode(SPT[NCN].getFrom()).getPos(),
                    graph.getNode(SPT[NCN].getTo()).getPos(),
                    "visited"
                );
                }
                if(NCN==target)return;
                var edges:Array=graph.getEdges(NCN);
                for each(var edge:Edge in edges)
                {
                    //The H cost is obtained by the distance between the target node, and the arrival node of the edge being analyzed
                    var Hcost:Number = Vector3D.distance(
                        graph.getNode(edge.getTo()).getPos(),
                        graph.getNode(target).getPos())
                    var Gcost:Number = G_Cost[NCN] + edge.getCost();
                    var to:int=edge.getTo();
                    if(SF[edge.getTo()]==null)
                    {
                        F_Cost[edge.getTo()]=Gcost+Hcost;
                        G_Cost[edge.getTo()]=Gcost;
                        pq.insert(edge.getTo());
                        SF[edge.getTo()]=edge;
                    }
                    else if((Gcost<G_Cost[edge.getTo()])&&(SPT[edge.getTo()]==null))
                    {
                        F_Cost[edge.getTo()]=Gcost+Hcost;
                        G_Cost[edge.getTo()]=Gcost;
                        pq.reorderUp();
                        SF[edge.getTo()]=edge;
                    }
                }
            }
        }
        public function getPath():Array
        {
            var path:Array = new Array();
            if(target<0) return path;
            var nd:int = target;
            path.push(nd);
            while((nd!=source)&&(SPT[nd]!=null))
            {
				try {
                SPT[nd].drawEdge(
                    graph.getNode(SPT[nd].getFrom()).getPos(),
                    graph.getNode(SPT[nd].getTo()).getPos(),
                    "path"
                    );
                nd = SPT[nd].getFrom();
                path.push(nd);
				} 
				catch(e:Error) {
					trace(e);
				}
            }
            path=path.reverse();
            return path;
        }
    }
}