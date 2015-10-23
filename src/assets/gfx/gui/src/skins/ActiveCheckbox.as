package skins 
{
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Stamp;
	import ui.Checkbox;
	
	/**
	 * ...
	 * @author Abel Toy (Rolpege) [http://abeltoy.com/]
	 */
	public class ActiveCheckbox extends Checkbox 
	{
		protected var normal:Stamp;
		protected var hover:Stamp;
		
		protected var check:Image;
		
		protected var label:Stamp;
		
		public function ActiveCheckbox(x:Number=0, y:Number=0, text:String="", width:Number=150, height:Number=50, callback:Function=null, params:Object=null, checked:Boolean=false) 
		{
			super(x, y, text, width, height, callback, params, checked);
			
			//storing the state stamps
			normal = drawButton(width, height, 0xD85D09, 0xB13300, 0xDE700C, 0xC13D00);
			hover = drawButton(width, height, 0x5A5047, 0x302920, 0x776D5D, 0x3D3329);
			
			drawLabel();
			
			//grab the check image, scale it and center. similar to BlueCheckbox
			check = new Image(Assets.ACTIVE_CHECK);
			check.smooth = true;
			check.scale = height / (check.height + 20);
			check.visible = checked;
			check.x = (height - check.scaledWidth) * 0.5;
			check.y = (height - check.scaledHeight) * 0.5;
			
			graphic = normal;
		}
		
		protected function drawButton(width:Number, height:Number, topColor:uint, bottomColor:uint, borderTop:uint, borderBottom:uint):Stamp
		{
			//here we do the same process as ActiveButtons, but we draw two boxes. The orange and the grey ones
			var gradientMatrix:Matrix = new Matrix();
			gradientMatrix.createGradientBox(height, height, 270 * FP.RAD);
			
			g.beginGradientFill("linear", [borderTop, borderBottom], [1, 1], [0, 255], gradientMatrix);
			g.drawRect(0, 0, height, height);
			g.endFill();
			
			gradientMatrix.createGradientBox(height - 2, height - 2, 270 * FP.RAD, 1, 1);
			g.beginGradientFill("linear", [topColor, bottomColor], [1, 1], [0, 255], gradientMatrix);
			g.drawRect(1, 1, height - 2, height - 2);
			g.endFill();
			
			gradientMatrix.createGradientBox(width - height, height, 270 * FP.RAD, height);
			g.beginGradientFill("linear", [0xFFFFFF, 0xB3B2B2], [1, 1], [0, 255], gradientMatrix);
			g.drawRect(height + 1, 0, width - height - 1, height);
			g.endFill();
			
			gradientMatrix.createGradientBox(width - height - 2, height - 2, 270 * FP.RAD, height + 1, 1);
			g.beginGradientFill("linear", [0xE7E7E7, 0xC4C4C4], [1, 1], [0, 255], gradientMatrix);
			g.drawRect(height + 2, 1, width - height - 3, height - 2);
			g.endFill();
			
			//outline
			
			sprite.filters = [new GlowFilter(0x000000, 1, 2, 2, 6, 2)];
			
			return drawStamp(width + 2, height + 2, 1, 1);
		}
		
		protected function drawLabel():void
		{
			//orange label with a white, vertical shadow. the shadow gives a sense of inner depth, as if the text was "inside" the button
			
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