package
{
	import net.flashpunk.World;
	public class FirstWorld extends World
	{
		private var box:Box;
		private var player:NoobEntity;
		
		
		public function FirstWorld()
		{
			player = new NoobEntity();
			add(player);
			add(new Bullet());
			box = new Box(420, 420);
			add(box);
			
			GV.PARTICLE_EMITTER = new Particles;
			add(GV.PARTICLE_EMITTER);
		}
		
		override public function update():void
		{
			super.update();
			 
			if (player.collideWith(box, player.x, player.y)) {
					trace("test");
			}

		}
	}
}
