package showcase 
{
	import blue.BlueButton;
	import blue.BlueCheckbox;
	import blue.BlueRadiobutton;
	import blue.BlueTextInput;
	import net.flashpunk.FP;
	import skins.ActiveButton;
	import skins.ActiveCheckbox;
	import skins.NeonButton;
	import ui.RadioButtonGroup;
	/**
	 * The blue skin done in the tutorial
	 * @author Abel Toy (Rolpege) [http://abeltoy.com/]
	 */
	public class BlueShowcase extends BaseShowcase 
	{
		public function BlueShowcase()
		{
			super(0xD9F2FF, "Blue Skin - The blue skin we created in the tutorial");
		}
		
		override public function begin():void 
		{
			super.begin();
			
			add(new BlueButton(30, 30, "Blue button!"));
			
			add(new BlueCheckbox(300, 30, "Check me!"));
			
			add(new BlueTextInput(30, 110, "Single"));
			add(new BlueTextInput(30, 160, "Multi line\nHi!", true, 200, 90));
			
			var rg:RadioButtonGroup = new RadioButtonGroup();
			add(new BlueRadiobutton(300, 110, rg, "Radio 1"));
			add(new BlueRadiobutton(300, 190, rg, "Radio 2"));
		}
	}

}