package ui 
{
	import flash.events.KeyboardEvent;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class TextInput extends Entity 
	{
		protected var _text:String = "";
		protected var textGraphic:Text;
		
		protected var multiline:Boolean = false;
		
		public static var focus:TextInput;
		
		public function TextInput(x:Number=0, y:Number=0, text:String = "", multiline:Boolean = false) 
		{
			super(x, y);
			
			this.multiline = multiline;
			
			textGraphic = new Text("", 0, 0, { size: 16, color: 0xFFFFFF } );
			this.text = text;
			graphic = textGraphic;
			
			type = "uiTextInput";
		}
		
		override public function added():void 
		{
			super.added();
			
			FP.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		protected function onKeyDown(e:KeyboardEvent):void
		{
			if (world != FP.world) return;
			if (TextInput.focus != this) return;
			
			if (e.keyCode == Key.BACKSPACE) text = _text.substr(0, _text.length - 1);
			else if (e.keyCode == Key.ENTER && multiline) text += "\n";
		}
		
		override public function removed():void 
		{
			super.removed();
			
			FP.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (TextInput.focus == this) textGraphic.color = 0xC4DCF4;
			else textGraphic.color = 0xFFFFFF;
			
			if (Input.mousePressed)
			{
				if (collidePoint(x, y, world.mouseX, world.mouseY))
				{
					TextInput.focus = this;
					Input.keyString = "";
				}
				else if (!world.collidePoint("uiTextInput", world.mouseX, world.mouseY)) TextInput.focus = null;
			}
			
			if (TextInput.focus == this && Input.keyString != "")
			{
				text += Input.keyString;
				Input.keyString = "";
			}
		}
		
		public function get text():String 
		{
			return _text;
		}
		
		public function set text(value:String):void 
		{
			_text = value;
			textGraphic.text = value;
			
			setHitbox(textGraphic.textWidth, textGraphic.textHeight);
		}
	}
}