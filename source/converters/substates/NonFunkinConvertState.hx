package converters.substates;

import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxSprite;
import mikolka.vslice.ui.MainMenuState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import mikolka.compatibility.VsliceOptions;

import backend.Song;
import backend.StageData;
import states.editors.content.VSlice;
import states.editors.content.FileDialogHandler;
import states.editors.content.PsychJsonPrinter;

import flash.net.FileFilter;
import haxe.Json;
import haxe.Exception;

class NonFunkinConvertState extends MusicBeatState {
	private var osuMania:FlxButton;
    private var stepMania:FlxButton;

	private var exitButton:FlxButton;
	private var okButton:FlxButton;

	private var nvmButton:FlxButton;

	var statusText:FlxText;

	var bg:FlxSprite;
	var cinematic:FlxSprite;

	var warnOSUchart:FlxSprite;

    override public function create():Void {
        super.create();
        
        bg = new FlxSprite().loadGraphic(Paths.image('converter/convertBG'));
		bg.color = 0xFF808080;
		bg.screenCenter();
        add(bg);

		if(!VsliceOptions.LOW_QUALITY) {
			var grid:FlxBackdrop = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, 0x33808080, 0x0));
			grid.velocity.set(40, 40);
			grid.alpha = 0;
			FlxTween.tween(grid, {alpha: 1}, 0.5, {ease: FlxEase.quadOut});
			add(grid);
		}

		cinematic = new FlxSprite().loadGraphic(Paths.image('converter/cinematic/non-funkin_menu'));
		cinematic.screenCenter();
        add(cinematic);

        osuMania = new FlxButton(250, 280, "", convertOSUWarning);
        osuMania.loadGraphic(Paths.image('converter/converter_options_choose/osu_mania'));
        add(osuMania);
        add(osuMania);

		stepMania = new FlxButton(750, 280, "", convertSM);
        stepMania.loadGraphic(Paths.image('converter/converter_options_choose/stepmania'));
        add(stepMania);
        add(stepMania);

        exitButton = new FlxButton(1050, 45, "", exit);
        exitButton.loadGraphic(Paths.image('converter/exit_icon'));
		exitButton.color = 0xFF808080;
        add(exitButton);
        add(exitButton);
    }

    function convertOSUWarning():Void {
		// to prevent them accidently clicking it for no reason.
		remove(osuMania);
		remove(stepMania);

		warnOSUchart = new FlxSprite().loadGraphic(Paths.image('converter/pop-up/osu_convert_warning'));
        warnOSUchart.screenCenter();
        add(warnOSUchart);

        okButton = new FlxButton(710, 432, "OK", convertOSU);
        add(okButton);

		nvmButton = new FlxButton(650, 432, "Cancel", closeNo);
        add(nvmButton);
	}

    function exit():Void {
		MusicBeatState.switchState(new converters.substates.MenuState());
	}

    function convertOSU():Void {
		MusicBeatState.switchState(new converters.substates.osu.MasterConverterState());
    }

	function closeNo():Void {
		// to prevent them accidently clicking it for no reason.
		add(osuMania);
		add(stepMania);

        remove(okButton);
        remove(infoCNEchart);
    }

	function convertSM():Void {
    }
}