package 
{
    public class Assets 
    {
        [Embed(source = "./assets/gfx/gui/imageTitle.png")] public static const titleImage:Class;
		
		//GUI Stuff
		[Embed(source = "./assets/gfx/gui/iconInventory.png")] public static const iconInventory:Class;
		[Embed(source = "./assets/gfx/gui/iconJournal.png")] public static const iconJournal:Class;
		[Embed(source = "./assets/gfx/gui/iconMap.png")] public static const iconMap:Class;
		[Embed(source = "./assets/gfx/gui/iconMoney.png")] public static const iconMoney:Class;
		[Embed(source = "./assets/gfx/gui/iconSave.png")] public static const iconSave:Class;
		[Embed(source = "./assets/gfx/gui/iconSettings.png")] public static const iconSettings:Class;
		[Embed(source = "./assets/gfx/gui/iconSound.png")] public static const iconSound:Class;
		[Embed(source = "./assets/gfx/gui/iconTurns.png")] public static const iconTurns:Class;
		[Embed(source = "./assets/gfx/gui/iconMusic.png")] public static const iconMusic:Class;
		[Embed(source = "./assets/gfx/gui/button.png")] public static const BUTTON:Class;
		[Embed(source = "./assets/gfx/gui/button_down.png")] public static const BUTTON_DOWN:Class;
		[Embed(source = "./assets/gfx/gui/button_hover.png")]  public static const BUTTON_HOVER:Class;
		[Embed(source = "./assets/gfx/gui/checkbox.png")] public static const CHECKBOX:Class;
		[Embed(source = "./assets/gfx/gui/radiobutton.png")] public static const RADIOBUTTON:Class;
		
		// Fonts
		[Embed(source = './assets/fonts/comicbd.ttf', embedAsCFF="false", fontFamily = 'comicSansBold')] private const comicSansBold:Class;
    }
}