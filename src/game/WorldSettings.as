package game
{
    import flash.geom.Rectangle;

    /**
     * Настройки игрового мира.
     */
    public class WorldSettings
    {
        /**
         * Ширина игрового мира.
         */
        public static const WIDTH:Number = 600;

        /**
         * Высота игрового мира.
         */
        public static const HEIGHT:Number = 600;

        /**
         * Границы игрового мира.
         * Нулевые координаты находятся внизу посередине.
         */
        public static const bounds:Rectangle = new Rectangle(-WIDTH / 2, 0, WIDTH, HEIGHT);
    }
}
