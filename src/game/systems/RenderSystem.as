package game.systems
{
    import ash.core.Engine;
    import ash.core.NodeList;
    import ash.core.System;

    import com.genome2d.components.GTransform;
    import com.genome2d.core.GNode;
    import com.genome2d.core.Genome2D;

    import game.components.DisplayComponent;
    import game.components.PositionComponent;

    import game.nodes.DisplayNode;

    /**
     * Система, отвечающая за рендеринг.
     */
    public class RenderSystem extends System
    {
        private var _container:GNode;

        private var _engine:Engine;

        private var _nodes:NodeList;

        /**
         * Конструктор.
         */
        public function RenderSystem(container:GNode)
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

            _nodes = engine.getNodeList(DisplayNode);

            for(var node:DisplayNode = _nodes.head; node; node = node.next)
            {
                addToDisplay(node);
            }

            _nodes.nodeAdded.add(addToDisplay);
            _nodes.nodeRemoved.add(removeFromDisplay);

            // отключаем автоматический рендеринг
            Genome2D.getInstance().autoUpdate = false;
        }

        /**
         * @inheritDoc
         */
        override public function removeFromEngine(engine:Engine):void
        {
            _engine = null;

            // включаем автоматический рендеринг обратно
            Genome2D.getInstance().autoUpdate = true;
        }

        /**
         * @inheritDoc
         */
        override public function update(time:Number):void
        {
            for(var node:DisplayNode = _nodes.head; node; node = node.next)
            {
                var position:PositionComponent = node.position;
                var display:DisplayComponent = node.display;

                display.x = position.x;
                display.y = position.y;
                display.rotation = position.rotation * Math.PI / 180;
            }

            var g2d:Genome2D = Genome2D.getInstance();

            // отрисовываем сцену
            g2d.update();
            g2d.beginRender();
            g2d.render();
            g2d.endRender();

        }

        //---------------------------------------------------------------------
        //
        //  Private methods
        //
        //---------------------------------------------------------------------

        private function addToDisplay(node:DisplayNode):void
        {
            _container.addChild(node.display.node);
        }

        private function removeFromDisplay(node:DisplayNode):void
        {
            _container.removeChild(node.display.node);
        }
    }
}
