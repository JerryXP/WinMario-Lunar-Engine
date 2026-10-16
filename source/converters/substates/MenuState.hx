package converters.substates;

import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxSprite;
import mikolka.vslice.ui.MainMenuState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import mikolka.compatibility.VsliceOptions;

class MenuState extends MusicBeatState {
    private var vslice_funkin:FlxButton;
    private var codename_engine:FlxButton;
	private var nightmare_vision:FlxButton;
    private var non_funkin:FlxButton;
	private var exitButton:FlxButton;
	private var okButton:FlxButton;

	var bg:FlxSprite;
	var cinematic:FlxSprite;
	var infoNMVunix:FlxSprite;
	var infoNonFunkin:FlxSprite;

    override public function create():Void {
        super.create();
        
        bg = new FlxSprite().loadGraphic(Paths.image('converter/convertBG'));
		bg.color = 0xFF808080;
		bg.screenCenter();
        add(bg);

		if(!VsliceOptions.LOW_QUALITY) {
			var grid:FlxBackdrop = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, 0x33FFFFFF, 0x0));
			grid.velocity.set(40, 40);
			grid.alpha = 0;
			FlxTween.tween(grid, {alpha: 1}, 0.5, {ease: FlxEase.quadOut});
			add(grid);
		}

		cinematic = new FlxSprite().loadGraphic(Paths.image('converter/thingy'));
		cinematic.screenCenter();
        add(cinematic);

        vslice_funkin = new FlxButton(50, 230, "", vanillaMenu);
        vslice_funkin.loadGraphic(Paths.image('converter/engine_icons/v-slice'));
        add(vslice_funkin);
        add(vslice_funkin); 

        codename_engine = new FlxButton(350, 230, "", codenameMenu);
        codename_engine.loadGraphic(Paths.image('converter/engine_icons/codename'));
        add(codename_engine);
        add(codename_engine);

		nightmare_vision = new FlxButton(650, 230, "", nightmareMenu);
        nightmare_vision.loadGraphic(Paths.image(#if windows 'converter/engine_icons/nightmare_vision' #else 'converter/engine_icons/nightmare_vision_unavailable' #end));
        add(nightmare_vision);
        add(nightmare_vision); 

		non_funkin = new FlxButton(950, 230, "", notFunkinMenu);
        non_funkin.loadGraphic(Paths.image('converter/engine_icons/non-funkin'));
        add(non_funkin);
        add(non_funkin);

        exitButton = new FlxButton(575, 611, "", exit);
        exitButton.loadGraphic(Paths.image('converter/exit_icon'));
        add(exitButton);
        add(exitButton);
    }

    function vanillaMenu():Void {
		MusicBeatState.switchState(new VSliceConvertState());
	}

	function codenameMenu():Void {
		MusicBeatState.switchState(new CodenameConvertState());
	}

	function nightmareMenu():Void {
		#if windows
		MusicBeatState.switchState(new NMVConvertState());
		#else
		// to prevent them accidently clicking it for no reason.
		remove(non_funkin);
		remove(nightmare_vision);
		remove(codename_engine);
		remove(vslice_funkin);

		infoNMVunix = new FlxSprite().loadGraphic(Paths.image('converter/pop-up/nmv-unavailable'));
        infoNMVunix.screenCenter();
        add(infoNMVunix);

        okButton = new FlxButton(675, 390, "OK", closeTheTab);
        add(okButton);
		#end
	}

	
	function closeTheTab():Void {
		// to prevent them accidently clicking it for no reason.
		add(non_funkin);
		add(nightmare_vision);
		add(codename_engine);
		add(vslice_funkin);

        remove(okButton);
		remove(infoNonFunkin);
		#if !windows
        remove(infoNMVunix);
		#end
    }

	// I can't do this by myself I just couldn't
	function notFunkinMenu():Void {
		remove(non_funkin);
		remove(nightmare_vision);
		remove(codename_engine);
		remove(vslice_funkin);

		infoNonFunkin = new FlxSprite().loadGraphic(Paths.image('converter/pop-up/non_funkin_help_wanted'));
        infoNonFunkin.screenCenter();
        add(infoNonFunkin);

        okButton = new FlxButton(630, 385, "OK", closeTheTab);
        add(okButton);
	}

    function exit():Void {
		MusicBeatState.switchState(new converters.ConverterState());
	}
}