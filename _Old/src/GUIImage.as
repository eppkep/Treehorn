package 
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import 	net.flashpunk.graphics.Stamp;
	
	
	public class GUIImage extends Entity
	{	
		
		public function GUIImage(id:Class, posX:int, posY:int) 
		{
			x = posX;
			y = posY;
			
			graphic = new Stamp(id);
		}
		
		
		
	}

}