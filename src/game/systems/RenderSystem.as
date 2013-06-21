package game.systems
{
    import ash.core.Engine;
    import ash.core.NodeList;
    import ash.core.System;

    import com.genome2d.core.GNode;
    import com.genome2d.core.Genome2D;

    import game.components.BoxComponent;
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
            var g2d:Genome2D = Genome2D.getInstance();

            g2d.beginRender();

            for(var node:DisplayNode = _nodes.head; node; node = node.next)
            {
                var position:PositionComponent = node.position;
                var display:DisplayComponent = node.display;

                // обновляем анимацию
                display.update(time);

                // рисуем объект
                g2d.context.draw(display.getTexture(), position.x, position.y, 1, 1, position.rotation * Math.PI / 180);

                var box:BoxComponent = node.entity.get(BoxComponent);

                // если у объекта есть рамка - рисуем рамку
                if(box) g2d.context.draw(box.getTexture(), position.x, position.y, 1, 1, position.rotation * Math.PI / 180);
            }

            g2d.endRender();

        }
    }
}
