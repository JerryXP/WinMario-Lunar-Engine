package converters;

import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxSprite;
import mikolka.vslice.ui.MainMenuState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import mikolka.compatibility.VsliceOptions;

class ConverterState extends MusicBeatState {
    private var openButton:FlxButton;
    private var exitButton:FlxButton;

	var bg:FlxSprite;

    public function new()
	{
		super();
		trace("Entering Converter State");
	}

    override public function create():Void {
        FlxG.mouse.visible = true;
        super.create(); 

		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Converter State", null);
		#end
        
        bg = new FlxSprite().loadGraphic(Paths.image('converter/convertBG'));
		bg.color = 0xFF3F4F70;
		bg.screenCenter();
        add(bg);

		if(!VsliceOptions.LOW_QUALITY) {
			var grid:FlxBackdrop = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, 0x33FFFFFF, 0x0));
			grid.velocity.set(40, 40);
			grid.alpha = 0;
			FlxTween.tween(grid, {alpha: 1}, 0.5, {ease: FlxEase.quadOut});
			add(grid);
		}

        var logoBl:FlxSprite;
        logoBl = new FlxSprite(100, 0);
		logoBl.loadGraphic(Paths.image('converter/converter_state_logo'));
		logoBl.antialiasing = VsliceOptions.ANTIALIASING;
        FlxTween.tween(logoBl, {y: logoBl.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
		logoBl.updateHitbox();
        add(logoBl);

        openButton = new FlxButton(450, 611, "", openMenu);
        openButton.loadGraphic(Paths.image('converter/open_icon'));
        add(openButton);
        add(openButton); 

        exitButton = new FlxButton(700, 611, "", exit);
        exitButton.loadGraphic(Paths.image('converter/exit_icon'));
        add(exitButton);
        add(exitButton);
    }

    function openMenu():Void {
		MusicBeatState.switchState(new converters.substates.MenuState());
	}

    function exit():Void {
		FlxG.mouse.visible = false;
		FlxG.sound.play(Paths.sound('cancelMenu'), 0.7);
		FlxG.sound.playMusic(Paths.music('freakyMenu'));
		MusicBeatState.switchState(new MainMenuState());
	}
}