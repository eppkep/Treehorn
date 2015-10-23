package showcase 
{
	import net.flashpunk.FP;
	import skins.PartyButton;
	/**
	 * Some party UI with particles, to showcase the use of emitters in UI.
	 * 
	 * @author Abel Toy (Rolpege) [http://abeltoy.com/]
	 */
	public class PartyShowcase extends BaseShowcase 
	{
		
		public function PartyShowcase() 
		{
			super(0xFFC677, "Party Skin - Using FlashPunk emitters");
		}
		
		override public function begin():void 
		{
			super.begin();
			
			add(new PartyButton((FP.width - 150) * 0.5, 50, "Yay!"));
			add(new PartyButton((FP.width - 250) * 0.5, 150, "PARTICLE PARTY!", 250, 100, null, 40));
		}
	}

}