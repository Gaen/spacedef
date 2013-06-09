package game.systems
{
    import ash.core.Engine;
    import ash.core.NodeList;
    import ash.core.System;

    import com.genome2d.components.renderables.GSprite;
    import com.genome2d.core.GNode;
    import com.genome2d.core.GNodeFactory;
    import com.genome2d.textures.GTexture;
    import com.genome2d.textures.factories.GTextureFactory;

    import flash.display.BitmapData;

    import game.nodes.DisplayNode;

    public class DebugRenderSystem extends System
    {
        private var _container:GNode;

        private var _engine:Engine;

        private var _displayNodes:NodeList;

        /**
         * Конструктор.
         */
        public function DebugRenderSystem(container:GNode)
        {
            _container = container;
        }

        //---------------------------------------------------------------------
        //
        //  Overrides
        //
        //---------------------------------------------------------------------

        /**
         * @inheritDoc
         */
        override public function addToEngine(engine:Engine):void
        {
            _engine = engine;

            _displayNodes = engine.getNodeList(DisplayNode);

            for(var node:DisplayNode = _displayNodes.head; node; node = node.next)
            {
                addBox(node);
            }

            _displayNodes.nodeAdded.add(addBox);
            _displayNodes.nodeRemoved.add(removeBox);
        }

        /**
         * @inheritDoc
         */
        override public function removeFromEngine(engine:Engine):void
        {
            _engine = null;
        }

        /**
         * @inheritDoc
         */
        override public function update(time:Number):void
        {
            // nothing here yet
        }

        //---------------------------------------------------------------------
        //
        //  Private methods
        //
        //---------------------------------------------------------------------

        /**
         * Добавляет к ноде объекта дочернюю ноду с текстурой рамки.
         *
         * @param node
         */
        private function addBox(node:DisplayNode):void
        {
            var gnode:GNode = node.display.view;

            var boxNode:GNode = GNodeFactory.createNode("debug_box");

            var boxSprite:GSprite = boxNode.addComponent(GSprite) as GSprite;

            var boxTexture:GTexture = getTexture(node.size.width, node.size.height);

            boxSprite.setTexture(boxTexture);

            gnode.addChild(boxNode);
        }

        /**
         * Удаляет из ноды объекта дочернюю ноду с текстурой рамки.
         * @param node
         */
        private function removeBox(node:DisplayNode):void
        {
            var gnode:GNode = node.display.view;

            for(var childNode:GNode = gnode.firstChild; childNode; childNode = childNode.next)
            {
                if(childNode.name == "debug_box")
                {
                    gnode.removeChild(childNode);

                    break;
                }
            }
        }

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
