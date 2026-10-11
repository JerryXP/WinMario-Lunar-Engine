package mikolka.vslice.ui.mainmenu;

import mikolka.vslice.freeplay.FreeplayState;
import options.OptionsState;
import flixel.FlxBasic;
import flixel.effects.FlxFlicker;
import mikolka.vslice.ui.title.TitleState;
#if !LEGACY_PSYCH
#if MODS_ALLOWED
import states.ModsMenuState;
#end
import states.AchievementsMenuState;
import options.CreditsChoice;
import states.editors.MasterEditorMenu;
#else
import editors.MasterEditorMenu;
#end
import mikolka.compatibility.VsliceOptions;
import flixel.FlxObject;
import converters.ConverterState;

@:access(mikolka.vslice.ui.MainMenuState)
class DesktopMenuState extends FlxBasic
{
	var optionShit:Array<String> = [
		'story_mode',
		'freeplay',
		#if desktop 'ost', #end
		#if ACHIEVEMENTS_ALLOWED 'awards', #end
		#if desktop 'gallery', #end
		'credits',
		'options'
	];

	public static var curSelected:Int = 0;
    var selectedSomethin:Bool = false;
	var menuItems:FlxTypedGroup<FlxSprite>;
	var camFollow:FlxObject;
    
    var host:MainMenuState;
    public function new(host:MainMenuState) {
        super();
        this.host = host;
        host.add(this);

		var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);
		host.bg.scrollFactor.set(0, yScroll);
		host.bg.updateHitbox();
		host.bg.screenCenter();

        host.magenta.scrollFactor.set(0, yScroll);
		host.magenta.updateHitbox();
		host.magenta.screenCenter();

		camFollow = new FlxObject(0, 0, 1, 1);
		host.add(camFollow);

		menuItems = new FlxTypedGroup<FlxSprite>();
		host.add(menuItems);

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite(0, (i * 140) + offset);
			menuItem.antialiasing = VsliceOptions.ANTIALIASING;
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if (optionShit.length < 6)
				scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.updateHitbox();
			menuItem.screenCenter(X);
		}

		FlxG.camera.follow(camFollow, null, 0.06);
        changeItem();

		#if TOUCH_CONTROLS_ALLOWED
		host.addTouchPad('UP_DOWN', 'A_B');
		#end
    }


	override function update(elapsed:Float)
	{
		if (!selectedSomethin)
		{
			if (host.controls.UI_UP_P)
				changeItem(-1);

			if (host.controls.UI_DOWN_P)
				changeItem(1);

			if (host.controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new mikolka.vslice.ui.title.TitleState());
				if (Date.now().getMonth() == 7 && Date.now().getDate() == 28)
				MusicBeatState.switchState(new birthday.TitleState());
			}

			if (host.controls.ACCEPT)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));
				FlxTransitionableState.skipNextTransIn = false;
				FlxTransitionableState.skipNextTransOut = false;
				if (optionShit[curSelected] == 'donate')
				{
					CoolUtil.browserLoad('https://discord.gg/p5kd2sExBN');
				}
				else
				{
					selectedSomethin = true;

					if (VsliceOptions.FLASHBANG)
						FlxFlicker.flicker(host.magenta, 1.1, 0.15, false);

					FlxFlicker.flicker(menuItems.members[curSelected], 1, 0.06, false, false, function(flick:FlxFlicker)
					{
						switch (optionShit[curSelected])
						{
							case 'story_mode':
								MusicBeatState.switchState(new StoryMenuState());
								FlxG.sound.playMusic(Paths.music('playTheme'));
							#if desktop
							case 'ost':
								MusicBeatState.switchState(new states.SoundtrackState());
							case 'gallery':
								MusicBeatState.switchState(new states.GalleryState());
							#end
							case 'freeplay':
								{
									host.persistentDraw = true;
									host.persistentUpdate = false;
									// Freeplay has its own custom transition
									FlxTransitionableState.skipNextTransIn = true;
									FlxTransitionableState.skipNextTransOut = true;

									host.openSubState(new FreeplayState());
									host.subStateOpened.addOnce(state ->
									{
										for (i in 0...menuItems.members.length)
										{
											menuItems.members[i].revive();
											menuItems.members[i].alpha = 1;
											menuItems.members[i].visible = true;
											selectedSomethin = false;
										}
										changeItem(0);
									});
								}

							#if MODS_ALLOWED
							case 'mods':
								MusicBeatState.switchState(new ModsMenuState());
							#end

							#if ACHIEVEMENTS_ALLOWED
							case 'awards':
								MusicBeatState.switchState(new AchievementsMenuState());
							#end

							case 'credits':
								MusicBeatState.switchState(new options.CreditsChoice());
							case 'options':
								host.goToOptions();
						}
					});

					for (i in 0...menuItems.members.length)
					{
						if (i == curSelected)
							continue;
						FlxTween.tween(menuItems.members[i], {alpha: 0}, 0.4, {
							ease: FlxEase.quadOut,
							onComplete: function(twn:FlxTween)
							{
								menuItems.members[i].kill();
							}
						});
					}
				}
			}
			if (ClientPrefs.data.debugkeysLunar) {
				if (host.controls.justPressed('debug_1'))
				{
					selectedSomethin = true;
					FlxTransitionableState.skipNextTransIn = false;
					FlxTransitionableState.skipNextTransOut = false;
					MusicBeatState.switchState(new options.OptionsStateCheat());
				}
				if (host.controls.justPressed('debug_2'))
				{
					selectedSomethin = true;
					FlxTransitionableState.skipNextTransIn = false;
					FlxTransitionableState.skipNextTransOut = false;
					FlxG.sound.music.fadeOut();
					MusicBeatState.switchState(new ConverterState());
					FlxG.sound.playMusic(Paths.music('converter_menu'));
				}
			}
		}

		super.update(elapsed);
	}

	function changeItem(huh:Int = 0)
	{
		if (huh != 0)
			FlxG.sound.play(Paths.sound('scrollMenu'));
		menuItems.members[curSelected].animation.play('idle');
		menuItems.members[curSelected].updateHitbox();
		menuItems.members[curSelected].screenCenter(X);

		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.members[curSelected].animation.play('selected');
		menuItems.members[curSelected].centerOffsets();
		menuItems.members[curSelected].screenCenter(X);

		camFollow.setPosition(menuItems.members[curSelected].getGraphicMidpoint().x,
			menuItems.members[curSelected].getGraphicMidpoint().y - (menuItems.length > 4 ? menuItems.length * 8 : 0));
	}
}
