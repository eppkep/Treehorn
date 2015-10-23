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
	import ui.Checkbox;
	
	/**
	 * ...
	 * @author Abel Toy (Rolpege) [http://abeltoy.com/]
	 */
	public class NeonCheckbox extends Checkbox 
	{
		protected var buttonBmp:BitmapData;
		
		protected var label:TextField;
		protected var labelGlow:GlowFilter;
		protected var buttonGlow:GlowFilter;
		
		protected var checkColor:uint;
		protected var checkGlow:GlowFilter;
		
		protected var color:uint;
		protected var glowColor:uint;
		
		protected var nColor:uint;
		protected var nGlow:uint;
		protected var hColor:uint;
		protected var hGlow:uint;
		
		protected var flickerTimer:Number = 0;
		
		//the same concepts as for NeonButton apply
		
		public function NeonCheckbox(x:Number=0, y:Number=0, text:String="", width:Number=150, height:Number=40, callback:Function=null,
			normalColor:uint = 0x6AFEFE, normalGlow:uint = 0x178FFF, hoverColor:uint = 0xFFE620, hoverGlow:uint = 0xFD3825, params:Object=null, checked:Boolean=false) 
		{
			super(x, y, text, width, height, callback, params, checked);
			
			buttonBmp = new BitmapData(width + 50, height + 50, true, 0);
			
			nColor = normalColor;
			nGlow = normalGlow;
			hColor = hoverColor;
			hGlow = hoverGlow;
			
			color = nColor;
			glowColor = nGlow;
			
			createLabel();
			buttonGlow = new GlowFilter(glowColor, 1, 10, 10, 5, 3);
			drawButton();
			drawLabel();
			
			checkColor = checked ? color : 0x999999;
			checkGlow = new GlowFilter(glowColor, 1, 10, 10, checked ? 5 : 0, 3);
			
			drawCheck();
			
			graphic = new Stamp(buttonBmp, -25, -25);
		}
		
		protected function createLabel():void
		{
			label = new TextField();
			
			var tf:TextFormat = new TextFormat("Neon", 24, color);
			
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
		protected function drawButton():void
		{
			g.clear();
			
			g.lineStyle(2, color, 1, false, "normal", CapsStyle.NONE, JointStyle.MITER);
			g.drawRoundRectComplex(0, 0, height, height, 0, 10, 10, 0);
			g.endFill();
			
			sprite.filters = [buttonGlow];
			
			m.tx = 25;
			m.ty = 25;
			buttonBmp.draw(sprite, m);
		}
		
		protected function drawCheck():void
		{
			var checkSize:Number = height * 0.5;
			
			g.clear();
			
			g.lineStyle(2, checkColor, 1, false, "normal", CapsStyle.NONE, JointStyle.MITER);
			g.moveTo(0, checkSize - (checkSize * 0.3));
			g.lineTo(checkSize * 0.3, checkSize);
			g.lineTo(checkSize, 0);
			
			if (checked) sprite.filters = [checkGlow];
			else sprite.filters = [];
			
			m.tx = 25 + (height - checkSize) * 0.5;
			m.ty = 25 + (height - checkSize) * 0.5;
			buttonBmp.draw(sprite, m);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (flickerTimer > 0)
			{
				buttonGlow.strength = Math.random() * 5;
				labelGlow.strength = Math.random() * 2;
				checkGlow.strength = Math.random() * 5;
				
				flickerTimer -= FP.elapsed;
				
				if (flickerTimer <= 0)
				{
					buttonGlow.strength = 5;
					labelGlow.strength = 2;
					checkGlow.strength = 5;
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
					flickerTimer = 0;
					color = 0x999999;
					buttonGlow.strength = 0;
					labelGlow.strength = 0;
					checkGlow.strength = 0;
					redraw();
					break;
			}
			
			super.changeState(state);
		}
		
		override protected function changeCheck():void 
		{
			super.changeCheck();
			
			redraw();
		}
		
		protected function drawLabel():void
		{
			m.tx = 25 + 10 + height;
			m.ty = 25 + (height - label.textHeight) * 0.5;
			buttonBmp.draw(label, m);
		}
		
		protected function redraw():void
		{
			buttonBmp.fillRect(buttonBmp.rect, 0);
			drawButton();
			
			label.textColor = color;
			labelGlow.color = glowColor;
			buttonGlow.color = glowColor;
			label.filters = [labelGlow];
			
			if (checked)
			{
				checkColor = color;
				checkGlow.color = glowColor;
			}
			else checkColor = 0x999999;
			
			drawLabel();
			drawCheck();
		}
	}
}