package
{
    import com.junkbyte.console.Cc;

    import flash.display.DisplayObjectContainer;
    import flash.events.Event;

    import gui.MainMenu;

    public class Application
    {
        private var _root:DisplayObjectContainer;

        private var _mainMenu:MainMenu;

        public function Application(root:DisplayObjectContainer)
        {
            _root = root;

            _mainMenu = new MainMenu(root);

            _mainMenu.addEventListener(MainMenu.PLAY, onPlay);
        }

        private function onPlay(event:Event):void
        {
            _mainMenu.destroy();

            Cc.log("play");

            Cc.visible = true;
        }
    }
}
