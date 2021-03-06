package
{
	import net.flashpunk.World;
	public class MenuWorld extends World
	{
		
		public function MenuWorld()
		{
			super();
		}
		
		override public function begin():void
		{
			super.begin();
			trace("inside the gameworld");
			
			//add buttons here
			//info for adding buttons: button text, button type, button.x, button.y
			
			add(new GUIImage(Assets.titleImage, 20, 20));
			
			GV.PARTICLE_EMITTER = new Particles;
			add(GV.PARTICLE_EMITTER);
			
			add(new GUIButton("FirstWorld", 1, 100, 100));
			
			add(new GUIButton("isotestWorld", 2, 100, 150));
			
			add(new GUIButton("GUI Test World", 3, 100,200));
		}
	}
}
