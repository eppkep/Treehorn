package showcase 
{
	import skins.NeonButton;
	import skins.NeonCheckbox;
	import skins.NeonRadioButton;
	import ui.RadioButtonGroup;
	/**
	 * 50s neon signs style UI. Flickers when changing state.
	 * 
	 * @author Abel Toy (Rolpege) [http://abeltoy.com/]
	 */
	public class NeonShowcase extends BaseShowcase 
	{
		
		public function NeonShowcase() 
		{
			super(0x333333, "Neon UI - Flickering + Filters");
		}
		
		override public function begin():void 
		{
			super.begin();
			
			//add ALL the neon components
			add(new NeonButton(30, 30, "Argon & Neon", 220, 50));
			
			add(new NeonCheckbox(280, 30, "50's approved", 250));
			
			var rg:RadioButtonGroup = new RadioButtonGroup();
			add(new NeonRadioButton(150, 150, rg, "Xenon & Krypton", 290, 50, 0xFFFFFF, 0xB990F0, 0xFFFFFF, 0xF6C7CD, null, true));
			add(new NeonRadioButton(150, 220, rg, "Helium & Argon", 260, 50, 0xFEFEE4, 0xF7675E, 0x6AFEFE, 0x178FFF));
		}
	}

}