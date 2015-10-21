package ui 
{
	import flash.geom.Rectangle;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	
	public class Checkbox extends Button 
	{
		protected var normalChecked:Graphic;
		protected var hoverChecked:Graphic;
		protected var downChecked:Graphic;
		
		public var checked:Boolean = false;
		
		public function Checkbox(x:Number=0, y:Number=0, text:String = "", callback:Function = null, params:Object = null, checked:Boolean = false) 
		{
			super(x, y, text, callback, params);
			
			this.checked = checked;
			
			normal = new Image(Assets.CHECKBOX, new Rectangle(0, 0, 38, 34));
			hover = new Image(Assets.CHECKBOX, new Rectangle(38, 0, 38, 34));
			down = new Image(Assets.CHECKBOX, new Rectangle(76, 0, 38, 34));
			
			normalChecked = new Image(Assets.CHECKBOX, new Rectangle(0, 34, 38, 34));
			hoverChecked = new Image(Assets.CHECKBOX, new Rectangle(38, 34, 38, 34));
			downChecked = new Image(Assets.CHECKBOX, new Rectangle(76, 34, 38, 34));
			
			label = new Text(text, 40, 0, { color: 0xFFFFFF, size: 16 } );
			label.y = (Image(normal).height - label.textHeight) * 0.5;
			
			graphic = normal;
			setHitboxTo(normal);
			
			width = label.x + label.textWidth;
		}
		
		override protected function click():void 
		{
			checked = !checked;
			
			if (callback != null)
			{
				if (params != null) callback(checked, params);
				else callback(checked);
			}
		}
		
		override protected function changeState(state:int = 0):void 
		{
			if (checked)
			{
				switch(state)
				{
					case NORMAL:
						graphic = normalChecked;
						break;
					case HOVER:
						graphic = hoverChecked;
						break;
					case DOWN:
						graphic = downChecked;
						break;
				}
			}
			else
			{
				super.changeState(state);
			}
		}
	}
}