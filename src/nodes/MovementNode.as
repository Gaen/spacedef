package nodes
{
    import ash.core.Node;

    import components.MotionComponent;
    import components.PositionComponent;

    public class MovementNode extends Node
    {
        public var position:PositionComponent;
        public var motion:MotionComponent;
    }
}
