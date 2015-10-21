package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	// For the pixel-perfect collision detection -- aka masks
	import net.flashpunk.masks.Pixelmask;

	public class Box extends Entity
	{
		[Embed(source = 'gfx/box.png')] private const BOX_SPRITE:Class;
		
		public function Box(givenX:Number = 0, givenY:Number = 0)
		{
			
			setHitbox(32, 32);
			type = "box";
			
			mask = new Pixelmask(BOX_SPRITE, -16, -16);
			
			x = givenX;
			y = givenY;
			
			graphic = new Image(BOX_SPRITE);
		}
	}
}
