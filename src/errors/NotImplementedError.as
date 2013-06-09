package errors
{
    public class NotImplementedError extends Error
    {
        public function NotImplementedError(message:String = "Реализация метода отсутствует!")
        {
            super(message);
        }
    }
}