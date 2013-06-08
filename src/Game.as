package
{
    import ash.core.Engine;
    import ash.core.Entity;
    import ash.tick.FrameTickProvider;

    import com.genome2d.components.renderables.GSprite;
    import com.genome2d.core.GNode;
    import com.genome2d.core.GNodeFactory;
    import com.genome2d.core.Genome2D;
    import com.genome2d.textures.factories.GTextureFactory;

    import components.DisplayComponent;
    import components.PositionComponent;

    import flash.display.DisplayObjectContainer;

    import systems.RenderSystem;
    import systems.SystemPriorities;

    public class Game
    {
        private var _engine:Engine;

        /**
         * Конструктор.
         *
         * @param container
         */
        public function Game(container:DisplayObjectContainer)
        {
            _engine = new Engine();

            _engine.addSystem(new RenderSystem(Genome2D.getInstance().root), SystemPriorities.RENDER);

            var asteroidView:GNode = GNodeFactory.createNode();
            var asteroidSprite:GSprite = asteroidView.addComponent(GSprite) as GSprite;
            asteroidSprite.setTexture(GTextureFactory.createFromBitmapData("asteroid", new bmp_Asteroid()));

            var asteroid:Entity = new Entity();

            asteroid
                .add(new PositionComponent(300, 300))
                .add(new DisplayComponent(asteroidView));

            _engine.addEntity(asteroid);

            var tickProvider:FrameTickProvider = new FrameTickProvider(container);
            tickProvider.add(_engine.update);
            tickProvider.start();
        }
    }
}
