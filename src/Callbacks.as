package 
{
	
	import net.flashpunk.World;
	import net.flashpunk.FP;
	
	public class Callbacks 
	{
		
		public static function callbackOne():void {
		
			trace ("test callback ONE");
		}
		
		public static function newGame():void {
		
			trace ("new game");
		}
		
		public static function testZoneButton():void {
		
			trace ("test zone");
			FP.world = new testZone;
		}
		
	}

}