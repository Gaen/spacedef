package game.components
{
    import com.genome2d.textures.GTexture;
    import com.genome2d.textures.factories.GTextureFactory;

    import flash.display.BitmapData;

    public class BoxComponent
    {
        private var _texture:GTexture;

        /**
         * Визуальный компонент рамки.
         *
         * @param width  ширина рамки в пикселях
         * @param height высота рамки в пикселях
         */
        public function BoxComponent(width:uint, height:uint)
        {
            var textureId:String = "box_" + width + "x" + height;

            _texture = GTexture.getTextureById(textureId);

            if(!_texture)
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

                _texture = GTextureFactory.createFromBitmapData(textureId, bd);
            }
        }

        public function getTexture():GTexture
        {
            return _texture;
        }
    }
}
