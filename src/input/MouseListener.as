package input
{
    /**
     * Структура для хранения обработчиков мышиных событий.
     *
     * Обработчик должен принимать экземпляр MouseEvent в качестве аргумента.
     */
    public class MouseListener
    {
        public var onMouseDown:Function;
        public var onMouseMove:Function;
        public var onMouseUp:Function;
        public var onClick:Function;
    }
}
