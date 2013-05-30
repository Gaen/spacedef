package
{
    import com.junkbyte.console.Cc;

    import flash.display.Sprite;
    import flash.events.Event;

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
        }
    }
}
