package skins 
{
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Stamp;
	import ui.Button;
	
	/**
	 * ...
	 * @author Abel Toy (Rolpege) [http://abeltoy.com/]
	 */
	public class NeonButton extends Button 
	{
		protected var buttonBmp:BitmapData;
		
		protected var label:TextField;
		protected var labelGlow:GlowFilter;
		protected var buttonGlow:GlowFilter;
		
		protected var color:uint;
		protected var glowColor:uint;
		
		protected var nColor:uint;
		protected var nGlow:uint;
		protected var hColor:uint;
		protected var hGlow:uint;
		
		protected var flickerTimer:Number = 0;
		
		public function NeonButton(x:Number = 0, y:Number = 0, text:String = "", width:Number = 150, height:Number = 50, callback:Function = null,
			normalColor:uint = 0x6AFEFE, normalGlow:uint = 0x178FFF, hoverColor:uint = 0xFFE620, hoverGlow:uint = 0xFD3825, params:Object=null) 
		{
			super(x, y, text, width, height, callback, params);
			
			buttonBmp = new BitmapData(width + 50, height + 50, true, 0);
			
			//the color for each state, stored
			nColor = normalColor;
			nGlow = normalGlow;
			hColor = hoverColor;
			hGlow = hoverGlow;
			
			color = nColor;
			glowColor = nGlow;
			
			//we create the label in a different method, as we won't recreate it.
			createLabel();
			buttonGlow = new GlowFilter(glowColor, 1, 10, 10, 5, 3);
			drawButton();
			drawLabel();
			
			graphic = new Stamp(buttonBmp, -25, -25);
		}
		
		protected function createLabel():void
		{
			//create the label, method is run just once.
			label = new TextField();
			
			var tf:TextFormat = new TextFormat("Neon", 24, color);
			tf.align = "center";
			
			label.defaultTextFormat = tf;
			label.width = width;
			label.height = height;
			label.embedFonts = true;
			label.wordWrap = true;
			label.text = text;
			
			labelGlow = new GlowFilter(glowColor, 1, 10, 10, 2, 3);
			label.filters = [labelGlow];
		}
		
		private var m:Matrix = new Matrix;
		
		//draw a rounded square with some glow filter
		protected function drawButton():void
		{
			g.clear();
			
			g.lineStyle(2, color, 1, false, "normal", CapsStyle.NONE, JointStyle.MITER);
			g.drawRoundRectComplex(0, 0, width, height, 15, 0, 0, 15);
			g.endFill();
			
			sprite.filters = [buttonGlow];
			
			m.tx = 25;
			m.ty = 25;
			buttonBmp.draw(sprite, m);
		}
		
		override public function update():void 
		{
			super.update();
			
			//this helps us make the flicker screen. we can set flickerTimer somewhere in the code to some value, this will be the duration
			//of the flicker in seconds. during flicker, the strength of the glow filters is random.
			if (flickerTimer > 0)
			{
				buttonGlow.strength = Math.random() * 5;
				labelGlow.strength = Math.random() * 2;
				
				flickerTimer -= FP.elapsed;
				
				if (flickerTimer <= 0)
				{
					buttonGlow.strength = 5;
					labelGlow.strength = 2;
				}
				
				redraw();
			}
		}
		
		override protected function changeState(state:int = 0):void 
		{
			if (state == lastState) return;
			
			switch(state)
			{
				case NORMAL:
					color = nColor;
					glowColor = nGlow;
					flickerTimer = 0.25;
					break;
				case HOVER:
					color = hColor;
					glowColor = hGlow;
					flickerTimer = 0.25;
					break;
				case DOWN:
					//down makes all the neon lights go off
					flickerTimer = 0;
					color = 0x999999;
					buttonGlow.strength = 0;
					labelGlow.strength = 0;
					redraw();
					break;
			}
			
			super.changeState(state);
		}
		
		protected function drawLabel():void
		{
			m.tx = 25;
			m.ty = 25 + (height - label.textHeight) * 0.5;
			buttonBmp.draw(label, m);
		}
		
		protected function redraw():void
		{
			//we don't use multiple stamps, but just redraw everything on the button bitmapdata. as we have to redraw the same things every frame, because
			//of the iflter, this is a bit easier and less consuming.
			buttonBmp.fillRect(buttonBmp.rect, 0);
			drawButton();
			
			label.textColor = color;
			labelGlow.color = glowColor;
			buttonGlow.color = glowColor;
			label.filters = [labelGlow];
			
			drawLabel();
		}
	}
}