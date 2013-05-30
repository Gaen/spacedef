package
{
    import com.genome2d.core.GConfig;
    import com.genome2d.core.Genome2D;

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Rectangle;

    public class Main extends Sprite
    {
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
            // биндим консоль на тильду
            ConsoleHandler.init(stage, 192);

            initGraphics();
        }

        /**
         * Инициализация Genome2D
         */
        private function initGraphics():void
        {
            var g2d:Genome2D = Genome2D.getInstance();

            var config:GConfig = new GConfig(new Rectangle(0,0,600, 600));

            config.enableStats = true;

            g2d.init(stage, config);
        }
    }
}
