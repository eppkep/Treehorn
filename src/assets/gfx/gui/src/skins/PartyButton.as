package skins 
{
	import flash.display.BitmapData;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Ease;
	import ui.Button;
	
	/**
	 * ...
	 * @author Abel Toy (Rolpege) [http://abeltoy.com/]
	 */
	public class PartyButton extends Button 
	{
		protected var emitter:Emitter;
		protected var emitters:Graphiclist;
		
		protected var label:Stamp;
		
		//ammount of circles in the emitter
		protected var circles:int = 20;
		
		public function PartyButton(x:Number=0, y:Number=0, text:String="", width:Number=150, height:Number=50, callback:Function=null, circles:int = 20, params:Object=null) 
		{
			super(x, y, text, width, height, callback, params);
			
			emitters = new Graphiclist;
			graphic = emitters;
			
			this.circles = circles;
			
			initEmitter();
			drawLabel();
		}
		
		protected function drawLabel():void
		{
			//draws a glowing label, with random glowing color.
			var t:TextField = new TextField();
			
			var tf:TextFormat = new TextFormat("Comfortaa", 20, 0xFFFFFF);
			tf.align = "center";
			
			t.defaultTextFormat = tf;
			t.width = width;
			t.height = height;
			t.embedFonts = true;
			t.wordWrap = true;
			t.text = text;
			
			//the color is randomnized using a special function. only the hue is randomnized, saturation and value (brightness) are always the higher.
			//only bright colors for the glow.
			t.filters = [new GlowFilter(FP.getColorHSV(Math.random(), 1, 1), 1, 10, 10, 3.2, 3)];
			
			label = drawStamp(width + 10, t.textHeight + 10, 5, 5, t);
			label.y = (height - t.textHeight) * 0.5 - 8;
		}
		
		protected function initEmitter():void
		{
			//Creates a new emitter which is paused.
			var bd:BitmapData = new BitmapData(180, 60, true, 0);
			Draw.setTarget(bd);
			Draw.circlePlus(30, 30, 15);
			Draw.circlePlus(90, 30, 23);
			Draw.circlePlus(150, 30, 30);
			
			var emitter:Emitter = new Emitter(bd, 60, 60);
			for (var i:int = 0; i < circles; ++i)
			{
				//random color function which ensures the colors aren't too black.
				var color:uint = FP.getColorHSV(Math.random(), 0.75 + Math.random() * 0.25, 0.75 + Math.random() * 0.25);
				emitter.newType(i.toString(), [int(Math.random() * 3)]);
				emitter.setColor(i.toString(), color, color);
				emitter.setMotion(i.toString(), 0, 5, 0.2, 360, 80, 0.2, Ease.quadOut);
				emitter.setAlpha(i.toString(), 1, 0);
				
				emitter.emit(i.toString(), (15 + Math.random() * (width - 30)) - 30, (15 + Math.random() * (height - 30)) - 30);
			}
			
			this.emitter = emitter;
			emitter.active = false;
		}
		
		override public function update():void 
		{
			super.update();
			
			//we have a graphiclist for all the active emitters. when they finish, they are removed.
			var emlist:Vector.<Graphic> = emitters.children;
			for each(var g:Graphic in emlist)
			{
				var em:Emitter = g as Emitter;
				if (em.particleCount < 0) emitters.remove(em);
			}
		}
		
		override protected function changeState(state:int = 0):void 
		{
			if (state == lastState) return;
			
			//we make a new explosion everytime EXCEPT when we com from a down state to a hover state (Releasing the mouse)
			if (!(state == HOVER && lastState == DOWN))
			{
				//explosion is making the emitter active, and adding it to the list of active emitters
				emitter.active = true;
				emitters.add(emitter);
				//just after the explosion, we add a new inactive emitter below it.
				initEmitter();
				drawLabel();
			}
			
			super.changeState(state);
		}
		
		override public function render():void 
		{
			renderGraphic(emitter);
			super.render();
			renderGraphic(label);
		}
	}
}