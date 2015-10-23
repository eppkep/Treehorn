package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display3D.textures.RectangleTexture;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.filters.GradientBevelFilter;	
	import flash.geom.Rectangle;
	import flash.net.FileFilter;
	import net.flashpunk.Graphic;
	
	//import punk.fx.*;
	//import punk.fx.effects.*;
	//import punk.fx.graphics.*;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import flash.display.Sprite;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.graphics.Text;
	import ui.Button;
	
	import net.flashpunk.utils.Input;
	import flash.geom.Point;
 
	public class GUI extends Entity 
	{
		
		// Editted class from:
		// http://ursagames.com/shmuptutorial/shmup-tutorial-7-lives-and-scoring/
 
		public var pointsText:Text;
		public var lives:Vector.<Spritemap> = new Vector.<Spritemap>;
		public var clicked:Boolean = false;
		public var markColor:uint = 0xcca47f48;
		public var blackColor:uint = 0xff000000;
		public var whiteColor:uint = 0xffffffff;
		
		public var locationText:Text;
		public var tempBitmap:BitmapData;
		public static var locationImage:Image;
		protected  static var graphicList:Graphiclist = new Graphiclist();
		
		// Offsets used when placing the money/time GUI elements:
		public static var paddingRight:Number = 2;
		public static var paddingTop:Number = 7;
		public static var margins:Number = 2;
		
		public function GUI() 
		{
			graphic = makeGraphicList();
			//gp = graphic;
			//updateGraphicList();
			layer = Globals.LAYER_GUI;
		}
		
		public function updateScore():void
		{
			//pointsText.text = "Points: " + Globals.POINTS;
			//locationText.text = testZone.testInputText.text;
		}
		
		public function playerDeath():void
		{
			if(Globals.LIVES >= 0 && Globals.LIVES < lives.length) lives[Globals.LIVES].play("die");
		}
		
		public function redrawGui():void {
				graphic = makeGraphicList();
		}
		
		public function makeGraphicList():Graphiclist {
			// graphicList - Contains multiple graphics of various types
			// Since this GUI class extends Entity, we append all our GUI pics to the graphicList, then set the entity graphic to it
			//var graphicList:Graphiclist = new Graphiclist();
			
			graphicList = new Graphiclist();
			
			var guiBackground:Image = new Image(new BitmapData(560, 20, false, 0x000000));
			guiBackground.scrollX = 0;
			guiBackground.scrollY = 0;
			guiBackground.alpha = 0.5;
			graphicList.add(guiBackground);
			
			// Dialog box in the bottom center
			var dialogBox:Image = new Image(new BitmapData(942, 206, false, markColor));
			dialogBox.scrollX = 0;
			dialogBox.scrollY = 0;
			dialogBox.alpha = 0.25;
			dialogBox.x = 170;
			dialogBox.y = 513;
			graphicList.add(dialogBox);
			
			// Define the textboxes first so we can grab their widths when we place their background boxes:
			var timeText:Text = newText("12:30 PM", 0, paddingTop);
			timeText.x = FP.width - timeText.width - paddingRight;
			
			var moneyIcon:Image = new Image(Assets.iconMoney);
			moneyIcon.scrollX = 0;
			moneyIcon.scrollY = 0;
			moneyIcon.x = timeText.x - moneyIcon.width - margins;
			moneyIcon.y = paddingTop;
			graphicList.add(moneyIcon);
			
			var moneyText:Text = newText("9,999,999,999", 0, paddingTop);// , { size: 18, color: blackColor, wordWrap: true, width:"auto", height: 29, align: "left", font:"comicSansBold" } );
			moneyText.x = moneyIcon.x - moneyText.width - margins;
			
			locationText = newText(Globals.currentLocation, 0, 0);// { size: 18, color: blackColor, wordWrap: false, width:"auto", height: 29, align: "left", font:"comicSansBold" } );
			locationText.x = FP.width - locationText.width - paddingRight;
			locationText.y = timeText.y + timeText.height + margins;
			
			var biomeText:Text = newText("Grasslands", 0, 0);// { size: 18, color: blackColor, wordWrap: true, width:"auto", height: 29, align: "left", font:"comicSansBold" } );
			biomeText.x = FP.width - biomeText.width - paddingRight;
			biomeText.y = locationText.y + locationText.height + margins;
			
			// Backgrounds:
			var moneyTextBg:BitmapData = new BitmapData(moneyText.width, moneyText.height, true, blackColor);
			moneyTextBg.fillRect(new Rectangle(1, 1, moneyTextBg.width - 2, moneyTextBg.height - 2), markColor);
			var tempBg:Image = new Image(moneyTextBg);
			tempBg.x = moneyText.x;
			tempBg.y = moneyText.y;
			graphicList.add(tempBg);
			
			var timeTextBg:BitmapData = new BitmapData(timeText.width, timeText.height, true, blackColor);
			timeTextBg.fillRect(new Rectangle(1, 1, timeTextBg.width - 2, timeTextBg.height - 2), markColor);
			tempBg = new Image(timeTextBg);
			tempBg.x = timeText.x;
			tempBg.y = timeText.y;
			graphicList.add(tempBg);
			
			tempBitmap = new BitmapData(locationText.width, locationText.height, true, blackColor);
			tempBitmap.fillRect(new Rectangle(1, 1, tempBitmap.width - 2, tempBitmap.height - 2), markColor);
			locationImage = new Image(tempBitmap);
			locationImage.x = locationText.x;
			locationImage.y = locationText.y;
			graphicList.add(locationImage);
			
			tempBitmap = new BitmapData(biomeText.width, biomeText.height, true, blackColor);
			tempBitmap.fillRect(new Rectangle(1, 1, tempBitmap.width - 2, tempBitmap.height - 2), markColor);
			tempBg = new Image(tempBitmap);
			tempBg.x = biomeText.x;
			tempBg.y = biomeText.y;
			graphicList.add(tempBg);
			
			// Add text last so it renders over the background boxes:
			graphicList.add(timeText);
			graphicList.add(moneyText);
			graphicList.add(locationText);
			graphicList.add(biomeText);
			
			pointsText = new Text("Points: " + Globals.POINTS);
			pointsText.width = 200;
			pointsText.x = FP.width - 200;
			pointsText.y = 2;
			pointsText.scrollX = 0;
			pointsText.scrollY = 0;
			graphicList.add(pointsText);
			
			// Here's when I tried to put clickable buttons in the GUI layer 
			// Icons in the bottom left: (Inventory, Journal, Map, Turns/Hourglass)
			//var inventoryButton:Button = new Button(0, FP.height - 32, "Inv.", Callbacks.inventoryCallback);
			/*var inventoryImage:Image = new Image(Assets.iconInventory);
			inventoryImage.x = 0;
			inventoryImage.y = FP.height - 40;
			graphicList.add(inventoryImage);
			
			setHitbox(1280, 720, 0, 0);*/
			
			for (var i:uint = 0; i < 3; i++) {
				var life:Spritemap = new Spritemap(Assets.iconInventory, 16, 16);
				life.add("idle", [0]);
				life.add("die", [1, 2, 3 , 4], 6, false);
				life.play("idle");
				life.scrollX = 0;
				life.scrollY = 0;
				life.y = 2;
				life.x = 2 + i * 16;
				lives.push(life);
				graphicList.add(life);
			}
			
			return graphicList;
		}
		
		public static function drawBox(givenImage:Image,givenText:Text):void {
			
			/*givenText.x = FP.width - givenText.width - margins;
			
			trace(givenImage.width);
			graphicList.remove(givenImage);
			var trashBitmap:BitmapData = new BitmapData(givenText.width + 100, givenText.height, true, blackColor);
			trashBitmap.fillRect(new Rectangle(1, 1, trashBitmap.width - 2, trashBitmap.height - 2), markColor);
			givenImage = new Image(trashBitmap);
			givenImage.x = FP.width - givenText.width - margins;
			givenImage.y = givenText.y;
			
			graphicList.remove(givenText);
			graphicList.add(givenImage);
			graphicList.add(givenText);*/
			
			//graphicList.update();
			//graphicList.remove(givenText);
			//givenText = new Text("Test", 0,0, { size: 18, color: blackColor, wordWrap: false, width:"auto", height: 29, align: "left", font:"comicSansBold"});
			//graphicList.add(givenText);
		}
		
		public function newText(givenText:String=null, givenX:Number=0, givenY:Number=0):Text {
			return new Text(givenText, givenX, givenY, { size: 18, height: 29, color: blackColor, wordWrap: false, width:"auto", align: "left", font:"comicSansBold", scrollX: 0, scrollY: 0} );
		}
	}
 
}