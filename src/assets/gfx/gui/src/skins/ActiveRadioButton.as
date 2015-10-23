package skins 
{
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Stamp;
	import ui.RadioButton;
	import ui.RadioButtonGroup;
	
	/**
	 * ...
	 * @author Abel Toy (Rolpege) [http://abeltoy.com/]
	 */
	public class ActiveRadioButton extends RadioButton 
	{
		protected var normal:Stamp;
		protected var hover:Stamp;
		
		protected var check:Stamp;
		
		protected var label:Stamp;
		
		public function ActiveRadioButton(x:Number=0, y:Number=0, group:RadioButtonGroup=null, text:String="", width:Number=150, height:Number=50, params:Object=null, checked:Boolean=false) 
		{
			super(x, y, group, text, width, height, params);
			
			normal = drawButton(width, height, 0xD85D09, 0xB13300, 0xDE700C, 0xC13D00);
			hover = drawButton(width, height, 0x5A5047, 0x302920, 0x776D5D, 0x3D3329);
			
			drawLabel();
			drawCheck();
			
			check.visible = checked;
			
			graphic = normal;
			
			//we need to set this separately from the constructor, because when this is set the changeCheck method is called, and we would get some
			//null reference errors as we create the images and stuff AFTER the constructor
			this.checked = checked;
		}
		
		protected function drawCheck():void
		{
			//draws a gradient circle with a shadow and centers it
			var checkSize:Number = height - 20;
			if (checkSize < 5) checkSize = 5;
			
			g.clear();
			
			var gradientMatrix:Matrix = new Matrix();
			gradientMatrix.createGradientBox(checkSize, checkSize, 270 * FP.RAD);
			g.beginGradientFill("linear", [0xFFFFFF, 0xD5D5D5], [1, 1], [0, 255], gradientMatrix);
			g.drawCircle(checkSize * 0.5, checkSize * 0.5, checkSize * 0.5);
			g.endFill();
			
			sprite.filters = [new DropShadowFilter(2, 45, 0x000000, 0.25, 3, 3, 1, 3)];
			
			check = drawStamp(checkSize + 4, checkSize + 4);
			check.x = (height - checkSize) * 0.5;
			check.y = (height - checkSize) * 0.5;
		}
		
		protected function drawButton(width:Number, height:Number, topColor:uint, bottomColor:uint, borderTop:uint, borderBottom:uint):Stamp
		{
			//the same as ActiveCheckbox, but with rounded corners on the orange box. We also draw the outline manually, because the glow trick
			//for the outline looks really bad on those rounded corners.
			var gradientMatrix:Matrix = new Matrix();
			gradientMatrix.createGradientBox(height, height, 270 * FP.RAD);
			
			g.lineStyle(0, 0, 1, false, "normal", CapsStyle.NONE, JointStyle.BEVEL);
			g.beginGradientFill("linear", [borderTop, borderBottom], [1, 1], [0, 255], gradientMatrix);
			g.drawRoundRectComplex(0, 0, height, height, height * 0.5, 0, height * 0.5, 0);
			g.endFill();
			
			g.lineStyle();
			gradientMatrix.createGradientBox(height - 2, height - 2, 270 * FP.RAD, 1, 1);
			g.beginGradientFill("linear", [topColor, bottomColor], [1, 1], [0, 255], gradientMatrix);
			g.drawRoundRectComplex(1, 1, height - 2, height - 2, height * 0.5, 0, height * 0.5, 0);
			g.endFill();
			
			g.lineStyle(0);
			gradientMatrix.createGradientBox(width - height, height, 270 * FP.RAD, height);
			g.beginGradientFill("linear", [0xFFFFFF, 0xB3B2B2], [1, 1], [0, 255], gradientMatrix);
			g.drawRect(height, 0, width - height, height);
			g.endFill();
			
			g.lineStyle();
			gradientMatrix.createGradientBox(width - height - 2, height - 2, 270 * FP.RAD, height + 1, 1);
			g.beginGradientFill("linear", [0xE7E7E7, 0xC4C4C4], [1, 1], [0, 255], gradientMatrix);
			g.drawRect(height + 1, 1, width - height - 2, height - 2);
			g.endFill();
			
			return drawStamp(width + 2, height + 2, 1, 1);
		}
		
		protected function drawLabel():void
		{
			var t:TextField = new TextField();
			
			var tf:TextFormat = new TextFormat("Bitter", 22, 0xB93F14, true);
			tf.align = "center";
			
			t.defaultTextFormat = tf;
			t.width = width - height;
			t.height = height;
			t.embedFonts = true;
			t.text = text;
			
			
			t.filters = [new DropShadowFilter(1, 90, 0xFFFFFF, 1, 0, 0, 1, 3)];
			
			label = drawStamp(width + 4, t.textHeight + 4, 0, 0, t);
			label.x = height;
			label.y = (height - t.textHeight) * 0.5 - 3;
		}
		
		override protected function changeState(state:int = 0):void 
		{
			if (state == lastState) return;
			
			switch(state)
			{
				case NORMAL:
				case DOWN:
					graphic = normal;
					break;
				case HOVER:
					graphic = hover;
					break;
			}
			
			super.changeState(state);
		}
		
		override protected function changeCheck():void 
		{
			super.changeCheck();
			
			check.visible = checked;
		}
		
		override public function render():void 
		{
			super.render();
			
			renderGraphic(label);
			renderGraphic(check);
		}
	}

}