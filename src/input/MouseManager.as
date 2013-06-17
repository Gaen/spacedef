package input
{
    import errors.NullParameterError;

    import flash.display.Stage;
    import flash.errors.IllegalOperationError;
    import flash.events.MouseEvent;

    /**
     * Менеджер мышиных событий.
     *
     * Отслеживает нажатие, перемещение, отпускание и клики.
     * Складывает событие каждого типа в соответствующую очередь.
     *
     * Системы, обрабатывающие мышиные события, должны вызывать метод dispatch(), передавая
     * туда экземпляр MouseListener, в котором заданы обработчики для нужных типов событий.
     *
     * В в конце каждой итерации игрового цикла необходимо вызывать clear() для удаления
     * неиспользованных событий.
     *
     * Перед использованием класса его необходимо проинициализировать методом init().
     *
     * Предпосылки к такой реализации см. в обсуждении https://github.com/richardlord/Ash/issues/25
     */
    public class MouseManager
    {
        private static var _stage:Stage;

        private static var _events:Vector.<MouseEvent>;

        //---------------------------------------------------------------------
        //
        //  Public methods
        //
        //---------------------------------------------------------------------

        /**
         * Инициализация.
         *
         * @param stage
         */
        public static function init(stage:Stage):void
        {
            if(!stage) throw new NullParameterError("Параметр stage не должен быть null");

            _stage = stage;
        }

        /**
         * Начать слушать события.
         */
        public static function startListening():void
        {
            ensureInited();

            try
            {
                _stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseEvent);
                _stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseEvent);
                _stage.addEventListener(MouseEvent.MOUSE_UP,   onMouseEvent);
                _stage.addEventListener(MouseEvent.CLICK,      onMouseEvent);
            }
            finally{}
        }

        /**
         * Перестать слушать события.
         */
        public static function stopListening():void
        {
            ensureInited();

            try
            {
                _stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseEvent);
                _stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseEvent);
                _stage.removeEventListener(MouseEvent.MOUSE_UP,   onMouseEvent);
                _stage.removeEventListener(MouseEvent.CLICK,      onMouseEvent);
            }
            finally{}
        }

        /**
         * Отдать события на обработку.
         *
         * Перебирает накопленные события в том порядке, в каком они возникли, и для каждого события
         * вызывает соответствующий обработчик из объекта listener, передавая ему объект события
         * в качестве аргумента.
         *
         * Если обработчик для какого-то типа событий не задан, события этого типа пропускаются.
         *
         * @param listener
         */
        public static function dispatch(listener:MouseListener):void
        {
            ensureInited();

            for each(var e:MouseEvent in _events)
            {
                switch(e.type)
                {
                    case MouseEvent.MOUSE_DOWN:
                        listener.onMouseDown && listener.onMouseDown(e);
                        break;

                    case MouseEvent.MOUSE_MOVE:
                        listener.onMouseUp   && listener.onMouseUp(e);
                        break;

                    case MouseEvent.MOUSE_UP:
                        listener.onMouseMove && listener.onMouseMove(e);
                        break;

                    case MouseEvent.CLICK:
                        listener.onClick     && listener.onClick(e);
                        break;
                }
            }
        }

        /**
         * Удалить накопленные события.
         */
        public static function clear():void
        {
            ensureInited();

            _events = null;
        }

        //---------------------------------------------------------------------
        //
        //  Private methods
        //
        //---------------------------------------------------------------------

        private static function onMouseEvent(e:MouseEvent):void
        {
            _events ||= new Vector.<MouseEvent>();

            _events.push(e);
        }

        private static function ensureInited():void
        {
            if(!_stage) throw new IllegalOperationError("MouseManager не был инициализирован!");
        }
    }
}
