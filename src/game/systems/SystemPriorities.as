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
         * Обработка пользовательского ввода
         */
        public static const PROCESS_INPUT:uint = 1;

        /**
         * После обработки пользовательского ввода
         */
        public static const INPUT_PROCESSED:uint = 2;

        /**
         * Отрисовка игровых объектов
         */
        public static const RENDER_OBJECTS:uint = 3;

        /**
         * Отрисовка отладочных хелперов
         */
        public static const RENDER_DEBUG:uint = 4;
    }
}
