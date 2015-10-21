package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;

	public class Bullet extends Entity
	{
		[Embed(source = 'gfx/bullet.png')] private const BULLET_SPRITE:Class;
		
		public function Bullet(givenX:Number = 0, givenY:Number = 0)
		{
			
			setHitbox(16, 16);
			type = "bullet";
			
			x = givenX;
			y = givenY;
			
			graphic = new Image(BULLET_SPRITE);
		}
	}
}
