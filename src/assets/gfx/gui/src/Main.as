package 
{
	import com.greensock.plugins.HexColorsPlugin;
	import com.greensock.plugins.TweenPlugin;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import showcase.ActiveShowcase;
	import showcase.BlueShowcase;
	import showcase.NeonShowcase;
	import showcase.PartyShowcase;
	
	public class Main extends Engine
	{
		[Embed(source = "../assets/fonts/Comfortaa-Bold.ttf", fontFamily = "Comfortaa", embedAsCFF = "false")] private var COMFORTAA:Class;
		[Embed(source = "../assets/fonts/NEUROPOL.TTF", fontFamily = "Neon", embedAsCFF = "false")] private var NEON:Class;
		[Embed(source = "../assets/fonts/Bitter-Bold.ttf", fontFamily = "Bitter", embedAsCFF = "false")] private var BITTER:Class;
		
		public function Main():void 
		{
			super(550, 400);
		}
		
		override public function init():void 
		{
			super.init();
			
			TweenPlugin.activate([HexColorsPlugin]);
			
			FP.world = new BlueShowcase();
		}
	}
}