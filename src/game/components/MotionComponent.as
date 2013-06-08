package game.components
{
    public class MotionComponent
    {
        /**
         * Скорость по X
         */
        public var vX:Number;

        /**
         * Скорость по Y
         */
        public var vY:Number;

        /**
         * Скорость вращения
         */
        public var vAngle:Number;

        /**
         * Конструктор.
         *
         * @param vX        скорость по X
         * @param vY        скорость по Y
         * @param vAngle    скорость вращения
         */
        public function MotionComponent(vX:Number = 0, vY:Number = 0, vAngle:Number = 0)
        {
            this.vX = vX;
            this.vY = vY;
            this.vAngle = vAngle;
        }
    }
}
