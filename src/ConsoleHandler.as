package
{
    import com.junkbyte.console.Cc;

    import errors.NullParameterError;

    import flash.display.Stage;
    import flash.events.KeyboardEvent;

    /**
     * Класс, отвечающий за инициализацию консоли и за то, что она показывается/скрывается по нажатию клавиши.
     *
     * Внутренний биндинг консоли устроен таким образом, чтобы не срабатывать, когда какое-либо текстовое поле
     * находится в фокусе. Т.е. чтобы закрыть консоль, нужно сначала снять фокус с ее поля ввода, что несколько
     * напряжно делать каждый раз. Поэтому показ/скрытие консоли биндится напрямую.
     */
    public class ConsoleHandler
    {
        private static var _keyCode:uint;

        /**
         * Инициализация консоли.
         *
         * @param stage
         * @param keyCode клавиша, на которую биндится консоль
         */
        public static function init(stage:Stage, keyCode:uint = 192):void
        {
            if(!stage) throw new NullParameterError();

            _keyCode = keyCode;

            Cc.config.commandLineAllowed = true;

            Cc.config.style.traceFontSize = 10;
            Cc.config.style.backgroundAlpha = .5;

            Cc.startOnStage(stage);

            Cc.visible = false;

            Cc.width = stage.stageWidth;
            Cc.height = 300;

            Cc.commandLine = true;

            stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false, int.MAX_VALUE);
        }

        /**
         * Обработчик нажатия клавиши. Показывает/скрывает консоль.
         *
         * @param e
         */
        private static function onKeyDown(e:KeyboardEvent):void
        {
            if(e.keyCode != _keyCode) return;

            Cc.visible = !Cc.visible;
        }
    }
}
