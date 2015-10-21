package{
import net.flashpunk.Engine;
// Added the following for the Worlds:
import net.flashpunk.FP;

// So this is the exclusive/proprietary Main.as, in terms of FlashPunk (FP).
// Meaning, Main extends "Engine" instead of "Sprite" as FlashDevelop would do.
// I'm able to do this here because I've downloaded FP and copied the "net" folder into my project's /src/ folder, as instructed.
// No need to edit classpaths or anything, since /src/ should be included by default.

	public class Main extends Engine
	{
		public function Main()
		{
			// Engine vars: width, height, framerate, fixed framerate boolean
			super(1280, 720, 60, false);
			// Adding a world to play with:
			FP.world = new MenuWorld;
		}
		
		override public function init():void
		{
			trace("ID42: FlashPunk's Engine init has started successfully. The game loop is ticking...");
		}
	}
}
