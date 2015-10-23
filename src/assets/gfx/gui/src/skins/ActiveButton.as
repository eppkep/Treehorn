package skins 
{
	import flash.display.BitmapData;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.filters.GradientBevelFilter;
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
	public class ActiveButton extends Button 
	{
		protected var normal:Stamp;
		protected var hover:Stamp;
		
		protected var label:Stamp;
		
		public function ActiveButton(x:Number=0, y:Number=0, text:String="", width:Number=150, height:Number=50, callback:Function=null, params:Object=null) 
		{
			super(x, y, text, width, height, callback, params);
			
			//store the stamp for each state
			normal = drawButton(width, height, 0xD85D09, 0xB13300, 0xDE700C, 0xC13D00);
			hover = drawButton(width, height, 0x5A5047, 0x302920, 0x776D5D, 0x3D3329);
			
			drawLabel();
			
			graphic = normal;
		}
		
		protected function drawButton(width:Number, height:Number, topColor:uint, bottomColor:uint, borderTop:uint, borderBottom:uint):Stamp
		{
			//draws two boxes. one, 1px larger than the other, is the border, with a gradient. The other is the filler, with another gradient
			var gradientMatrix:Matrix = new Matrix();
			gradientMatrix.createGradientBox(width, height, 270 * FP.RAD);
			
			g.beginGradientFill("linear", [borderTop, borderBottom], [1, 1], [0, 255], gradientMatrix);
			g.drawRect(0, 0, width, height);
			g.endFill();
			
			gradientMatrix.createGradientBox(width - 2, height - 2, 270 * FP.RAD, 1, 1);
			g.beginGradientFill("linear", [topColor, bottomColor], [1, 1], [0, 255], gradientMatrix);
			g.drawRect(1, 1, width - 2, height - 2);
			g.endFill();
			
			//outline
			sprite.filters = [new GlowFilter(0x000000, 1, 2, 2, 6, 2)];
			
			return drawStamp(width + 2, height + 2, 1, 1);
		}
		
		protected function drawLabel():void
		{
			//Gradiented text.
			
			//makes the label
			var t:TextField = new TextField();
			
			var tf:TextFormat = new TextFormat("Bitter", 22, 0xFFFFFF, true);
			tf.align = "center";
			
			t.defaultTextFormat = tf;
			t.width = width;
			t.height = height;
			t.embedFonts = true;
			t.text = text;
			
			//makes a square with a gradient fill
			g.clear();
			var gradientMatrix:Matrix = new Matrix();
			gradientMatrix.createGradientBox(width, t.textHeight, 270 * FP.RAD);
			g.beginGradientFill("linear", [0xFFFFFF, 0xD5D5D5], [1, 1], [0, 255], gradientMatrix);
			g.drawRect(0, 0, width, t.textHeight);
			
			//uses the text as the mask for the square. this way we can achieve a gradient text effect
			sprite.mask = t;
			
			//a subtle shadow
			sprite.filters = [new DropShadowFilter(2, 45, 0x000000, 0.25, 3, 3, 1, 3)];
			
			label = drawStamp(width + 4, t.textHeight + 4);
			label.y = (height - t.textHeight) * 0.5 - 3;
		}
		
		override protected function changeState(state:int = 0):void 
		{
			if (state == lastState) return;
			
			switch(state)
			{
				//normal and down will be the same image
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
		
		override public function render():void 
		{
			super.render();
			
			renderGraphic(label);
		}
	}

}