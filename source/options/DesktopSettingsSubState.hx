package options;

import objects.Alphabet;
import options.Option;

class DesktopSettingsSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = Language.getPhrase('desktop_menu', 'Desktop');
		rpcTitle = 'Desktop Settings Menu'; //for Discord Rich Presence
		
		var option:Option = new Option('Widgets',
			'The Side bar on the Desktop',
			'pcWidgets',
			BOOL);
		addOption(option);

		var option:Option = new Option('Light Mode',
			'If you hate Dark Mode, Enjoy Light Mode\n(THIS DOES NOT AFECT THE GAME.)',
			'pcLight',
			BOOL);
		addOption(option);

		var option:Option = new Option('Strict Login',
			'It\'s where that you need to choose the right password.\n(I don\'t recommend to turn it on.)',
			'strictLogin',
			BOOL);
		addOption(option);

		var option:Option = new Option('Skip the Interface:',
			'What do you want to skip?',
			'skipLogin',
			STRING,
			['None', 'Login', 'Desktop', 'Both']);
		addOption(option);

		var option:Option = new Option('Wallpaper:',
			"What wallpaper?",
			'wallpaper',
			STRING,
			['Internal Reality', 'Sings it', 'Vibin Forever', 'Horizon', 'WinMario Sampler', 'WinXP', 'Win7', 'Win10', 'Win11']);
		addOption(option);

		super();
	}
}
