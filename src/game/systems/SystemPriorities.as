package game.systems
{
    /**
     * Приоритеты систем.
     * Чем меньше значение, тем раньше отрабатывает система.
     */
    public class SystemPriorities
    {
        /**
         * Просчет движения игровых объектов
         */
        public static const MOVE:uint = 0;

        /**
         * Выполнить после обработки пользовательского ввода.
         */
        public static const INPUT_PROCESSED:uint = 1;

        /**
         * Отрисовка игровых объектов
         */
        public static const RENDER_OBJECTS:uint = 2;

        /**
         * Отрисовка отладочных хелперов
         */
        public static const RENDER_DEBUG:uint = 3;
    }
}
