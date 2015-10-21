package  
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
 
	public class GUI extends Entity 
	{
 
		private var pointsText:Text;
		private var lives:Vector.<Spritemap> = new Vector.<Spritemap>;
 
		public function GUI() 
		{
 
			var glist:Graphiclist = new Graphiclist();
 
			var guiBackground:Image = new Image(new BitmapData(560, 20, false, 0x000000));
			guiBackground.scrollX = 0;
			guiBackground.scrollY = 0;
			guiBackground.alpha = 0.5;
			glist.add(guiBackground);
 
			pointsText = new Text("Points: 0");
			pointsText.width = 200;
			pointsText.x = FP.width - 200;
			pointsText.y = 2;
			pointsText.scrollX = 0;
			pointsText.scrollY = 0;
			glist.add(pointsText);
 
 
			for (var i:uint = 0; i < 3; i++) {
				var life:Spritemap = new Spritemap(Assets.GRAPHIC_LIVES, 16, 16);
				life.add("idle", [0]);
				life.add("die", [1, 2, 3 , 4], 6, false);
				life.play("idle");
				life.scrollX = 0;
				life.scrollY = 0;
				life.y = 2;
				life.x = 2 + i * 16;
				lives.push(life);
				glist.add(life);
			}
 
			graphic = glist;
			layer = GC.LAYER_GUI;
		}
 
		public function updateScore():void
		{
			pointsText.text = "Points: " + GV.POINTS;
		}
 
		public function playerDeath():void
		{
			if(GV.LIVES >= 0 && GV.LIVES < lives.length) lives[GV.LIVES].play("die");
		}
 
	}
 
}