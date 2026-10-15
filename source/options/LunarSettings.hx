package options;

import objects.Alphabet;
import options.Option;

class LunarSettings extends BaseOptionsMenu
{
	public function new()
	{
		title = Language.getPhrase('lunar_menu', 'Lunar Engine Settings');
		rpcTitle = 'Lunar Engine Settings Menu'; //for Discord Rich Presence

		var option:Option = new Option('Combo Sprite Here',
			'If checked, shows a Combo Sprite',
			'showComboSprite',
			BOOL);
		addOption(option);

		var option:Option = new Option('Combo Number Here',
			'If unchecked, Combo Numbers will disappear',
			'showComboNumLune',
			BOOL);
		addOption(option);

		var option:Option = new Option('Combo Rating Here',
			'If unchecked, Combo Ratings (like Crazy, Cool, & Good) will disappear',
			'showRatingLune',
			BOOL);
		addOption(option);

		var option:Option = new Option('Color Icon Note:',
		    "What Type?\n(NOTE: THIS IS ONLY FOR RGB NOTES. NOT RECOMMENDED FOR NON-RGB NOTES)",
		    'shadedNote',
		    STRING,
			['OFF', 'ON', 'ON (legacy)']);
		addOption(option);

		var option:Option = new Option('Debug Keys',
			'If Disabled, you won\'t be able to go to the Chart or Character Editor in PlayState, & it disables pressing 7 
			in the Main Menu',
			'debugkeysLunar',
			BOOL);
		addOption(option);

		var option:Option = new Option('Show Key Viewer',
			'If checked, shows a key viewer displaying which keys are being pressed.',
			'showKeyViewer',
			BOOL);
		addOption(option);

		var option:Option = new Option('Key Viewer Color:',
			'Select the color for the key viewer buttons.',
			'keyViewerColor',
			STRING,
			['Gray', 'Red', 'Blue', 'Green', 'Purple', 'Orange', 'Pink', 'Cyan', 'White', 'Black']);
		addOption(option);
		option.onChange = onChangeKeyViewerColor;

		var option:Option = new Option('Color TimeBar Type:',
		    "What Type?",
		    'shadedTimeBar',
		    STRING,
			['Gradient', 'Dad Health Color', 'BF Health Color', 'GF Health Color', 'Note Hit', 'Kade', 'Psych']);
		addOption(option);

		var option:Option = new Option('Healthbar Type:',
			'What type of Healthbar Color Do you want, Mr. Boring?',
			'vsliceLegacyBar2',
			STRING,
			['Custom', 'RvB', 'Vanilla']);
		addOption(option);

		var option:Option = new Option('Opponent Note Glows',
			"If unchecked, opponent's note won't glow on hit.\n(just like Pre-FNF 2.8.0)",
			'opponentNote',
			BOOL);
		addOption(option);
		
		var option:Option = new Option('Miss on Oks (Bads) / Awfuls (Shits)',
			'Enabled it if you want to live the V-Slice Times.',
			'missonOksorCraps',
			BOOL);
		addOption(option);

		var option:Option = new Option('Special Anim. on Crazy, Cool, or Awful.',
			'It will play Alt Animations if you get Crazy/Cool\nAnd plays Miss Animation if you get Awful.\n(i don\'t recommend turn it on as Swearing Animations is using it.)',
			'swagPlayAnimation',
			BOOL);
		addOption(option);

		var option:Option = new Option('Hey Intro',
			'If checked, BF, GF, & Opponent automatically do the Hey! animation when the countdown says Go!',
			'heyIntro',
			BOOL);
		addOption(option);

		var option:Option = new Option('Icon Bounce:',
		    'Select the type of bounce icon you prefer. NOTE: Scripts using this setting may break with non-default values. It is recommended to leave it as Default.',
			'iconBounceType',
			STRING,
			['Default', 'D&B', 'Old', 'NF']);
		addOption(option);

		var option:Option = new Option('ScoreTxt Info:',
		    'No, not Custom HUD. Custom Score Text Info.',
			'winmarioCustomscore',
			STRING,
			['WinMario', 'WinMario (Legacy)', 'Pico Engine', 'Green Engine', 'Psych Plus', 'Mic\'d Up', 'Codename', 'Yoshi', 'Psych', 'Kade', 'Vanilla', 'Forever', 'OS']);
		addOption(option);

		 var option:Option = new Option('Judgement Counter',
            'Show the judgement counter during gameplay.',
            'judgementCounter',
            BOOL);
        addOption(option);

		var option:Option = new Option('Icon Colored Strums',
			"If checked, The strums will changed its colors based off Opponents & Players.",
			'iconColoredstrum',
			BOOL);
		addOption(option);

		var option:Option = new Option('Song Watermarks',
			"The Song Watermark that appears in the Top Corner of the screen.",
			'watermarkSong',
			STRING,
			['WinMario', 'WinMario (Alpha)', 'Usaul', 'Kade', 'SongName Only', 'Difficulty Name', 'Disabled']);
		addOption(option);

		var option:Option = new Option('Break Timer',
			"If unchecked, The break timer will be fully disabled.",
			'timerBreak',
			BOOL);
		addOption(option);

		var option:Option = new Option('MS Offset Popup',
			"If unchecked, MS Offset Popup from bottom left corner will be fully off.",
			'popupMS',
			BOOL);
		addOption(option);

		var option:Option = new Option('Health Display',
			"If unchecked, The health display on right bottom corner will be disabled.",
			'healTxt',
			BOOL);
		addOption(option);

		var option:Option = new Option('Note Combo Pop-Up',
			"If unchecked, The Note Pop-Up will not appear occasionaly.",
			'comboNotehx',
			BOOL);
		addOption(option);

		var option:Option = new Option('Video Intro:',
			"What Style do you like for the Video\n(NOTE: It was named after the WNR Startups made by other people)",
			'introvideoCutscene',
			STRING,
			['WinZinc', 'Win14', 'Win16', 'Win18', 'WinVista', 'Disabled']);
		addOption(option);

		#if desktop
		var option:Option = new Option('Access Songs through Soundtrack State',
			"Well... OST State is based of Psych 1.0.4 Freeplay States.\nBut there are chances it will break the Game.",
			'playSongOST',
			BOOL);
		addOption(option);
		#end

		var option:Option = new Option('Time Format:',
			"12 Hour is default.\n(only use for results screen)",
			'clock',
			STRING,
			['12 Hour', '24 Hour']);
		addOption(option);

		var option:Option = new Option('Show Watermark',
			'If checked, shows the watermark on screen.',
			'showWatermark',
			BOOL);
		addOption(option);
		option.onChange = onChangeWatermark;

		super();
	}

	function onChangeKeyViewerColor()
	{
		// Si estamos en PlayState, actualizar el color del keyViewer
		if(PlayState.instance != null && PlayState.instance.keyViewer != null)
		{
			PlayState.instance.keyViewer.updateKeyColors();
		}
	}

	function onChangeWatermark()
	{
		if(Main.watermarkSprite != null)
			Main.watermarkSprite.visible = ClientPrefs.data.showWatermark;
		if(Main.watermark != null)
			Main.watermark.visible = ClientPrefs.data.showWatermark;
	}

}
