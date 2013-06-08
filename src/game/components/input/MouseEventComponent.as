package game.components.input
{
    public class MouseEventComponent
    {
        private var _x:Number;
        private var _y:Number;

        /**
         * Компонент мышиного события. Хранит координаты.
         *
         * @param x
         * @param y
         */
        public function MouseEventComponent(x:Number, y:Number)
        {
            _x = x;
            _y = y;
        }

        public function get x():Number
        {
            return _x;
        }

        public function get y():Number
        {
            return _y;
        }
    }
}
