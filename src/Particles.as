package  
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.utils.Ease;
 
	public class Particles extends Entity 
	{
 
		private var _emitter:Emitter;
 
		[Embed(source = './gfx/glitter.png')] private const PARTICLE:Class;
		
		public function Particles() 
		{
			
			//_emitter = new Emitter(new BitmapData(3, 3, false, 0xFFFFFF), 3, 3);
			_emitter = new Emitter(PARTICLE, 64, 64);
			_emitter.newType("dust", [0]);
			_emitter.setMotion("dust", 0, 100, 2, 360, -40, 1, Ease.quadOut);
			_emitter.setAlpha("dust", 1, 0.1);
			_emitter.setGravity("dust", 69);
			graphic = _emitter;
			layer = 3;
		}
 
		public function squirt(_x:Number, _y:Number, particles:int = 1):void
		{
			for (var i:uint = 0; i < particles; i++) {
				if(_emitter.particleCount<69)
				_emitter.emit("dust", _x, _y);
			}
		}
	}
}

/*package  {
import net.flashpunk.Entity;
import net.flashpunk.graphics.Emitter;
import net.flashpunk.graphics.ParticleType;
import net.flashpunk.utils.Ease;

	public class Particles extends Entity{
		[Embed(source = './gfx/dotSprite.png')] private const PARTICLE:Class;
		public var emitter:Emitter = new Emitter(PARTICLE, 2, 2);
		
		public function Particles() 
		{
			graphic = emitter;
			emitter.x = emitter.y = -5;
			//layer = 1;
			
			//create dust particles
			// Create a dust particle
			var p:ParticleType = emitter.newType("dust", [0]);
			p.setMotion(20, 5, .2, 140, 50, .3, Ease.cubeOut);
			p.setColor(0xFFFFFF, 0xFF3366, Ease.quadIn);
			
					
			// Create the trail particle.
			/*
			p = emitter.newType("trail", [0]);
			p.setMotion(0, 10, .5, 360, 30, .5, Ease.cubeInOut);
			p.setColor(0xFF3366, 0xFFFFFF);
			p.setAlpha(1, 0);*/
	/*	}
		
		public function squirt(x:Number, y:Number):void {
		
			for (var i:uint = 0; i < 12; i++) {
				emitter.emit("dust", x, y);
			}
			
		}
		
	}

}*/