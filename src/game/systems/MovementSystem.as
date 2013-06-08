package game.systems
{
    import ash.tools.ListIteratingSystem;

    import game.WorldSettings;

    import game.components.MotionComponent;
    import game.components.PositionComponent;

    import game.nodes.MovementNode;

    /**
     * Система движения объектов.
     */
    public class MovementSystem extends ListIteratingSystem
    {
        /**
         * Конструктор.
         */
        public function MovementSystem()
        {
            super(MovementNode, updateNode);
        }

        private function updateNode(node:MovementNode, time:Number)
        {
            var position:PositionComponent = node.position;
            var motion:MotionComponent = node.motion;

            // Обновляем координаты
            position.x += motion.vX * time;
            position.y += motion.vY * time;

            // Обновляем угол поворота
            position.rotation += motion.vAngle * time;

            // Не даем объектам улететь за пределы мира
            if(position.x < 0) position.x += WorldSettings.WIDTH;
            if(position.y < 0) position.y += WorldSettings.HEIGHT;
            if(position.x > WorldSettings.WIDTH) position.x -= WorldSettings.WIDTH;
            if(position.y > WorldSettings.HEIGHT) position.y -= WorldSettings.HEIGHT;
        }
    }
}
