package states;

import flixel.util.typeLimit.OneOfTwo;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import openfl.Assets;
import haxe.xml.Access;
#if hxvlc
import hxvlc.flixel.FlxVideoSprite;
#end

class IntroVideoState extends MusicBeatState
{
	var allowMouse:Bool = false;
	var currentFPS:Bool = false;

	 public function new()
	{
		super();
		#if linux
		trace("Checking LibVLC Available...");
		trace("Sucessfully loading Video Intro!");
		#else
		trace("Sucessfully loading Video Intro!");
		#end
	}

	#if VIDEOS_ALLOWED
	public var videoCutscene:FlxVideoSprite;
	override public function create():Void
	{
			if (ClientPrefs.data.introvideoCutscene == 'Normal')
        	startVideo('intro'); // change this boi
			if (ClientPrefs.data.introvideoCutscene == 'Alternate')
			startVideo('intro-short');
			if (ClientPrefs.data.introvideoCutscene == 'WinXP')
			startVideo('intro-xp');
			if (ClientPrefs.data.introvideoCutscene == 'WinVista B1')
			startVideo('intro-vista');
			if (ClientPrefs.data.introvideoCutscene == 'Mario World')
			startVideo('intro-smw');
			if (ClientPrefs.data.introvideoCutscene == 'WM/LXP Mix')
			startVideo('intro-winmarioMix');
			if (ClientPrefs.data.introvideoCutscene == 'Legacy')
			startVideo('intro-legacy');

		super.create();
	}

   	public function startVideo(name:String)
	{
		videoCutscene = new FlxVideoSprite(0, 0);
		add(videoCutscene);
		videoCutscene.load(Paths.video("intro/"+(name)));
		videoCutscene.play();
		videoCutscene.alpha = 1;
		videoCutscene.visible = true;
		videoCutscene.bitmap.onEndReached.add(function()
		{
            		new FlxTimer().start(0.1, function(tmr:FlxTimer)
            		{
						if (Date.now().getMonth() == 7 && Date.now().getDate() == 28) {
							MusicBeatState.switchState(new birthday.TitleState());
						} else {
							MusicBeatState.switchState(new mikolka.vslice.ui.title.TitleState());
						}
            		});
		});
	}
	
	override public function update(elapsed:Float):Void
	{
		#if desktop
		if (controls.ACCEPT) {
			if (Date.now().getMonth() == 7 && Date.now().getDate() == 28) {
					MusicBeatState.switchState(new birthday.TitleState());
				} else {
					MusicBeatState.switchState(new mikolka.vslice.ui.title.TitleState());
				}
		}
		#end
		#if mobile
		if (TouchUtil.justReleased && !SwipeUtil.swipeAny) {
			if (Date.now().getMonth() == 7 && Date.now().getDate() == 28) {
					MusicBeatState.switchState(new birthday.TitleState());
				} else {
					MusicBeatState.switchState(new mikolka.vslice.ui.title.TitleState());
				}
		}
		#end
		if (ClientPrefs.data.introvideoCutscene == 'Disabled') {
			if (Date.now().getMonth() == 7 && Date.now().getDate() == 28) {
					MusicBeatState.switchState(new birthday.TitleState());
				} else {
					MusicBeatState.switchState(new mikolka.vslice.ui.title.TitleState());
				}
		}

		super.update(elapsed);
	}
	#end
}