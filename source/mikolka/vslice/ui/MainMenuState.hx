package mikolka.vslice.ui;

import mikolka.vslice.ui.mainmenu.DesktopMenuState;
import mikolka.compatibility.ui.MainMenuHooks;
import mikolka.compatibility.VsliceOptions;
import mikolka.vslice.ui.title.TitleState;
import mikolka.compatibility.ModsHelper;
import options.OptionsState;
import funkin.vis.dsp.SpectralAnalyzer;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;

class MainMenuState extends MusicBeatState
{
	//If it's Psych 1.0.4 Based (Default)
	#if !LEGACY_PSYCH
	public static var psychEngineVersion:String = '1.0.4'; // This is also used for Discord RPC
	#if windows
	public static var winmarioVersion:String = '3.4';
	#elseif (mac || linux)
	public static var winmarioVersion:String = '3.4';
	#elseif mobile
	public static var winmarioVersion:String = '3.4'; // Never Released but if there is a chance. 
	#end
	#end

	/**
	 * #if LEGACY_PSYCH
	 * public static var psychEngineVersion:String = '0.6.3'; // This is also used for Discord RPC
	 * public static var winmarioVersion:String = 'DON\'T SUPPORT 0.6.3 PSYCH.';
	 * #end
	 *
	 * C'mon bro. Vs. WinMario was not meant to be used for Psych 0.6.3
	 * In the first place. Don't you fucking try it.
	**/

	//Other Versions
	public static var pSliceVersion:String = '3.4.2';
	public static var funkinVersion:String = '0.7.6'; // Version of funkin' we are emulationg

	var bg:FlxSprite;
	var magenta:FlxSprite;

	var stickerSubState:Bool;
	var visualizerEnabled:Bool = true;

	var _vizBars:FlxTypedGroup<FlxSprite>;
	var _analyzer:SpectralAnalyzer = null;
	var _analyzerLevels:Array<funkin.vis.dsp.SpectralAnalyzer.Bar> = null;
	var _needsAnalyzerInit:Bool = false;
	static inline var VIZ_BAR_COUNT:Int = 256;
	static inline var VIZ_BAR_MAX_H:Int = 240;

	public function new(?stickers:Bool = false)
	{
		super();
		stickerSubState = stickers;
		
	}

	override function create()
	{
		if(stickerSubState) ModsHelper.clearStoredWithoutStickers();
		else CacheSystem.clearStoredMemory();
		CacheSystem.clearUnusedMemory();
		#if (debug && !LEGACY_PSYCH)
		FlxG.console.registerFunction("dumpCache",CacheSystem.cacheStatus); 
		FlxG.console.registerFunction("dumpSystem",backend.Native.buildSystemInfo);
		#end
		
		ModsHelper.resetActiveMods();

		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		persistentUpdate = persistentDraw = true;

		bg = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
		bg.antialiasing = VsliceOptions.ANTIALIASING;
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		add(bg);

		if(!VsliceOptions.LOW_QUALITY) {
		var grid:FlxBackdrop = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, 0x33FF00FF, 0x0));
		grid.velocity.set(40, 40);
		grid.alpha = 0;
		FlxTween.tween(grid, {alpha: 1}, 0.5, {ease: FlxEase.quadOut});
		add(grid);
		
		_vizBars = new FlxTypedGroup<FlxSprite>();
		var vizBarW:Int = Std.int(FlxG.width / VIZ_BAR_COUNT);
		for(i in 0...VIZ_BAR_COUNT) {
			var vbar = new FlxSprite();
			vbar.makeGraphic(vizBarW - 1, VIZ_BAR_MAX_H, FlxColor.PURPLE);
			vbar.setGraphicSize(vizBarW - 1, 2);
			vbar.updateHitbox();
			vbar.x = i * vizBarW;
			vbar.y = FlxG.height - 2;
			vbar.alpha = 0.0;
			vbar.scrollFactor.set();
			_vizBars.add(vbar);
		}
		add(_vizBars);
		_needsAnalyzerInit = true;
		}

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.antialiasing = VsliceOptions.ANTIALIASING;
		magenta.setGraphicSize(Std.int(magenta.width * 1.175));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.color = 0xF800080;
		add(magenta);

		var winVer:FlxText = new FlxText(0, FlxG.height - 18, FlxG.width, "WinMario " + winmarioVersion, 12);
		winVer.setFormat(Paths.font("score.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		winVer.scrollFactor.set();
		add(winVer);

		#if mobile
		var psychVer:FlxText = new FlxText(0, FlxG.height - 720, FlxG.width, "Psych Based: " + psychEngineVersion, 12);
		psychVer.setFormat(Paths.font("ModernDOS8x16.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		psychVer.scrollFactor.set();
		add(psychVer);

		var psliceVer:FlxText = new FlxText(0, FlxG.height - 702, FlxG.width, "P-Slice Based: " + pSliceVersion, 12);
		psliceVer.setFormat(Paths.font("ModernDOS8x16.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		psliceVer.scrollFactor.set();
		add(psliceVer);

		var fnfVer:FlxText = new FlxText(0, FlxG.height - 684, FlxG.width, "FNF Based: " + funkinVersion, 12);
		fnfVer.setFormat(Paths.font("ModernDOS8x16.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		fnfVer.scrollFactor.set();
		add(fnfVer);

		#if android
		var androidTxt:FlxText = new FlxText(0, FlxG.height - 666, FlxG.width, "OS: Android", 12);
		androidTxt.setFormat(Paths.font("ModernDOS8x16.ttf"), 16, FlxColor.GREEN, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		androidTxt.scrollFactor.set();
		add(androidTxt);
		#end
		#if ios
		var iphoneTxt:FlxText = new FlxText(0, FlxG.height - 666, FlxG.width, "OS: iOS", 12);
		iphoneTxt.setFormat(Paths.font("ModernDOS8x16.ttf"), 16, 0xFF00FFFF, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		iphoneTxt.scrollFactor.set();
		add(iphoneTxt);
		#end
		#end

		/**
		 * In case if you're confused, then I am going to tell you this.
		 * instead of typing 1-12 like January to December, you have to type, 0-11
		 * Welcome to Haxe but again, I will help you out.
		 * 
		 * 0 = January
		 * 1 = February
		 * 2 = March
		 * 3 = April
		 * 4 = May
		 * 5 = June
		 * 6 = July
		 * 7 = August
		 * 8 = September
		 * 9 = October
		 * 10 = November
		 * 11 = December
		 * 
		 * This is only for when you are typing the code
		 * to be appear by using (Date.now().getMonth() == 0-11)
		 * 
		 * If you're wondering... Why is the other Events I celebrate is not there?
		 * it's because I am American, so yours (like Calendar) might be different in your culture or country.
		 * But here is the other stuff Why it's not there
		 * 
		 * Martin Luther King Jr. Day - It's an American thing and Several of you don't know who it is. & It only happens on every 3rd Monday of January, so it's impossible to code it.
		 * President's Day - It's an American thing & Idk who the hell celebrates that day.
		 * Daylight Saving Time starts - Who the fuck is happy about it?
		 * Easter Sunday - The day is randomized & it's a Christian Thing. (like me)
		 * Easter Monday - same to easter sunday
		 * Tax Day - Do I... EVER NEED TO REMIND YOU THAT?! FUCK NO!!!
		 * Mother's Day - We love our Mothers but Several of you don't care about it.
		 * Memorial Day - It's an American thing & It only happens on every Last Monday of May, so it's impossible to code it.
		 * Flag Day - It's an American thing & YES WE ALL DON'T KNOW WHAT'S THAT.
		 * Juneteenth -  It's an black American thing (like me) & A lot of people don't know what's that.
		 * Father's Day - same to mother's day but we love our Dads.
		 * Independence Day (july 4) - It's an American thing
		 * Labor Day - It's an American thing & I don't know what's that.
		 * Columbus Day - It's where Columbus found America but unfortunately, i found nothing special about it.
		 * Daylight Saving Time ends - again... Who the fuck is happy about it?
		 * Election Day (november) - It's an American thing but unfortunately, i found nothing special about it.
		 * Veterans Day (november) - It's an American thing & Just celebrate the Veterans who fought the wars.
		 * Thanksgiving Day - It only happens on every Last Thursday of November, so it's impossible to code it.
		 * Black Friday - It only happens on every Last Friday of November, so it's impossible to code it.
		 * Christmas/New Year's Eve - "Eve" is where that you have 1 more day before the day begins. 
		**/

		if (Date.now().getMonth() == 0 && Date.now().getDate() == 1) { //Happy New Year!
		var winVerSP:FlxText = new FlxText(0, FlxG.height - 32, FlxG.width, "Happy New Year!", 12);
		winVerSP.setFormat(Paths.font("score.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		winVerSP.scrollFactor.set();
		add(winVerSP);
		} else if (Date.now().getMonth() == 1 && Date.now().getDate() == 15) { //SHE SLAYED THAT
		var winVerSP:FlxText = new FlxText(0, FlxG.height - 32, FlxG.width, "Happy Birthday, Paula! (PxJx/Paxton)", 12);
		winVerSP.setFormat(Paths.font("score.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		winVerSP.scrollFactor.set();
		add(winVerSP);
		} else if (Date.now().getMonth() == 1 && Date.now().getDate() == 14) { //Valentine's Day
		var winVerSP:FlxText = new FlxText(0, FlxG.height - 32, FlxG.width, "Happy Valentine's Day!", 12);
		winVerSP.setFormat(Paths.font("score.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		winVerSP.scrollFactor.set();
		add(winVerSP);
		} else if (Date.now().getMonth() == 2 && Date.now().getDate() == 1) { //Just because I said Oliver, doesn't mean he is coming back.
		var winVerSP:FlxText = new FlxText(0, FlxG.height - 32, FlxG.width, "Happy Birthday, Oliver Gaming!", 12);
		winVerSP.setFormat(Paths.font("score.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		winVerSP.scrollFactor.set();
		add(winVerSP);
		} else if (Date.now().getMonth() == 2 && Date.now().getDate() == 10) { //MAR10 DAY
		var winVerSP:FlxText = new FlxText(0, FlxG.height - 32, FlxG.width, "Happy Mar10 Day!", 12);
		winVerSP.setFormat(Paths.font("score.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		winVerSP.scrollFactor.set();
		add(winVerSP);
		} else if (Date.now().getMonth() == 2 && Date.now().getDate() == 17) { //Saint Patrick's Day
		var winVerSP:FlxText = new FlxText(0, FlxG.height - 32, FlxG.width, "Happy St. Patrick's Day!", 12);
		winVerSP.setFormat(Paths.font("score.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		winVerSP.scrollFactor.set();
		add(winVerSP);
		} else if (Date.now().getMonth() == 4 && Date.now().getDate() == 5) { //Cinco de Mayo
		var winVerSP:FlxText = new FlxText(0, FlxG.height - 32, FlxG.width, "Happy Cinco de Mayo!", 12);
		winVerSP.setFormat(Paths.font("score.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		winVerSP.scrollFactor.set();
		add(winVerSP);
		} else if (Date.now().getMonth() == 4 && Date.now().getDate() == 28) { //DinoEvan's Birthday
		var winVerSP:FlxText = new FlxText(0, FlxG.height - 32, FlxG.width, "Happy Birthday, DinoEvan.21!", 12);
		winVerSP.setFormat(Paths.font("score.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		winVerSP.scrollFactor.set();
		add(winVerSP);
		}
		else if (Date.now().getMonth() == 7 && Date.now().getDate() == 19) { //Vs. WinMario Release on August 19, 2025.
		var winVerSP:FlxText = new FlxText(0, FlxG.height - 32, FlxG.width, "Today is the Anniversary of Vs. WinMario's Release!!", 12);
		winVerSP.setFormat(Paths.font("score.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		winVerSP.scrollFactor.set();
		add(winVerSP);
		} else if (Date.now().getMonth() == 7 && Date.now().getDate() == 28) { //Happy Birthday to Me!!
		var winVerSP:FlxText = new FlxText(0, FlxG.height - 32, FlxG.width, "Happy Birthday, WM/LXP!!", 12);
		winVerSP.setFormat(Paths.font("score.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		winVerSP.scrollFactor.set();
		add(winVerSP);
		}
		else if (Date.now().getMonth() == 9 && Date.now().getDate() == 31) { //mario's tunnel of the doom. (Happy Halloween)
		var winVerSP:FlxText = new FlxText(0, FlxG.height - 32, FlxG.width, "Happy Halloween!! (very scary)", 12);
		winVerSP.setFormat(Paths.font("score.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		winVerSP.scrollFactor.set();
		add(winVerSP);
		} else if (Date.now().getMonth() == 11 && Date.now().getDate() == 25) { //We love Christmas
		var winVerSP:FlxText = new FlxText(0, FlxG.height - 32, FlxG.width, "Merry Christmas!!", 12);
		winVerSP.setFormat(Paths.font("score.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		winVerSP.scrollFactor.set();
		add(winVerSP);
		}


		#if ACHIEVEMENTS_ALLOWED
		var leDate = Date.now();
		if (leDate.getMonth() == 7 && leDate.getDate() == 28)
			backend.Achievements.unlock('birthday');

		#if MODS_ALLOWED
		backend.Achievements.reloadList();
		#end
		#end

		super.create();
		#if TOUCH_CONTROLS_ALLOWED
		if (controls.mobileC)
			new mobile.states.MobileMenuState(this);
		else
		#end
		new DesktopMenuState(this);
		
	}

	function goToOptions()
	{
		MusicBeatState.switchState(new OptionsState());
		#if !LEGACY_PSYCH OptionsState.onPlayState = false; #end
		if (PlayState.SONG != null)
		{
			PlayState.SONG.arrowSkin = null;
			PlayState.SONG.splashSkin = null;
			#if !LEGACY_PSYCH PlayState.stageUI = 'normal'; #end
		}
	}

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
			FlxG.sound.music.volume += 0.5 * elapsed;
		super.update(elapsed);

		if(_needsAnalyzerInit && FlxG.sound.music != null && FlxG.sound.music.playing) {
			@:privateAccess
			if(FlxG.sound.music._channel != null && FlxG.sound.music._channel.__audioSource != null) {
				// Improved spectral analyzer calibration
				_analyzer = new SpectralAnalyzer(FlxG.sound.music._channel.__audioSource, VIZ_BAR_COUNT, 0.08, 25);
				// Better frequency range for music visualization
				_analyzer.minFreq = 40;
				_analyzer.maxFreq = 18000;
				// Adjust dB range for better sensitivity
				_analyzer.minDb = -80;
				_analyzer.maxDb = -15;
				#if !web
				// Higher FFT size for better frequency resolution
				_analyzer.fftN = 512;
				#end
				_needsAnalyzerInit = false;
			}
		}
		if(_vizBars != null) {
			var vizBarW:Int = Std.int(FlxG.width / VIZ_BAR_COUNT);
			if(_analyzer != null) {
				_analyzerLevels = _analyzer.getLevels(_analyzerLevels);
				for(i in 0..._vizBars.members.length) {
					var vbar = _vizBars.members[i];
					if(vbar == null) continue;
					var level:Float = (i < _analyzerLevels.length) ? _analyzerLevels[i].value : 0.0;
					var h:Int = Std.int(Math.max(2, level * VIZ_BAR_MAX_H));
					vbar.setGraphicSize(vizBarW - 1, h);
					vbar.updateHitbox();
					vbar.x = i * vizBarW;
					vbar.y = FlxG.height - h;
					vbar.alpha = 1.0;
				}
			} else {
				for(i in 0..._vizBars.members.length) {
					var vbar = _vizBars.members[i];
					if(vbar == null) continue;
					vbar.setGraphicSize(vizBarW - 1, 2);
					vbar.updateHitbox();
					vbar.y = FlxG.height - 2;
					vbar.alpha = 1.0;
				}
			}
		}
	}

	override function destroy():Void {
		_analyzer = null;
		_analyzerLevels = null;
		if(_vizBars != null) { _vizBars.destroy(); _vizBars = null; }
		super.destroy();
	}
}
