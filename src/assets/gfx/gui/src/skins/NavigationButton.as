package skins 
{
	import com.greensock.TweenLite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Stamp;
	import ui.Button;
	
	/**
	 * ...
	 * @author Abel Toy (Rolpege) [http://abeltoy.com/]
	 */
	public class NavigationButton extends Button 
	{
		protected var currentPage:Boolean = false;
		
		protected var button:Image;
		protected var label:Stamp;
		
		public function NavigationButton(x:Number = 0, y:Number = 0, text:String = "", currentPage:Boolean = false, width:Number=40, height:Number=40, callback:Function=null, params:Object=null) 
		{
			super(x, y, text, width, height, callback, params);
			
			this.currentPage = currentPage;
			
			drawButton();
			drawLabel(text);
			
			graphic = button;
		}
		
		protected function drawButton():void
		{
			//the buttons will fit nicely in the background. if they correspond
			//to the current page, they are a bit lighter than bg.
			//if they correspond to another page, they are a bit darker.
			
			g.beginFill(currentPage ? brightness(FP.screen.color, 0.2) : brightness(FP.screen.color, -0.2));
			g.drawRoundRect(0, 0, width, height, 20);
			g.endFill();
			
			//needs to be an image because I want to scale it
			button = drawImage(width, height);
			button.smooth = true;
			// center the button transform origin, but displace it to the original position.
			button.centerOrigin();
			button.x = button.width * 0.5;
			button.y = button.height * 0.5;
		}
		
		protected function drawLabel(text:String):void
		{
			var t:TextField = new TextField();
			
			var tf:TextFormat = new TextFormat("Comfortaa", 20, currentPage ? 0x000000 : 0xFFFFFF);
			tf.align = "center";
			
			t.defaultTextFormat = tf;
			t.width = width;
			t.height = height;
			t.embedFonts = true;
			t.text = text;
			
			label = drawStamp(width, t.textHeight, 0, 0, t);
			label.y = (height - t.textHeight) * 0.5 - 3;
		}
		
		override protected function changeState(state:int = 0):void 
		{
			//hovering will upscale the button a bit. clicking, downscale it a bit.
			if (state == lastState) return;
			
			var duration:Number = 0.25;
			if (lastState == DOWN) duration = 0.1;
			
			switch(state)
			{
				case NORMAL:
					TweenLite.to(button, duration, {scale: 1});
					break;
				case HOVER:
					TweenLite.to(button, duration, {scale: 1.2});
					break;
				case DOWN:
					TweenLite.to(button, 0.1, {scale: 0.95});
					break;
			}
			
			super.changeState(state);
		}
		
		override public function render():void 
		{
			super.render();
			
			renderGraphic(label);
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