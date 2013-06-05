package gui
{
    import assets.gui_MainMenu;

    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.MouseEvent;

    public class MainMenu extends EventDispatcher
    {
        public static const PLAY:String = "play";

        private var _container:DisplayObjectContainer;

        private var _asset:gui_MainMenu;

        /**
         * Конструктор.
         */
        public function MainMenu(container:DisplayObjectContainer)
        {
            _container = container;

            _asset = new gui_MainMenu();

            _asset.x = Math.round((Settings.WIDTH - _asset.width) / 2);
            _asset.y = Math.round((Settings.HEIGHT - _asset.height) / 2);

            _container.addChild(_asset);

            _asset.btnPlay.addEventListener(MouseEvent.CLICK, btnPlayClick);
        }

        public function destroy():void
        {
            _asset.btnPlay.removeEventListener(MouseEvent.CLICK, btnPlayClick);

            _container.removeChild(_asset);

            _asset = null;
        }

        /**
         * Обработчик клика кнопки Play
         * @param event
         */
        private function btnPlayClick(event:MouseEvent):void
        {
            dispatchEvent(new Event(PLAY));
        }
    }
}
