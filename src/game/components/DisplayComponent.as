package game.components
{
    import com.genome2d.core.GNode;

    public class DisplayComponent
    {
        private var _view:GNode;

        public function DisplayComponent(view:GNode)
        {
            _view = view;
        }

        public function get view():GNode
        {
            return _view;
        }
    }
}
