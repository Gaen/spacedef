package game.components
{
    import com.genome2d.components.renderables.GSprite;
    import com.genome2d.core.GNode;
    import com.genome2d.core.GNodeFactory;
    import com.genome2d.textures.GTexture;
    import com.genome2d.textures.factories.GTextureFactory;

    import errors.NullParameterError;

    import flash.display.BitmapData;

    public class DisplayComponent
    {
        private var _root:GNode;

        private var _main:GNode;
        private var _box:GNode;

        public function DisplayComponent(texture:GTexture)
        {
            if(!texture) throw new NullParameterError("Параметр texture не должен быть null!");

            _root = GNodeFactory.createNode();

            _main = GNodeFactory.createNode();

            (_main.addComponent(GSprite) as GSprite).setTexture(texture);

            _root.addChild(_main);
        }

        //---------------------------------------------------------------------
        //
        //  Public getters/setters
        //
        //---------------------------------------------------------------------

        public function get node():GNode
        {
            return _root;
        }

        public function get x():Number
        {
            return _root.transform.x;
        }

        public function set x(value:Number):void
        {
            _root.transform.x = value;
        }

        public function get y():Number
        {
            return _root.transform.y;
        }

        public function set y(value:Number):void
        {
            _root.transform.y = value;
        }

        public function get rotation():Number
        {
            return _main.transform.rotation;
        }

        public function set rotation(value:Number):void
        {
            _main.transform.rotation = value;
        }

        //---------------------------------------------------------------------
        //
        //  Public methods
        //
        //---------------------------------------------------------------------

        /**
         * Показать рамку вокруг объекта.
         *
         * @param width  ширина рамки в пикселях
         * @param height высота рамки в пикселях
         */
        public function showBox(width:uint, height:uint):void
        {
            if(_box) return;

            _box = GNodeFactory.createNode();

            (_box.addComponent(GSprite) as GSprite).setTexture(getTexture(width, height));

            _main.addChild(_box);
        }

        public function hideBox():void
        {
            if(!_box) return;

            _main.removeChild(_box);

            _box = null;
        }

        //---------------------------------------------------------------------
        //
        //  Private methods
        //
        //---------------------------------------------------------------------

        /**
         * Возвращает текстуру рамки.
         *
         * @return
         */
        private function getTexture(width:uint, height:uint):GTexture
        {
            var textureId:String = "debug_box_" + width + "x" + height;

            var texture:GTexture = GTexture.getTextureById(textureId);

            if(!texture)
            {
                var bd:BitmapData = new BitmapData(width, height, true, 0x00000000);

                const color:uint = 0x66FFFFFF;

                var i:uint;

                bd.lock();

                // top
                for(i = 0; i < width; i++) bd.setPixel32(i, 0, color);

                // bottom
                for(i = 0; i < width; i++) bd.setPixel32(i, height - 1, color);

                // left
                for(i = 0; i < height; i++) bd.setPixel32(0, i, color);

                // right
                for(i = 0; i < height; i++) bd.setPixel32(width - 1, i, color);

                bd.unlock();

                texture = GTextureFactory.createFromBitmapData(textureId, bd);
            }

            return texture;
        }
    }
}
