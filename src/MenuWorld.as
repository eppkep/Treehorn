package
{
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import ui.Button;
	import net.flashpunk.graphics.Text;
	
	public class MenuWorld extends World
	{
		
		public function MenuWorld()
		{
			super();
		}
		
		override public function begin():void
		{
			super.begin();
			trace("inside the gameworld. Menu: " + FP.halfWidth + " image: " + Assets.titleImage.width);
			
			// Render 2 textboxes, subtitle first since I'd like the main title to be drawn over it
			var subtitle:Text = new Text("Fetisch Sim-U-L8R", 0, 76, { size: 32, color: 0xDEADBEEF, wordWrap: true, width:FP.width, align: "left", font:"comicSansBold" } );
			addGraphic(subtitle);
			subtitle.x = FP.halfWidth - (subtitle.textWidth / 2) - 69;
			
			// Main title
			var title:Text = new Text("Tails of Magana", 0, 0, { size: 72, color: 0x000EFF, wordWrap: true, width:FP.width, align: "left", font:"comicSansBold" } );
			addGraphic(title);
			title.x = FP.halfWidth - (title.textWidth / 2);
			
			// A sample of how a button can work. Callbacks are important
			add(new Button(title.x + 69 / 2, subtitle.y + 69, "New Game", Callbacks.newGame));
			add(new Button(title.x + 69 / 2, subtitle.y + 132, "Test Zone", Callbacks.testZoneButton));
		}
		
	}
}
