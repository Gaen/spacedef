package
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.TextField;
    import flash.utils.getDefinitionByName;

    [SWF(width=600, height=600, frameRate=30, backgroundColor=0x333333)]
    public class Preloader extends MovieClip
    {
        private var _txt:TextField = new TextField();

        /**
         * Конструктор.
         */
        public function Preloader()
        {
            if(stage)
            {
                stage.scaleMode = StageScaleMode.NO_SCALE;
                stage.align = StageAlign.TOP_LEFT;
            }

            addChild(_txt);

            loaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
            loaderInfo.addEventListener(Event.COMPLETE, onComplete);
        }

        /**
         * Обработчик прогресса
         *
         * @param e
         */
        private function onProgress(e:ProgressEvent):void
        {
            _txt.text = loaderInfo.bytesLoaded.toString();
        }

        /**
         * Обработчик завершения загрузки
         * @param e
         */
        private function onComplete(e:Event):void
        {
            loaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
            loaderInfo.removeEventListener(Event.COMPLETE, onComplete);

            // Если переключились на последний кадр - стартуем
            if(currentFrame == totalFrames)
            {
                startup();
                return;
            }

            // Если не переключились - ждем пока переключимся
            addEventListener(Event.ENTER_FRAME, checkFrame);
        }

        /**
         * Обработчик ENTER_FRAME - ждет последнего кадра
         * @param e
         */
        private function checkFrame(e:Event):void
        {
            if(currentFrame != totalFrames) return;

            removeEventListener(Event.ENTER_FRAME, checkFrame);

            startup();
        }

        /**
         * Инициализация приложения
         */
        private function startup():void
        {
            removeChild(_txt);

            var mainClass:Class = getDefinitionByName("Main") as Class;

            stage.addChild(new mainClass() as DisplayObject);
        }
    }
}