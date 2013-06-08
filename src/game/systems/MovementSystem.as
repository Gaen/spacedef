package game.systems
{
    import ash.tools.ListIteratingSystem;

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

            // Размеры игрового мира
            // TODO вынести в конфиг
            const WORLD_WIDTH:int = 600;
            const WORLD_HEIGHT:int = 600;

            // Не даем объектам улететь за пределы мира
            if(position.x < 0) position.x += WORLD_WIDTH;
            if(position.y < 0) position.y += WORLD_HEIGHT;
            if(position.x > WORLD_WIDTH) position.x -= WORLD_WIDTH;
            if(position.y > WORLD_HEIGHT) position.y -= WORLD_HEIGHT;
        }
    }
}
