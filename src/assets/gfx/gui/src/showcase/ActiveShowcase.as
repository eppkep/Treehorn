package showcase 
{
	import skins.ActiveButton;
	import skins.ActiveCheckbox;
	import skins.ActiveRadioButton;
	import skins.ActiveTextInput;
	import ui.RadioButtonGroup;
	import ui.TextInput;
	/**
	 * .Show case for the ActiveTuts+ inspired buttons.
	 * 
	 * @author Abel Toy (Rolpege) [http://abeltoy.com/]
	 */
	public class ActiveShowcase extends BaseShowcase 
	{
		
		public function ActiveShowcase() 
		{
			super(0xF2F2F2, "ActiveTuts+ Skin - Inspired by this website!");
			
		}
		
		override public function begin():void 
		{
			super.begin();
			
			//add ALL the active components
			add(new ActiveButton(30, 30, "ActiveTuts+"));
			
			add(new ActiveCheckbox(250, 30, "Check me!", 200));
			
			var rg:RadioButtonGroup = new RadioButtonGroup();
			add(new ActiveRadioButton(30, 120, rg, "ActiveTuts+", 200, 50, null, true));
			add(new ActiveRadioButton(30, 180, rg, "NetTuts+", 200));
			add(new ActiveRadioButton(30, 240, rg, "MobileTuts+", 200));
			
			add(new ActiveTextInput(250, 120, "Single Line", false, 200));
			
			add(new ActiveTextInput(250, 160, "Multiline", true, 240, 150));
		}
	}

}