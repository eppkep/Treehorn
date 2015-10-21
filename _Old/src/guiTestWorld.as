package
{
	import net.flashpunk.World;
	import net.flashpunk.FP;
	public class guiTestWorld extends World
	{
		
		public function guiTestWorld()
		{
			super();
		}
		
		override public function begin():void
		{
			super.begin();
			trace("inside the gameworld");
			
			add(new GUIImage(Assets.iconInventory, 1, FP.height - 41));
			add(new GUIImage(Assets.iconJournal, 42, FP.height - 41));
			add(new GUIImage(Assets.iconMap, 83, FP.height - 41));
			add(new GUIImage(Assets.iconTurns,124, FP.height - 41));
			
			
			add(new GUIImage(Assets.iconMusic, FP.width - 165, FP.height - 41));
			add(new GUIImage(Assets.iconSound, FP.width - 124, FP.height - 41));
			add(new GUIImage(Assets.iconSave, FP.width - 83, FP.height - 41));
			add(new GUIImage(Assets.iconSettings, FP.width - 41, FP.height - 41));
		}
	}
}
