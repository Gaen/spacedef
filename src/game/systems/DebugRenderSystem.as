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
        private var _engine:Engine;

        private var _displayNodes:NodeList;

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
            _displayNodes.nodeAdded.remove(addBox);
            _displayNodes.nodeRemoved.remove(removeBox);

            for(var node:DisplayNode = _displayNodes.head; node; node = node.next)
            {
                removeBox(node);
            }

            _displayNodes = null;

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
         * Включает рамку у объекта
         *
         * @param node
         */
        private function addBox(node:DisplayNode):void
        {
            node.display.showBox(node.size.width, node.size.height);
        }

        /**
         * Выключает рамку у объекта
         *
         * @param node
         */
        private function removeBox(node:DisplayNode):void
        {
            node.display.hideBox();
        }
    }
}
