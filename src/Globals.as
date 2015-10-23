package  
{
	public class Globals
	{
		//public static var Placeholder:Class = new Class ;
		
				//public static var PARTICLE_EMITTER:ParticleController;
		public static var CURRENT_GUI:GUI;
		//public static var PLAYER:Player;
		public static var POINTS:Number;
		public static var LIVES:Number;
		public static var lastLocation:String;
		public static var currentLocation:String;
		
 
		public static const LAYER_GUI:int = 0;
		
		public static function reset():void
		{
			POINTS = 0;
			LIVES = 3;
			//PLAYER = new Player;
			CURRENT_GUI = new GUI;
			//PARTICLE_EMITTER = new ParticleController;
		}
	}
}