package showcase 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.MouseCursor;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	import skins.NavigationButton;
	
	/**
	 * Used as a base for all the showcase slides. Provides the page change mechanism and the navigation buttons.
	 * 
	 * @author Abel Toy (Rolpege) [http://abeltoy.com/]
	 */
	public class BaseShowcase extends World 
	{
		protected var bgColor:uint;
		protected var title:String;
		
		private static var currentPage:int;
		private var showcases:Vector.<BaseShowcase>;
		
		protected var label:Stamp;
		
		public function BaseShowcase(bgColor:uint, title:String) 
		{
			this.bgColor = bgColor;
			this.title = title;
		}
		
		override public function begin():void 
		{
			//list of the showcase slides
			showcases = new Vector.<BaseShowcase>;
			showcases.push(new BlueShowcase());
			showcases.push(new ActiveShowcase());
			showcases.push(new NeonShowcase());
			showcases.push(new PartyShowcase());
			
			super.begin();
			
			FP.screen.color = bgColor;
			
			drawLabel(title);
			label.x += 30;
			label.y += 320;
			addGraphic(label);
			
			//navigation buttons creation
			add(new NavigationButton(30, 350, "< Prev", false, 80, 40, changePage, currentPage - 1));
			
			var navLength:int = 40 * showcases.length + 10 * (showcases.length - 1);
			
			for (var i:int = 0; i < showcases.length; ++i)
			{
				add(new NavigationButton((FP.width - navLength) * 0.5 + 50 * i, 350, (i + 1).toString(), currentPage == i, 40, 40, changePage, i));
			}
			
			add(new NavigationButton(440, 350, "Next >", false, 80, 40, changePage, currentPage + 1));
		}
		
		protected function drawLabel(text:String):void
		{
			//render a textfield with a filter
			var t:TextField = new TextField();
			
			var tf:TextFormat = new TextFormat("Comfortaa", 20, 0xFFFFFF);
			
			t.defaultTextFormat = tf;
			t.width = FP.width;
			t.height = 30;
			t.embedFonts = true;
			t.text = text;
			
			t.filters = [new GlowFilter(brightness(FP.screen.color, -0.5), 0.6, 2, 2, 6, 2)];
			
			var bd:BitmapData = new BitmapData(t.textWidth + 10, t.textHeight + 10, true, 0);
			var m:Matrix = new Matrix();
			m.tx = 5;
			m.ty = 5;
			bd.draw(t, m);
			
			label = new Stamp(bd);
			label.x = -5;
			label.y = -5;
		}
		
		protected function changePage(params:Object):void
		{
			currentPage = int(params);
			if (currentPage < 0) currentPage = showcases.length - 1;
			if (currentPage > showcases.length - 1) currentPage = 0;
			
			FP.world = showcases[currentPage];
		}
		
		//the update method each world should have so the mouse cursor adapts correctly
		override public function update():void 
		{
			Input.mouseCursor = MouseCursor.AUTO;
			
			super.update();
		}
		
		//this method changes the brightness of an hex color by ratio.
		//positive number makes it lighter, negative makes it darker.
		protected function brightness(color:uint, ratio:Number):uint
		{
			var r:int = color >> 16 & 0xFF;
			var g:int = color >> 8 & 0xFF;
			var b:int = color & 0xFF;
			
			r = brightnessBit(r, ratio);
			g = brightnessBit(g, ratio);
			b = brightnessBit(b, ratio);
			
			return FP.getColorRGB(r, g, b);
		}
		//helper of brightness()
		private function brightnessBit(bit:int, ratio:Number):int
		{
			return Math.round(Math.min(Math.max(0, bit + (bit * ratio)), 255));
		}
	}

}