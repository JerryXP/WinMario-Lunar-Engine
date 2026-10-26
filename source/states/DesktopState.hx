package states;

import flixel.ui.FlxButton;
import flixel.FlxState;
import lime.app.Application;
import flixel.FlxG;
import flixel.text.FlxText;
import haxe.Timer;
import DateTools;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.addons.transition.TransitionData;
import mikolka.compatibility.VsliceOptions;

class DesktopState extends FlxState {
    private var start:FlxButton;
    private var exit:FlxButton;
    private var instagram:FlxButton;
    private var tiktok:FlxButton;
    private var youtube:FlxButton;
    private var discord:FlxButton;
    private var bluesky:FlxButton;
    private var twitter:FlxButton;
    private var fnf:FlxButton;
    private var close:FlxButton;
    private var info:FlxButton;
    private var wtf:FlxButton;
    private var gallery:FlxButton;
    private var bio:FlxButton;
    var clockText:FlxText;
    var infoText:FlxText;
    #if debug
    var debugTxt:FlxText;
    #end

    private var april2026:FlxButton;
    private var winMix:FlxButton;
    private var vibin:FlxButton;

    private var banana:FlxButton;
    private var jolt:FlxButton;
    private var codeWin:FlxButton;
    private var legacyVer:FlxButton;
    private var bugIssue:FlxButton;

    private var popOK:FlxButton;
    private var popX:FlxButton;

    var transitioning:Bool = false;
    var enterTimer:FlxTimer;
    public static var closedState:Bool = false;
    var infoBox:FlxSprite = new FlxSprite(0, 0);
    var easterBox:FlxSprite = new FlxSprite(0, 0);
    
    public function new()
	{
		super();
		trace("You've successfully enter the Desktop! Welcome!!");
	}

    override public function create():Void {
        trace("You've successfully enter the Desktop! Welcome!");
        FlxG.sound.playMusic("assets/shared/music/desktop.ogg", 0.5, true);
        FlxG.camera.flash(VsliceOptions.FLASHBANG ? FlxColor.BLACK : 0x4C000000, 1);
        FlxG.mouse.visible = true;
        super.create();

        // !!! NEVER USED !!!
        //#if debug
        //debugTxt = new FlxText(1150, 663, 0, "VS. WINAMRIO 3.1 || DEBUG\nCODENAME: PURPLE FOREVER", 24);
        //debugTxt.setFormat(Paths.font("Mario64.ttf"), 24);
        //add(debugTxt);
        //#end

        #if DISCORD_ALLOWED
	// Updating Discord Rich Presence
	DiscordClient.changePresence("You've successfully enter the Desktop! Welcome!", null);
	#end
        
        var bg:FlxSprite = new FlxSprite(0, 0);

        if (ClientPrefs.data.wallpaper == 'Internal Reality') {
                bg.loadGraphic(Paths.image('desktopWallpapers/internal-reality'));
        }

        if (ClientPrefs.data.wallpaper == 'Sings it') {
                if (ClientPrefs.data.pcLight != true) {
                        bg.loadGraphic(Paths.image('desktopWallpapers/winmario-sings-it'));
		} else {
                        bg.loadGraphic(Paths.image('light-mode/desktopWallpapers/winmario-sings-it'));
                }
        }

        if (ClientPrefs.data.wallpaper == 'Vibin Forever') {
                if (ClientPrefs.data.pcLight != true) {
                        bg.loadGraphic(Paths.image('desktopWallpapers/vaporwave'));
                } else {
                        bg.loadGraphic(Paths.image('light-mode/desktopWallpapers/vaporwave'));
                }
        }
        if (ClientPrefs.data.wallpaper == 'Horizon') {
               bg.loadGraphic(Paths.image('desktopWallpapers/horizons'));
        }

        if (ClientPrefs.data.wallpaper == 'WinMario Sampler') {
                bg.loadGraphic(Paths.image('desktopWallpapers/winmario-sampler')); 
        }

        if (ClientPrefs.data.wallpaper == 'WinXP') {
                if (ClientPrefs.data.pcLight != true) {
                        bg.loadGraphic(Paths.image('desktopWallpapers/winXP'));
                } else {
                       bg.loadGraphic(Paths.image('light-mode/desktopWallpapers/winXP')); 
                }
        }

        if (ClientPrefs.data.wallpaper == 'Win7') {
                if (ClientPrefs.data.pcLight != true) {
                        bg.loadGraphic(Paths.image('desktopWallpapers/win7'));
                } else {
                        bg.loadGraphic(Paths.image('light-mode/desktopWallpapers/win7'));
                }
        }

        if (ClientPrefs.data.wallpaper == 'Win10') {
                if (ClientPrefs.data.pcLight != true) {
                        bg.loadGraphic(Paths.image('desktopWallpapers/win10'));
                } else {
                        bg.loadGraphic(Paths.image('light-mode/desktopWallpapers/win10'));
                }
        }

        if (ClientPrefs.data.wallpaper == 'Win11') {
                if (ClientPrefs.data.pcLight != true) {
                        bg.loadGraphic(Paths.image('desktopWallpapers/win11'));
                } else {
                        bg.loadGraphic(Paths.image('light-mode/desktopWallpapers/win11'));
                }
        }

        add(bg);

        if (ClientPrefs.data.pcWidgets == true) { 
                var widgets:FlxSprite = new FlxSprite(0, 0);
                if (ClientPrefs.data.pcLight != true) {
                        widgets.loadGraphic("assets/shared/images/desktop/widget.png");
                } else {
                       widgets.loadGraphic("assets/shared/images/light-mode/desktop/widget.png"); 
                }
                add(widgets);
        }

        var explorer:FlxSprite = new FlxSprite(0, 0);
        if (ClientPrefs.data.pcLight != true) {
                explorer.loadGraphic("assets/shared/images/desktop/explorer.exe_winmario.png");
        } else {
                explorer.loadGraphic("assets/shared/images/light-mode/desktop/explorer.exe_winmario.png"); 
        }
        add(explorer);

        // Initialize text field
        clockText = new FlxText(1170, 683, 0, "00:00", 16);
        clockText.setFormat(Paths.font("5by7_b.ttf"), 16);
        add(clockText);

        // Update time every 1 second (1000ms)
        var timer = new Timer(1000);
        timer.run = updateClock;
        
        // Run once immediately
        updateClock();

        // Start button
        start = new FlxButton(5, 683, "", startGame);
        start.loadGraphic("assets/shared/images/desktop/play_icon.png");
        add(start);
        add(start);

        // Exit button
        exit = new FlxButton(1125, 683, "", exitGame);
        exit.loadGraphic("assets/shared/images/desktop/exit_icon.png");
        add(exit);
        add(exit);
        
        // WTF (Recycle Bin) button
        wtf = new FlxButton(20, 80, "", easterPlaced);
        wtf.loadGraphic("assets/shared/images/desktop/wtf.png");
        add(wtf);
        add(wtf);

        // I button
        info = new FlxButton(20, 160, "", infoPlaced);
        info.loadGraphic("assets/shared/images/desktop/info_icon.png");
        add(info);
        add(info);

        // Instagram button
        instagram = new FlxButton(520, 683, "", loadinsta);
        instagram.loadGraphic("assets/shared/images/desktop/instagram_icon.png");
        add(instagram);
        add(instagram);

        // TikTok button
        tiktok = new FlxButton(560, 683, "", loadtiktok);
        tiktok.loadGraphic("assets/shared/images/desktop/tiktok_icon.png");
        add(tiktok);
        add(tiktok);

        // FNF button
        fnf = new FlxButton(600, 683, "", loadFNF);
        fnf.loadGraphic("assets/shared/images/desktop/fnf_icon.png");
        add(fnf);
        add(fnf);

        // YouTube button
        youtube = new FlxButton(640, 683, "", loadYou);
        youtube.loadGraphic("assets/shared/images/desktop/youtube_icon.png");
        add(youtube);
        add(youtube);

        // Discord button
        discord = new FlxButton(680, 683, "", loadServer);
        discord.loadGraphic("assets/shared/images/desktop/discord_icon.png");
        add(discord);
        add(discord);

        // BlueSky button
        bluesky = new FlxButton(720, 683, "", loadBlue);
        bluesky.loadGraphic("assets/shared/images/desktop/bluesky_icon.png");
        add(bluesky);
        add(bluesky);

        // Twitter (X) button
        twitter = new FlxButton(480, 683, "", loadBird);
        twitter.loadGraphic("assets/shared/images/desktop/twitter_icon.png");
        add(twitter);
        add(twitter);

        if (ClientPrefs.data.pcWidgets == true) { 
        // Widgets
        winMix = new FlxButton(1175, 50, "", loadwinMix);
        if (ClientPrefs.data.pcLight != true) {
                winMix.loadGraphic("assets/shared/images/desktop/apps/winmario-mix.png");
        } else {
                winMix.loadGraphic("assets/shared/images/light-mode/desktop/apps/winmario-mix.png");
        }
        add(winMix);
        add(winMix);

        vibin = new FlxButton(1175, 100, "", loadVibin);
        if (ClientPrefs.data.pcLight != true) {
                vibin.loadGraphic("assets/shared/images/desktop/apps/vibin.png");
        } else {
                vibin.loadGraphic("assets/shared/images/light-mode/desktop/apps/vibin.png");
        }
        add(vibin);
        add(vibin);

        april2026 = new FlxButton(1175, 150, "", loadFakeMario);
        if (ClientPrefs.data.pcLight != true) {
                april2026.loadGraphic("assets/shared/images/desktop/apps/april-fools-2026.png");
        } else {
                april2026.loadGraphic("assets/shared/images/light-mode/desktop/apps/april-fools-2026.png"); 
        }
        add(april2026);
        add(april2026);

        banana = new FlxButton(1175, 200, "", loadBanana);
        if (ClientPrefs.data.pcLight != true) {
                banana.loadGraphic("assets/shared/images/desktop/apps/gamebanana.png");
        } else {
                banana.loadGraphic("assets/shared/images/light-mode/desktop/apps/gamebanana.png");
        }
        add(banana);
        add(banana);

        jolt = new FlxButton(1175, 250, "", loadjolt);
        if (ClientPrefs.data.pcLight != true) {
                jolt.loadGraphic("assets/shared/images/desktop/apps/game-jolt.png");
        } else {
                jolt.loadGraphic("assets/shared/images/light-mode/desktop/apps/game-jolt.png");
        }
        add(jolt);
        add(jolt);

        legacyVer = new FlxButton(1175, 300, "", loadDoc);
        if (ClientPrefs.data.pcLight != true) {
                legacyVer.loadGraphic("assets/shared/images/desktop/apps/legacy-versions.png");
        } else {
                legacyVer.loadGraphic("assets/shared/images/light-mode/desktop/apps/legacy-versions.png"); 
        }
        add(legacyVer);
        add(legacyVer);

        codeWin = new FlxButton(1175, 350, "", loadCode);
        if (ClientPrefs.data.pcLight != true) {
                codeWin.loadGraphic("assets/shared/images/desktop/apps/source-code.png");
        } else {
                codeWin.loadGraphic("assets/shared/images/light-mode/desktop/apps/source-code.png");
        }
        add(codeWin);
        add(codeWin);

        bugIssue = new FlxButton(1175, 400, "", loadIssue);
        if (ClientPrefs.data.pcLight != true) {
                bugIssue.loadGraphic("assets/shared/images/desktop/apps/bug-report.png");
        } else {
                bugIssue.loadGraphic("assets/shared/images/light-mode/desktop/apps/bug-report.png");
        }
        add(bugIssue);
        add(bugIssue);
        }

        bio = new FlxButton(1045, 683, "", loadBio);
        bio.loadGraphic("assets/shared/images/desktop/biosicon.png");
        add(bio);
        add(bio);

        #if (!html5 || !web)
        // Gallery button
        gallery = new FlxButton(1085, 683, "", loadGallery);
        gallery.loadGraphic("assets/shared/images/desktop/galleryicon.png");
        add(gallery);
        add(gallery);
        #end

        if (ClientPrefs.data.pcLight == true) {
		clockText.color = FlxColor.BLACK;
	}
    }

    function updateClock():Void {
        // Format: Hour:Minute:Second
        if (ClientPrefs.data.clock == '12 Hour')
        clockText.text = DateTools.format(Date.now(), "%I:%M %p");
        if (ClientPrefs.data.clock == '24 Hour')
        clockText.text = DateTools.format(Date.now(), "%H:%M");
    }

    function startGame():Void {
        #if (html5 || web)
        infoBox.loadGraphic("assets/shared/images/desktop/pop-up/html5.png"); //PIRACY.
        infoBox.screenCenter();
        add(infoBox);
        #else
	start.color = FlxColor.WHITE;
	start.alpha = 1;

	if (start != null)
		start.animation.play('flashing');

		FlxG.camera.flash(VsliceOptions.FLASHBANG ? FlxColor.WHITE : 0x4CFFFFFF, 1);
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
                FlxG.sound.music.fadeOut();

		transitioning = true;
		// FlxG.sound.music.stop();

		enterTimer = new FlxTimer().start(1, function(tmr:FlxTimer)
		{
                        FlxTransitionableState.skipNextTransIn = true;
		        FlxTransitionableState.skipNextTransOut = true;
		        FlxG.switchState(new IntroVideoState());
                        FlxG.mouse.visible = false;

		        closedState = true;
		});
		// FlxG.sound.play(Paths.music('titleShoot'), 0.7);
         #end
    }

    function loadGallery():Void {
	start.color = FlxColor.WHITE;
	start.alpha = 1;

	if (start != null)
		start.animation.play('flashing');

		FlxG.camera.flash(VsliceOptions.FLASHBANG ? FlxColor.WHITE : 0x4CFFFFFF, 1);
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);

		transitioning = true;
		// FlxG.sound.music.stop();

		enterTimer = new FlxTimer().start(1, function(tmr:FlxTimer)
			{
                                FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
                                FlxG.mouse.visible = false;
				FlxG.switchState(new GalleryState());
                                 FlxG.sound.playMusic(Paths.music('freakyMenu'));

				closedState = true;
		});
		// FlxG.sound.play(Paths.music('titleShoot'), 0.7);
	}

        function loadBio():Void {
	start.color = FlxColor.WHITE;
	start.alpha = 1;

	if (start != null)
		start.animation.play('flashing');

		FlxG.camera.flash(VsliceOptions.FLASHBANG ? FlxColor.WHITE : 0x4CFFFFFF, 1);
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);

		transitioning = true;
		// FlxG.sound.music.stop();

		enterTimer = new FlxTimer().start(1, function(tmr:FlxTimer)
			{
                                FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
                                FlxG.mouse.visible = false;
				FlxG.switchState(new BiosMenuState());

				closedState = true;
		});
		// FlxG.sound.play(Paths.music('titleShoot'), 0.7);
	}

    function exitGame():Void {
        FlxG.sound.music.fadeOut();
        FlxG.switchState(new LoginState());
    }

    function loadinsta():Void {
            CoolUtil.browserLoad('https://www.instagram.com/luigixp_yt.jerry/');
    }

    function loadFakeMario():Void {
            CoolUtil.browserLoad('https://gamebanana.com/mods/665271');
    }
    function loadwinMix():Void {
            CoolUtil.browserLoad('https://gamejolt.com/games/WinMarMix/1014177');
    }
    function loadVibin():Void {
            CoolUtil.browserLoad('https://gamejolt.com/games/WinMarioVibin/1048849');
    }
    function loadBanana():Void {
            CoolUtil.browserLoad('https://gamebanana.com/members/4280914');
    }
    function loadjolt():Void {
            CoolUtil.browserLoad('https://gamejolt.com/@LuigiXPyt-3000');
    }
    function loadDoc():Void {
            CoolUtil.browserLoad('https://gamejolt.com/games/WinMarioFNFOLD/1049593');
    }
    function loadCode():Void {
            CoolUtil.browserLoad('https://gamejolt.com/games/WinMarioSource/1032516');
    }
    function loadIssue():Void {
            CoolUtil.browserLoad('https://github.com/JerryXP/WinMarioFNF-2026-BUG-REPORTS-/issues');
    }

    function infoPlaced():Void {
            FlxG.sound.music.fadeOut();
            LoadingState.loadAndSwitchState(new InfoDesktop());
    }

    function easterPlaced():Void {
            easterBox.loadGraphic("assets/shared/images/desktop/pop-up/info-easter.png"); 
            easterBox.screenCenter();
            add(easterBox);

            popX = new FlxButton(675, 385, "OK", closeTheTabEaster);
            add(popX);
    }

    function closeTheTabEaster():Void {
            remove(popX);
            remove(easterBox);
    }


    function loadtiktok():Void {
            CoolUtil.browserLoad('https://www.tiktok.com/@winmario_yt');
    }

    function loadFNF():Void {
            CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
    }

    function loadYou():Void {
            CoolUtil.browserLoad('https://www.youtube.com/@WinMario_YT');
    }

    function loadServer():Void {
            CoolUtil.browserLoad('https://discord.gg/p5kd2sExBN');
    }

    function loadBlue():Void {
            CoolUtil.browserLoad('https://bsky.app/profile/winmario.bsky.social');
    }

    function loadBird():Void {
            CoolUtil.browserLoad('https://twitter.com/WinMario3000');
    }
}