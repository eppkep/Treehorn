package
{
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import ui.Button;
	import net.flashpunk.graphics.Text;
	import ui.TextInput;
	
	public class testZone extends World
	{
		
		public static var testInputText:TextInput;
		
		public function testZone ()
		{
			super();
			
			Globals.currentLocation = "Billy's PlaceASSSSSSSSSS";
			Globals.reset();
			add(Globals.CURRENT_GUI);
			add(new Button(69, 69, "+1", Callbacks.testZonePlusOne));
			add(new Button(69, 99, "Redraw GUI", Callbacks.redrawGuiCallback));
			
			testInputText = new TextInput(640, 400, "Enterasdasdasdlocation", false);
			
			add(testInputText);
			
			//Globals.PLAYER.x = 64;
			//Globals.PLAYER.y = 240;
			//add(Globals.PLAYER);
			//add(Globals.PARTICLE_EMITTER);
		}
		
		override public function begin():void
		{
			super.begin();
			trace("Welcome to the test zone.");
			
			// would like to test the gui here
			// might be useful: http://ursagames.com/shmuptutorial/shmup-tutorial-7-lives-and-scoring/
			
			Globals.lastLocation = "Test Zone";
		}
		
		override public function update():void {
			super.update();
			Globals.CURRENT_GUI.updateScore();
		}
		
	}
}
