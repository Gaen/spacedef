package game.systems
{
    import ash.core.Engine;
    import ash.core.System;

    import input.MouseManager;

    /**
     * Система обработки мыши.
     *
     * Отвечает за то, чтобы MouseManager слушал события и за удаление неиспользованных событий
     * в конце каждой итерации игрового цикла.
     *
     * Должна вызываться после всех систем, использующих мышиные события.
     */
    public class MouseHandlingSystem extends System
    {
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
            MouseManager.startListening();
        }

        /**
         * @inheritDoc
         */
        override public function removeFromEngine(engine:Engine):void
        {
            MouseManager.stopListening();
        }

        /**
         * @inheritDoc
         */
        override public function update(time:Number):void
        {
            MouseManager.clear();
        }
    }
}
