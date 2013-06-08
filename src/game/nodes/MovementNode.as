package game.nodes
{
    import ash.core.Node;

    import game.components.MotionComponent;
    import game.components.PositionComponent;

    public class MovementNode extends Node
    {
        public var position:PositionComponent;
        public var motion:MotionComponent;
    }
}
