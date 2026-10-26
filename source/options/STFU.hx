package options;
import options.Option;

//PLEASE SHUT THE FLIP UP
// hey... please leave this alone... Thank You.
class STFU extends BaseOptionsMenu {
    public function new() {
        title = Language.getPhrase("private_menu","N/A");
        rpcTitle = "N/A";

		var option:Option = new Option('Use legacy bar',
			'Makes health bar and score text much simpler',
			'vsliceLegacyBar',
			BOOL,);
		addOption(option);

        var option:Option = new Option('Use results screen',
			'It\'s Not Functional Right Now.',
			'vsliceResults',
			BOOL);
		addOption(option);

        super();
    }
}