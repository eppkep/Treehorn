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
		
		public static function testZonePlusOne():void {
			Globals.POINTS = Globals.POINTS + 1;
			trace(Globals.POINTS);
		}
		
		public static function inventoryCallback():void {
			trace("Access the ivnen tory");
		}
		
		public static function redrawGuiCallback():void {
			trace("Click Redraw the GUI,");
			Globals.currentLocation = testZone.testInputText.text;
			Globals.CURRENT_GUI.redrawGui();
			//GUI.redrawGui();
		}
		
	}

}