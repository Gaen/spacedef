package game.components
{
    import com.genome2d.components.renderables.GTexturedQuad;
    import com.genome2d.textures.GTexture;

    import errors.NullParameterError;

    public class DisplayComponent
    {
        private var _quad:GTexturedQuad;

        /**
         * Компонент отображения.
         *
         * @param quad
         */
        public function DisplayComponent(quad:GTexturedQuad)
        {
            if(!quad) throw new NullParameterError("Параметр quad не должен быть null!");

            _quad = quad;
        }

        //---------------------------------------------------------------------
        //
        //  Public methods
        //
        //---------------------------------------------------------------------

        public function update(deltaTime:uint):void
        {
            _quad.update(deltaTime, false, false);
        }

        public function getTexture():GTexture
        {
            return _quad.getTexture();
        }
    }
}
