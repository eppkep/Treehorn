package skins 
{
	import flash.display.BitmapData;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Stamp;
	import ui.TextInput;
	
	/**
	 * The same process as BlueTextInput, but with different bg, font and stuff.
	 * 
	 * @author Abel Toy (Rolpege) [http://abeltoy.com/]
	 */
	public class ActiveTextInput extends TextInput 
	{
		protected var t:TextField;
		protected var tf:TextFormat;
		
		protected var textBitmap:BitmapData;
		
		protected var bgBmp:BitmapData;
		protected var bgStamp:Stamp;
		
		protected var cursor:Stamp;
		
		public function ActiveTextInput(x:Number=0, y:Number=0, text:String="", multiline:Boolean=false, width:Number=150, height:Number=30) 
		{
			super(x, y, text, multiline, width, height);
			
			textBitmap = new BitmapData(width, height, true, 0);
			
			createTextfield(text);
			
			bgBmp = new BitmapData(width + 20, height + 20, true, 0);
			bgStamp = new Stamp(bgBmp, -10, -10);
			
			drawBg(width, height);
			
			cursor = new Stamp(new BitmapData(2, 15, false, 0x000000));
			cursor.visible = false;
			moveCursor();
			
			graphic = new Stamp(textBitmap, 5, 5);
		}
		
		protected function drawBg(width:Number, height:Number):void
		{
			g.clear();
			var gradientMatrix:Matrix = new Matrix();
			gradientMatrix.createGradientBox(width, height, 270 * FP.RAD, 0, 0);
			g.beginFill(0xFDFDFD);
			g.lineStyle(0, 0xD6D6D6);
			g.drawRect(0, 0, width, height);
			g.endFill();
			
			sprite.filters = [];
			if (focus == this) sprite.filters = [new GlowFilter(0xD85D09, 1, 8, 8, 1.5, 3)];
			
			_m.tx = 10;
			_m.ty = 10;
			bgBmp.draw(sprite, _m);
		}
		private var _m:Matrix = new Matrix;
		
		protected function createTextfield(text:String):void
		{
			tf = new TextFormat("Arial", 14, 0x000000);
			
			t = new TextField();
			t.defaultTextFormat = tf;
			t.width = width - 10;
			t.height = height;
			t.text = text;
			t.multiline = this.multiline;
			t.wordWrap = this.multiline;
			
			textBitmap.draw(t);
		}
		
		override protected function onFocus(focused:Boolean):void 
		{
			super.onFocus(focused);
			
			updateGraphic();
			
			cursor.visible = focused;
		}
		
		override public function render():void 
		{
			renderGraphic(bgStamp);
			
			super.render();
			
			renderGraphic(cursor);
		}
		
		override protected function changeText():void 
		{
			super.changeText();
			
			if (t)
			{
				t.text = _text;
				updateTextfield();
			}
		}
		
		protected function updateGraphic():void
		{
			bgBmp.fillRect(bgBmp.rect, 0);
			drawBg(width, height);
		}
		
		protected function updateTextfield():void
		{
			textBitmap.fillRect(textBitmap.rect, 0);
			textBitmap.draw(t);
			
			moveCursor();
		}
		
		protected function moveCursor():void
		{
			var lastChar:TextLineMetrics = t.getLineMetrics(t.numLines - 1);
			cursor.x = lastChar.width + 7;
			cursor.y = lastChar.height * (t.numLines - 1) + 8;
		}
	}

}