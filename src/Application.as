package
{
    import flash.display.DisplayObjectContainer;
    import flash.events.Event;

    import gui.MainMenu;

    public class Application
    {
        private var _root:DisplayObjectContainer;

        private var _mainMenu:MainMenu;
        private var _game:Game;

        public function Application(root:DisplayObjectContainer)
        {
            _root = root;

            _mainMenu = new MainMenu(root);

            _mainMenu.addEventListener(MainMenu.PLAY, onPlay);
        }

        private function onPlay(event:Event):void
        {
            _mainMenu.destroy();

            _game = new Game(_root);
        }
    }
}
