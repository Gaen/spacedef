package game.nodes
{
    import ash.core.Node;

    import game.components.PositionComponent;
    import game.components.SizeComponent;

    public class CollisionNode extends Node
    {
        public var position:PositionComponent;
        public var size:SizeComponent;
    }
}
