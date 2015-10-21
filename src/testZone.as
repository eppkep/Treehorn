package
{
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import ui.Button;
	import net.flashpunk.graphics.Text;
	
	public class testZone extends World
	{
		
		public function testZone ()
		{
			super();
		}
		
		override public function begin():void
		{
			super.begin();
			trace("Welcome to the test zone.");
			
			// would like to test the gui here
			// might be useful: http://ursagames.com/shmuptutorial/shmup-tutorial-7-lives-and-scoring/
			
		}
		
	}
}
