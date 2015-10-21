package 
{
	import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.ParticleType;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.World;
	
	public class GUIButton extends Entity
	{	
		private var button:Image;
		private var _words:Text = new Text (" ");
		private var _type:int;
		

		
		public function GUIButton(words:String,type:int, posX:int, posY:int) 
		{
			
			
			//get parameters and set to private variables
			_words.text = words;
			_type = type;
			
			//create button to specs of incomming text and set equal to graphic for clicking
			button = Image.createRect(_words.width, _words.height, 0xFF0000);
			button.x = posX;
			button.y = posY;
			
			//move _words to same location
			_words.x = posX;
			_words.y = posY;
			
			//set graphic to button and add hitbox
			graphic = button;
			setHitbox(_words.width, _words.height);
			
			//add elements to screen
			addGraphic(button);
			addGraphic(_words);
		}
		
		
		
		override public function update():void
		{
			if (collidePoint(button.x, button.y, world.mouseX, world.mouseY))
			{
				if (Input.mouseReleased){
					click();
				}
				
				GV.PARTICLE_EMITTER.squirt(world.mouseX, world.mouseY);
				
			}
		}
		
		public function click():void
		{
			if (_type == 1)
			{
				trace("clicking button 1");
				FP.world = new FirstWorld;
			}
			
			if (_type == 2)
			{
				trace("clicking button 2");
				FP.world = new isotestWorld;
			}
			
			if (_type == 3)
			{
				trace("clicking button 3");
				FP.world = new guiTestWorld;
			}
		}
		
	}

}