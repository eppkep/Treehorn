package  
{
    import net.isobang.MapWorld;

    public class isotestWorld extends MapWorld
    {
        [Embed(source = 'assets/testzlib.tmx', mimeType = 'application/octet-stream')] private const TEST_MAP:Class;
        public function isotestWorld() 
        {
            loadMap(TEST_MAP);
        }

        override public function begin():void
        {
            init();
        }

    }

}