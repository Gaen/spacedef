package game.nodes
{
    import ash.core.Node;

    import game.components.DisplayComponent;
    import game.components.PositionComponent;

    public class DisplayNode extends Node
    {
        public var position:PositionComponent;
        public var display:DisplayComponent;
    }
}
