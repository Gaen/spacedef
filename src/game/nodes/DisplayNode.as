package game.nodes
{
    import ash.core.Node;

    import game.components.DisplayComponent;
    import game.components.PositionComponent;
    import game.components.SizeComponent;

    public class DisplayNode extends Node
    {
        public var position:PositionComponent;
        public var size:SizeComponent;
        public var display:DisplayComponent;
    }
}
