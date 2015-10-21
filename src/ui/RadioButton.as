package ui 
{
	import flash.geom.Rectangle;
	import net.flashpunk.graphics.Image;
	
	public class RadioButton extends Checkbox 
	{
		internal var group:RadioButtonGroup;
		
		public function RadioButton(x:Number=0, y:Number=0, group:RadioButtonGroup = null, text:String = "", params:Object = null, checked:Boolean = false) 
		{
			super(x, y, text, null, params, checked);
			
			if (group) group.add(this);
			
			normal = new Image(Assets.RADIOBUTTON, new Rectangle(0, 0, 39, 44));
			hover = new Image(Assets.RADIOBUTTON, new Rectangle(39, 0, 39, 44));
			down = new Image(Assets.RADIOBUTTON, new Rectangle(78, 0, 39, 44));
			
			normalChecked = new Image(Assets.RADIOBUTTON, new Rectangle(0, 44, 39, 44));
			hoverChecked = new Image(Assets.RADIOBUTTON, new Rectangle(39, 44, 39, 44));
			downChecked = new Image(Assets.RADIOBUTTON, new Rectangle(78, 44, 39, 44));
			
			label.y = (Image(normal).height - label.textHeight) * 0.5;
			
			graphic = normal;
			setHitboxTo(normal);
			
			width = label.x + label.textWidth;
		}
		
		override protected function click():void 
		{
			group.click(this, params);
		}
		
		override public function removed():void 
		{
			super.removed();
			
			group.remove(this);
		}
	}
}