package
{
    import com.genome2d.core.GConfig;
    import com.genome2d.core.Genome2D;

    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Rectangle;

    public class Main extends Sprite
    {
        private var _app:Application;

        /**
         * Конструктор.
         */
        public function Main()
        {
            if(stage)
            {
                init();

                return;
            }

            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        /**
         * Обработчик добавления на сцену.
         *
         * @param e
         */
        private function onAddedToStage(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

            init();
        }

        /**
         * Инициализация приложения.
         */
        private function init():void
        {
            ConsoleHandler.init(stage, Settings.CONSOLE_KEY);

            initGraphics(onGraphicsInited);
        }

        /**
         * Инициализация Genome2D
         */
        private function initGraphics(callback:Function):void
        {
            var g2d:Genome2D = Genome2D.getInstance();

            var config:GConfig = new GConfig(new Rectangle(0, 0, Settings.WIDTH, Settings.HEIGHT));

            config.backgroundColor = 0x333333;

            config.enableStats = true;

            g2d.onInitialized.addOnce(callback);

            g2d.init(stage, config);
        }

        /**
         * Обработчик завершения инициализации Genome2D
         */
        private function onGraphicsInited():void
        {
            _app = new Application(root as DisplayObjectContainer);
        }
    }
}
