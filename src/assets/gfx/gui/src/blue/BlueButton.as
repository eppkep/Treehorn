package blue 
{
	import com.greensock.TweenLite;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.Sfx;
	import ui.Button;
	
	public class BlueButton extends Button 
	{	
		protected var glare:Stamp;
		protected var label:Stamp;
		
		protected var buttonBmp:BitmapData;
		protected var buttonGraphic:Stamp;
		
		public var topColor:uint = 0x6ACFFF;
		public var bottomColor:uint = 0x005F8C;
		public var borderColor:uint = 0x00456A;
		
		public function BlueButton(x:Number=0, y:Number=0, text:String="", width:Number=150, height:Number=50, callback:Function=null, params:Object=null) 
		{
			super(x, y, text, width, height, callback, params);
			
			buttonBmp = new BitmapData(width + 20, height + 20, true, 0);
			drawButton(buttonBmp, width, height, topColor, bottomColor, borderColor);
			
			buttonGraphic = new Stamp(buttonBmp, -5, -5);
			graphic = buttonGraphic;
			
			drawGlare();
			drawLabel(text);
			
			drawMask();
		}
		
		protected function drawMask():void
		{
			g.clear();
			g.beginFill(0x000000);
			g.drawRoundRect(0, 0, width, height, 20);
			g.endFill();
			
			var bd:BitmapData = new BitmapData(width, height, true, 0);
			bd.draw(sprite);
			
			mask = new Pixelmask(bd);
		}
		
		protected function drawGlare():void
		{
			var mask:Sprite = new Sprite;
			mask.graphics.copyFrom(g);
			
			sprite.filters = [];
			g.clear();
			g.beginFill(0xFFFFFF, 0.25);
			g.drawEllipse( -width * 0.25, -height * 0.6, width * 1.5, height);
			sprite.mask = mask;
			
			glare = drawStamp(width, height * 0.4);
		}
		
		protected function drawLabel(text:String):void
		{
			var t:TextField = new TextField();
			
			var tf:TextFormat = new TextFormat("Comfortaa", 20, 0xFFFFFF);
			tf.align = "center";
			
			t.defaultTextFormat = tf;
			t.width = width;
			t.height = height;
			t.embedFonts = true;
			t.wordWrap = true;
			t.text = text;
			t.filters = [new GlowFilter(0x6ACFFF, 0.75, 7, 7, 2, 3)];
			
			label = drawStamp(width + 10, t.textHeight + 10, 5, 5, t);
			label.y = (height - t.textHeight) * 0.5 - 8;
		}
		
		protected function drawButton(bitmap:BitmapData, width:Number, height:Number, topColor:uint, bottomColor:uint, borderColor:uint):void
		{
			g.clear();
			var gradientMatrix:Matrix = new Matrix();
			gradientMatrix.createGradientBox(width, height, 270 * FP.RAD, 0, 0);
			g.beginGradientFill("linear", [topColor, bottomColor], [1, 1], [0, 255], gradientMatrix);
			g.drawRoundRect(0, 0, width, height, 20);
			g.endFill();
			
			sprite.filters = [new GlowFilter(0xFFFFFF, 1, 10, 10, 1, 3, true), new GlowFilter(borderColor, 0.6, 2, 2, 6, 2), new DropShadowFilter(8, 45, 0, 0.8, 10, 10, 1, 3)];
			
			_m.tx = 5;
			_m.ty = 5;
			bitmap.draw(sprite, _m);
		}
		private var _m:Matrix = new Matrix;
		
		override public function render():void 
		{
			super.render();
			
			renderGraphic(glare);
			renderGraphic(label);
		}
		
		override protected function changeState(state:int = 0):void 
		{
			if (state == lastState) return;
			
			var duration:Number = 0.25;
			if (lastState == DOWN) duration = 0.15;
			
			switch(state)
			{
				case NORMAL:
					TweenLite.to(this, duration, { hexColors: { topColor: 0x6ACFFF, bottomColor: 0x005F8C, borderColor: 0x00456A }, onUpdate: updateGraphic } );
					if (lastState == HOVER) new Sfx(Assets.OUT).play();
					break;
				case HOVER:
					TweenLite.to(this, duration, { hexColors: { topColor: 0xFF8C66, bottomColor: 0xDD0500, borderColor: 0x550000 }, onUpdate: updateGraphic } );
					if (lastState == NORMAL) new Sfx(Assets.OVER).play();
					break;
				case DOWN:
					TweenLite.to(this, 0.1, { hexColors: { topColor: 0x5B5B5B, bottomColor: 0x2D2D2D, borderColor: 0x151515 }, onUpdate: updateGraphic } );
					new Sfx(Assets.CLICK).play();
					break;
			}
			
			super.changeState(state);
		}
		
		protected function updateGraphic():void
		{
			buttonBmp.fillRect(buttonBmp.rect, 0);
			drawButton(buttonBmp, width, height, topColor, bottomColor, borderColor);
		}
	}
}