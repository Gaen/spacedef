package game.systems
{
    import ash.core.Engine;
    import ash.core.Entity;
    import ash.core.NodeList;
    import ash.core.System;

    import flash.display.Stage;
    import flash.events.MouseEvent;

    import game.components.input.ClickComponent;
    import game.components.input.MouseDownComponent;
    import game.components.input.MouseMoveComponent;
    import game.components.input.MouseUpComponent;
    import game.nodes.DisplayNode;
    import game.nodes.input.*;

    /**
     * Система отслеживания мышиных событий.
     *
     * Отслеживает события вне игрового цикла и добавляет в engine соответствующие сущности.
     *
     * Внутри игрового цикла эта система должна отрабатывать после всех систем, обрабатывающих
     * мышиные события, т.к. внутри update() все сущности мышиных событий удаляются, т.е.
     * в каждой итерации игрового цикла все мышиные события живут с момента возникновения
     * до вызова update() данной системы.
     *
     * Если какая-либо система, обрабатывающая событие, "поглощает" его, то она должна
     * удалить его сущность самостоятельно.
     *
     * Почему все сделано так сложно - см. https://github.com/richardlord/Ash/issues/25
     */
    public class MouseHandlingSystem extends System
    {
        private static var _stage:Stage;
        private static var _mouseIsDown:Boolean;

        private var _engine:Engine;

        /**
         * Конструктор.
         *
         * @param stage ссылка на сцену для отлавливания событий мыши
         */
        public function MouseHandlingSystem(stage:Stage)
        {
            _stage = stage;
        }

        //---------------------------------------------------------------------
        //
        //  Public static getters
        //
        //---------------------------------------------------------------------

        /**
         * Нажата ли мышь.
         */
        public static function get mouseIsDown():Boolean
        {
            return _mouseIsDown;
        }

        /**
         * X-координата мыши.
         */
        public static function get mouseX():Number
        {
            return _stage.mouseX;
        }

        /**
         * Y-координата мыши.
         */
        public static function get mouseY():Number
        {
            return _stage.mouseY;
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

            _stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
            _stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
            _stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        }

        /**
         * @inheritDoc
         */
        override public function removeFromEngine(engine:Engine):void
        {
            _engine = null;

            _stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
            _stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
            _stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        }

        /**
         * @inheritDoc
         */
        override public function update(time:Number):void
        {
            // удаляем MouseDown

            var downNodes:NodeList = _engine.getNodeList(MouseDownNode);

            for(var downNode:MouseDownNode = downNodes.head; downNode; downNode = downNode.next)
            {
                _engine.removeEntity(downNode.entity);
            }

            // удаляем MouseUp

            var upNodes:NodeList = _engine.getNodeList(MouseUpNode);

            for(var upNode:MouseUpNode = upNodes.head; upNode; upNode = upNode.next)
            {
                _engine.removeEntity(upNode.entity);
            }

            // удаляем Click

            var clickNodes:NodeList = _engine.getNodeList(ClickNode);

            for(var clickNode:ClickNode = clickNodes.head; clickNode; clickNode = clickNode.next)
            {
                _engine.removeEntity(clickNode.entity);
            }

            // удаляем MouseMove

            var moveNodes:NodeList = _engine.getNodeList(MouseMoveNode);

            for(var moveNode:MouseMoveNode = moveNodes.head; moveNode; moveNode = moveNode.next)
            {
                _engine.removeEntity(moveNode.entity);
            }
        }

        //---------------------------------------------------------------------
        //
        //  Private methods
        //
        //---------------------------------------------------------------------

        /**
         * Обработчик нажатия мыши.
         *
         * Создает сущность с MouseDownComponent.
         *
         * @param e
         */
        private function onMouseDown(e:MouseEvent):void
        {
            _engine.addEntity(new Entity().add(new MouseDownComponent(e.stageX, e.stageY)));

            _mouseIsDown = true;
        }

        /**
         * Обработчик отпускания мыши.
         *
         * Создает сущность с MouseUpComponent и, если мышь была нажата и отпущена в пределах флешки,
         * также создает сущность с ClickComponent.
         *
         * @param e
         */
        private function onMouseUp(e:MouseEvent):void
        {
            _engine.addEntity(new Entity().add(new MouseUpComponent(e.stageX, e.stageY)));

            if(_mouseIsDown) _engine.addEntity(new Entity().add(new ClickComponent(e.stageX, e.stageY)));

            _mouseIsDown = false;
        }

        /**
         * Обработчик перемещения мыши.
         *
         * Создает сущность с MouseMoveComponent.
         *
         * @param e
         */
        private function onMouseMove(e:MouseEvent):void
        {
            _engine.addEntity(new Entity().add(new MouseMoveComponent(e.stageX, e.stageY)));
        }
    }
}
