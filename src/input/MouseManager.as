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
     * Системы, обрабатывающие мышиные события, должны получать их через метод getNext(),
     * а в конце каждой итерации игрового цикла необходимо вызывать clear() для удаления
     * неиспользованных событий.
     *
     * Перед использованием класса его необходимо проинициализировать методом init().
     *
     * Предпосылки к такой реализации см. в обсуждении https://github.com/richardlord/Ash/issues/25
     */
    public class MouseManager
    {
        private static var _stage:Stage;

        private static var _downEvents :Vector.<MouseEvent>;
        private static var _moveEvents :Vector.<MouseEvent>;
        private static var _upEvents   :Vector.<MouseEvent>;
        private static var _clickEvents:Vector.<MouseEvent>;

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
                _stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
                _stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
                _stage.addEventListener(MouseEvent.MOUSE_UP,   onMouseUp);
                _stage.addEventListener(MouseEvent.CLICK,      onClick);
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
                _stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
                _stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
                _stage.removeEventListener(MouseEvent.MOUSE_UP,   onMouseUp);
                _stage.removeEventListener(MouseEvent.CLICK,      onClick);
            }
            finally{}
        }

        /**
         * Достать следующее событие в очереди. Событие при этом удаляется из очереди.
         *
         * @param type  <p>Тип события. Возможные значения:</p>
         *              <ul>
         *                  <li>MouseEvent.MOUSE_DOWN</li>
         *                  <li>MouseEvent.MOUSE_MOVE</li>
         *                  <li>MouseEvent.MOUSE_UP</li>
         *                  <li>MouseEvent.CLICK</li>
         *              </ul>
         *
         * @return событие заданного типа либо null, если очередь событий данного типа пуста.
         */
        public static function getNext(type:String):MouseEvent
        {
            ensureInited();

            var source:Vector.<MouseEvent>;

            switch(type)
            {
                case MouseEvent.MOUSE_DOWN:
                    source = _downEvents;
                    break;

                case MouseEvent.MOUSE_MOVE:
                    source = _moveEvents;
                    break;

                case MouseEvent.MOUSE_UP:
                    source = _upEvents;
                    break;

                case MouseEvent.CLICK:
                    source = _clickEvents;
                    break;

                default:
                    throw new ArgumentError("Неверный тип события! См. документацию к методу.");
            }

            if(!source || !source.length) return null;

            return source.shift() as MouseEvent;
        }

        /**
         * Удалить накопленные события.
         */
        public static function clear():void
        {
            ensureInited();

            _downEvents  = null;
            _moveEvents  = null;
            _upEvents    = null;
            _clickEvents = null;
        }

        //---------------------------------------------------------------------
        //
        //  Private methods
        //
        //---------------------------------------------------------------------

        private static function onMouseDown(e:MouseEvent):void
        {
            if(!_downEvents) _downEvents = new Vector.<MouseEvent>();

            _downEvents.push(e);
        }

        private static function onMouseMove(e:MouseEvent):void
        {
            if(!_moveEvents) _moveEvents = new Vector.<MouseEvent>();

            _moveEvents.push(e);
        }

        private static function onMouseUp(e:MouseEvent):void
        {
            if(!_upEvents) _upEvents = new Vector.<MouseEvent>();

            _upEvents.push(e);
        }

        private static function onClick(e:MouseEvent):void
        {
            if(!_clickEvents)  _clickEvents = new Vector.<MouseEvent>();

            _clickEvents.push(e);
        }

        private static function ensureInited():void
        {
            if(!_stage) throw new IllegalOperationError("MouseManager не был инициализирован!");
        }
    }
}
