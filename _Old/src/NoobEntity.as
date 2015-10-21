package
{
	import net.flashpunk.Entity;
	// Needed to render the embedded sprite:
	import net.flashpunk.graphics.Image;
	// Added these 2 for the key's in the overridden update() function:
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	// For the pixel-perfect collision detection -- aka masks
	import net.flashpunk.masks.Pixelmask;
	// Shotgun:
	import flash.geom.Point;
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.World;
	// End
	
	public class NoobEntity extends Entity
	{
		
		// This is called an "Asset Metatag" and is the go-to way to embedding gfx and shit to a class
		// Note: this only EMBEDS the image -- we still have to render it, as seen further below. You'll need the graphics.Image library for that, too.
		[Embed(source = 'gfx/noobentity.png')] private const NOOB_SPRITE:Class;
		
		public function NoobEntity()
		{
			// Rendering the embedded sprite:
			graphic = new Image(NOOB_SPRITE);
			
			Input.define("Jump", Key.V);
			Input.define("Shoot", Key.SPACE, Key.X, Key.C);
			
			mask = new Pixelmask(NOOB_SPRITE, -32, -32);
			
			setHitbox(32, 32);
			
			type = "player";
			
			x = 69;
			y = 420;
		}
		
		// We're encouraged to override this function, as per Entity.as:
		override public function added():void
		{
			trace("ID42: NoobEntity added.");
		}
		
		
		
		override public function update():void
		{
			if (collide("bullet", x, y))
			{
				// Player is colliding with a "bullet" type.
				trace("Collision detected");
				GV.PARTICLE_EMITTER.squirt(x, y);
			}
			

			
			// Various forms of Input Detection below:
			
			if (Input.check(Key.LEFT)) {
				if (Input.check("Jump")) {
					x -= 1;
				}else
					x -= 5;
				
				}
			if (Input.check(Key.RIGHT)) {
				if (Input.check("Jump")) {
					x += 1;
				}else
					x += 5;
				}
			if (Input.check(Key.UP)) {
				if (Input.check("Jump")) {
					y -= 1;
				}else
					y -= 5;
				}
			if (Input.check(Key.DOWN)) {
				if (Input.check("Jump")) {
					y += 1;
				}else
					y += 5;
				}
			
			if (Input.pressed("Jump"))
			{
				// One (or several) of the "Jump" keys was pressed this frame.
			}
			if (Input.check("Shoot"))
			{
				// One (or several) of the "Shoot" keys is being held down.
			}
			
			if (Input.mouseDown)
			{
				// The mouse button is held down.
			}
			if (Input.mousePressed)
			{
				// The mouse button was just pressed this frame.
			}
			if (Input.mouseReleased)
			{
				// The mouse button was just released this frame.
			}
		}
	}
}
