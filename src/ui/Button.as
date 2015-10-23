package ui 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	
	import flash.geom.Rectangle;
	import net.flashpunk.graphics.Image;
	
	public class Button extends Entity 
	{
		protected const NORMAL:int = 0;
		protected const HOVER:int = 1;
		protected const DOWN:int = 2;
		
		protected var normal:Graphic;
		protected var hover:Graphic;
		protected var down:Graphic;
		
		public var clicked:Boolean = false;
		
		protected var label:Text;
		public var callback:Function;
		public var params:Object;
		
		public function Button(x:Number=0, y:Number=0, text:String = "", callback:Function = null, params:Object = null) 
		{
			// Modified version of Abel Toy's FPGUI - swabs
			super(x, y);
			
			this.callback = callback;
			this.params = params;
			
			normal = new Image(Assets.RADIOBUTTON, new Rectangle(0, 0, 32, 32));
			hover = new Image(Assets.RADIOBUTTON, new Rectangle(32, 0, 32, 32));
			down = new Image(Assets.RADIOBUTTON, new Rectangle(64, 0, 32, 32));
			
			// Draw the button text 32 + 5 pixels of padding to the right of the origin
			// as of now there's a little bit of extra whitespace above the text since i haven't set the height option - swabs
			label = new Text(text, 37, 0, { size: 22, color: 0xFFFFFF, wordWrap: true, width:"auto", align: "left", font:"comicSansBold", resizable:true} );
			
			// Default state
			graphic = normal;
			
			// Just hard coded the hitbox size with a dynamic width variable - swabs
			setHitbox(label.width + 32, 32, 0, 0);
			// Used to be this: (only hits the sprite)
			//setHitboxTo(normal);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (collidePoint(x, y, world.mouseX, world.mouseY))
			{	
				if (Input.mousePressed) clicked = true;
				
				if (clicked) changeState(DOWN);
				else changeState(HOVER);
				
				if (clicked && Input.mouseReleased) click();
			}
			else
			{
				if (clicked) changeState(HOVER);
				else changeState(NORMAL);
			}
			
			if (Input.mouseReleased) clicked = false;
		}
		
		protected function changeState(state:int = 0):void
		{
			switch(state)
			{
				case NORMAL:
					graphic = normal;
					break;
				case HOVER:
					graphic = hover;
					break;
				case DOWN:
					graphic = down;
					break;
			}
		}
		
		override public function render():void 
		{
			super.render();
			
			renderGraphic(label);
		}
		
		protected function renderGraphic(graphic:Graphic):void
		{
			if (graphic && graphic.visible)
			{
				if (graphic.relative)
				{
					_point.x = x;
					_point.y = y;
				}
				else _point.x = _point.y = 0;
				_camera.x = world ? world.camera.x : FP.camera.x;
				_camera.y = world ? world.camera.y : FP.camera.y;
				graphic.render(renderTarget ? renderTarget : FP.buffer, _point, _camera);
			}
		}
		protected var _point:Point = FP.point;
		protected var _camera:Point = FP.point2;
		
		//[...]
		
		protected function click():void
		{
			if (callback != null)
			{
				if (params != null) callback(params);
				else callback();
			}
		}
	}
}