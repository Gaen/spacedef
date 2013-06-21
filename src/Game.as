package
{
    import ash.core.Engine;
    import ash.core.Entity;
    import ash.tick.FrameTickProvider;

    import com.genome2d.components.renderables.GSprite;
    import com.genome2d.core.Genome2D;
    import com.genome2d.textures.GTexture;
    import com.genome2d.textures.factories.GTextureFactory;

    import flash.display.DisplayObjectContainer;

    import game.WorldSettings;
    import game.components.BoxComponent;
    import game.components.DisplayComponent;
    import game.components.MotionComponent;
    import game.components.PositionComponent;
    import game.components.SizeComponent;
    import game.systems.ClickToRemoveSystem;
    import game.systems.MouseHandlingSystem;
    import game.systems.MovementSystem;
    import game.systems.RenderSystem;
    import game.systems.SystemPriorities;

    import input.MouseManager;

    public class Game
    {
        private var _engine:Engine;

        private var _asteroidTexture:GTexture = GTextureFactory.createFromBitmapData("asteroid", new bmp_Asteroid());

        /**
         * Конструктор.
         *
         * @param container
         */
        public function Game(container:DisplayObjectContainer)
        {
            MouseManager.init(container.stage);

            _engine = new Engine();

            _engine.addSystem(new MovementSystem(), SystemPriorities.MOVE);
            _engine.addSystem(new ClickToRemoveSystem(), SystemPriorities.PROCESS_INPUT);
            _engine.addSystem(new MouseHandlingSystem(), SystemPriorities.INPUT_PROCESSED);
            _engine.addSystem(new RenderSystem(Genome2D.getInstance().root), SystemPriorities.RENDER_OBJECTS);

            for(var i:uint = 0; i < 100; i++) _engine.addEntity(createAsteroid());

            var tickProvider:FrameTickProvider = new FrameTickProvider(container);
            tickProvider.add(_engine.update);
            tickProvider.start();
        }

        /**
         * Создает астероид.
         *
         * @return сущность астероида
         */
        private function createAsteroid():Entity
        {
            var asteroid:Entity = new Entity();

            var sprite:GSprite = new GSprite(null);
            sprite.setTexture(_asteroidTexture);

            asteroid
                .add(new PositionComponent(Math.random() * WorldSettings.WIDTH, Math.random() * WorldSettings.HEIGHT))
                .add(new SizeComponent(_asteroidTexture.width, _asteroidTexture.height))
                .add(new MotionComponent(Math.random() * 20 - 10, Math.random() * 20 - 10, Math.random() * 30 - 15))
                .add(new DisplayComponent(sprite))
                .add(new BoxComponent(_asteroidTexture.width, _asteroidTexture.height));

            return asteroid;
        }
    }
}
