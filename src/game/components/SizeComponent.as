package game.components
{
    public class SizeComponent
    {
        private var _width:Number;
        private var _height:Number;

        /**
         * Компонент размера.
         *
         * @param width  ширина
         * @param height высота
         */
        public function SizeComponent(width:Number = 1, height:Number = 1):void
        {
            this.width = width;
            this.height = height;
        }

        /**
         * Ширина объекта.
         */
        public function get width():Number
        {
            return _width;
        }

        /**
         * @private
         */
        public function set width(value:Number):void
        {
            if(value == 0) throw new ArgumentError("Ширина не может быть нулевой!");
            if(value < 0) throw new ArgumentError("Ширина не может быть отрицательной!");

            _width = value;
        }

        /**
         * Высота объекта.
         */
        public function get height():Number
        {
            return _height;
        }

        /**
         * @private
         */
        public function set height(value:Number):void
        {
            if(value == 0) throw new ArgumentError("Высота не может быть нулевой!");
            if(value < 0) throw new ArgumentError("Высота не может быть отрицательной!");

            _height = value;
        }
    }
}
