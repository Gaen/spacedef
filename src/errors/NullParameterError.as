package errors
{
    /**
     * Ошибка нулевого параметра.
     */
    public class NullParameterError extends Error
    {
        /**
         * Конструктор.
         *
         * @param message
         * @param id
         */
        public function NullParameterError(message:String = "Параметр не должен быть нулевым!", id:* = 0)
        {
            super(message, id)
        }
    }
}
