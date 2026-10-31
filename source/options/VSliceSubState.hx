package options;
import options.Option;

class VSliceSubState extends BaseOptionsMenu {
    public function new() {
        title = Language.getPhrase("vslice_menu","V-Slice settings");
        rpcTitle = "V-Slice settings menu";

		var option:Option = new Option('Naughtyness',
			'If disabled, some "raunchy content" (such as swearing, etc.) will be disabled',
			'vsliceNaughtyness',
			BOOL);
		addOption(option);
		
		var option:Option = new Option('Smooth health bar',
			'If enabled makes health bar move more smoothly',
			'vsliceSmoothBar',
			BOOL,);
		addOption(option);

		// var option:Option = new Option('Strict combo break',
		// 	'If enabled makes health bar move more smoothly',
		// 	'vsliceSmoothBar',
		// 	BOOL,);
		// addOption(option);

		var option:Option = new Option('Special freeplay cards',
			'If disabled will force every character to use BF\'s card (including pico)',
			'vsliceSpecialCards',
			BOOL);
		addOption(option);
        super();
    }
}