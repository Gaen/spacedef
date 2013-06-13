package game.systems
{
    import ash.core.Engine;
    import ash.core.NodeList;
    import ash.core.System;

    import flash.events.MouseEvent;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    import game.nodes.CollisionNode;

    import input.MouseManager;

    /**
     * Система, удаляющая игровые объекты по клику.
     */
    public class ClickToRemoveSystem extends System
    {
        private var _engine:Engine;

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
            var event:MouseEvent;

            // для каждого события нажатия мыши
            while(event = MouseManager.getNext(MouseEvent.MOUSE_DOWN))
            {
                // координаты нажатия
                var mouseX:Number = event.stageX;
                var mouseY:Number = event.stageY;

                // для каждого игрового объекта
                for(var collisionNodes:NodeList = _engine.getNodeList(CollisionNode),
                        collisionNode:CollisionNode = collisionNodes.head;
                    collisionNode;
                    collisionNode = collisionNode.next)
                {
                    var x:Number = collisionNode.position.x;
                    var y:Number = collisionNode.position.y;

                    var width:Number = collisionNode.size.width;
                    var height:Number = collisionNode.size.height;

                    var rect:Rectangle = new Rectangle(x - width / 2,
                                                       y - height / 2,
                                                       width,
                                                       height);

                    // если попали по объекту
                    if(rect.containsPoint(new Point(mouseX, mouseY)))
                    {
                        // удаляем объект
                        _engine.removeEntity(collisionNode.entity);

                        // прекращаем обрабатывать текущее нажатие
                        break;
                    }
                }


            }
        }
    }
}
