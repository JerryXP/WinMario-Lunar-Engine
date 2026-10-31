package;
import mikolka.vslice.components.crash.CrashServer;
import mikolka.vslice.components.DebugDisplay.FunkinDebugDisplay;
import mikolka.funkin.custom.mobile.MobileScaleMode;
import states.InitState;
import mikolka.vslice.components.crash.Logger;
#if HSCRIPT_ALLOWED
import crowplexus.iris.Iris;
import psychlua.HScript.HScriptInfos;
#end
import openfl.display.FPS;
import mikolka.GameBorder;
import flixel.graphics.FlxGraphic;
import flixel.FlxGame;
import flixel.FlxState;
import haxe.io.Path;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import debug.FPSCounter;
import backend.ClientPrefs;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.display.StageScaleMode;
import lime.app.Application;
#if (linux || mac)
import lime.graphics.Image;
#end
import lenin.slushithings.windows.WindowsAPI;


#if (linux && !debug)
@:cppInclude('./external/linux/gamemode_client.h')
@:cppFileCode('#define GAMEMODE_AUTO')
#end
class Main extends Sprite
{
	public static final game = {
		width: 1280, // WINDOW width
		height: 720, // WINDOW height
		initialState: InitState, // initial game state
		zoom: -1.0, // game state bounds
		framerate: 120, // default framerate
		skipSplash: true, // if the default flixel splash screen should be skipped
		startFullscreen: false // if the game should start at fullscreen mode
	};
	public static var fpsVar:FPSCounter;
	public static var debugDisplay:FunkinDebugDisplay;
	public static final platform:String = #if mobile "Phones" #else "PCs" #end;
	public static var watermarkSprite:Sprite = null;
	public static var watermark:Bitmap = null;

	// Window focus management
	public static var focused:Bool = true;
	var oldVol:Float = 1.0;
	var newVol:Float = 0.2;
	var focusStateTimer:FlxTimer;
	var windowHasFocus:Bool = true;
	var restoringFocusVolume:Bool = false;
	public static var focusMusicTween:FlxTween;

	// Game pre-flixel init code
	// ? This runs before we attempt to precache things
	public static function loadGameEarly()
	{

		CrashServer.init();

		#if (linux || mac) // fix the app icon not showing up on the Linux Panel
		var icon = lime.graphics.Image.fromFile("icon.png");
		Lib.current.stage.window.setIcon(icon);
		#end

		//New Year
		if (Date.now().getMonth() == 0 && Date.now().getDate() == 1)
			Lib.current.stage.window.title = "Vs. WinMario: HAPPY NEW YEAR!";

		//Valentine's Day
		if (Date.now().getMonth() == 1 && Date.now().getDate() == 14)
			Lib.current.stage.window.title = "Vs. WinMario: Happy Valentine Day";

		//St. Patrick's Day
		if (Date.now().getMonth() == 2 && Date.now().getDate() == 17)
			Lib.current.stage.window.title = "Vs. WinMario: Happy St. Patrick Day";

		//Congrats to player for downloading V3.0 on Release Day!
		//if (Date.now().getMonth() == 5 && Date.now().getDate() == 12 && Date.now().getFullYear() == 2026)
			//Lib.current.stage.window.title = "Thank you for Downloading... WINMARIO 3.0!!";

		//To celebrate the Vs. WinMario's Official Full Release! (August 19)
		if (Date.now().getMonth() == 7 && Date.now().getDate() == 19)
			Lib.current.stage.window.title = "Welcome to Vs. WinMario!";

		//To celebrate The Developer's (WM/LXP) Birthday! (August 28)
		if (Date.now().getMonth() == 7 && Date.now().getDate() == 28)
			Lib.current.stage.window.title = "Happy Birthday, WM/LXP!";

		//Halloween
		if (Date.now().getMonth() == 9 && Date.now().getDate() == 31)
			Lib.current.stage.window.title = "Vs. WinMario: Happy Halloween!";

		//Christmas!!
		if (Date.now().getMonth() == 11 && Date.now().getDate() == 25)
			Lib.current.stage.window.title = "Vs. WinMario: Merry Christmas!";
		

		// This requests file access on android (otherwise we will crash later)
		#if android
		StorageUtil.requestPermissions();
		#end

		//? iOS seems to be crasing on this line... 
		#if android
		Sys.setCwd(StorageUtil.getStorageDirectory());
		#end

		#if mobile
		extension.haptics.Haptic.initialize();
		#end
		#if sys

		//cpp.vm.Gc.setTargetFreeSpacePercentage(30);
		Logger.startLogging();
		trace("CWD IS " + StorageUtil.getStorageDirectory());
		#end
		backend.CrashHandler.init();
		trace("Crash handler is up!");

		// This initialises mods
		try
		{
			trace("Pushing global mods");
			#if LUA_ALLOWED
			Mods.pushGlobalMods();
			#end
			trace("Pushing top mod");
			Mods.loadTopMod();
		}
		catch (x:Exception)
			trace("Something went wrong with mod code: " + x.message);

		#if hxvlc
		trace("Starting hxvlc..");
		hxvlc.util.Handle.init(#if (hxvlc >= "1.8.0") ['--no-lua'] #end);
		#end
	}

	// You can pretty much ignore everything from here on - your code should go in your states.

	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();
		if (stage != null)
		{
			init();
		}
		else
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		#if (cpp && windows)
		// Add window close handler for fade out effect
		Application.current.window.onClose.add(onWindowClose);
		// Add window focus handlers
		Application.current.window.onFocusIn.add(onWindowFocusIn);
		Application.current.window.onFocusOut.add(onWindowFocusOut);
		#end

		#if (cpp && windows)
		backend.Native.fixScaling();
		// Initialize window transparency support
		WindowsAPI.setWindowLayered();
		// Set window border color to purple (128, 41, 182)
		WindowsAPI.setWindowBorderColor(128, 0, 0);
		#end

		trace("Main done it's code");
	}

	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}


	#if (cpp && windows)
	function onWindowClose():Void
	{
		lenin.slushithings.windows.WindowsAPI.fadeOutAndExit();
	}

	function onWindowFocusOut():Void
	{
		if (!windowHasFocus) return;
		windowHasFocus = false;
		focused = false;

		if (focusStateTimer != null)
		{
			focusStateTimer.cancel();
			focusStateTimer = null;
		}

		if (!restoringFocusVolume)
		{
			oldVol = FlxG.sound.volume;
		}
		restoringFocusVolume = false;
		if (oldVol > 0.3)
		{
			newVol = 0.3;
		}
		else
		{
			if (oldVol > 0.1)
			{
				newVol = 0.1;
			}
			else
			{
				newVol = 0;
			}
		}

		if (focusMusicTween != null) focusMusicTween.cancel();
		focusMusicTween = FlxTween.tween(FlxG.sound, {volume: newVol}, 0.5);
	}

	function onWindowFocusIn():Void
	{
		if (windowHasFocus) return;
		windowHasFocus = true;
		restoringFocusVolume = true;

		if (focusStateTimer != null)
		{
			focusStateTimer.cancel();
		}
		focusStateTimer = new FlxTimer().start(0.2, function(tmr:FlxTimer) {
			focused = true;
			focusStateTimer = null;
		});

		// Normal global volume when focused
		if (focusMusicTween != null) focusMusicTween.cancel();
		focusMusicTween = FlxTween.tween(FlxG.sound, {volume: oldVol}, 0.5, {
			onComplete: function(_)
			{
				restoringFocusVolume = false;
			}
		});
	}
	#end

	private function setupGame():Void
	{

		trace(backend.Native.buildSystemInfo());
		#if HXCPP_TRACY
		trace("Starting tracy");
		cpp.vm.tracy.TracyProfiler.messageAppInfo(backend.Native.buildSystemInfo());
		cpp.vm.tracy.TracyProfiler.setThreadName("main");
		#end

		trace("Starting game setup");
		#if (openfl <= "9.2.0")
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;
		if (game.zoom == -1.0)
		{
			var ratioX:Float = stageWidth / game.width;
			var ratioY:Float = stageHeight / game.height;
			game.zoom = Math.min(ratioX, ratioY);
			game.width = Math.ceil(stageWidth / game.zoom);
			game.height = Math.ceil(stageHeight / game.zoom);
		}
		#else
		if (game.zoom == -1.0)
			game.zoom = 1.0;
		#end

		trace("Initializing save .sol");
		FlxG.save.bind('funkin', CoolUtil.getSavePath(), (rawSave, error) ->
		{
			#if sys
			trace("Couldn't load main save. Attempting to extract");
			try
			{
				var badSave = File.write(StorageUtil.getStorageDirectory() + "/funkin.sol.bad");
				badSave.writeString(rawSave);
				badSave.close();
				trace("Extracted bad save to funkin.sol.bad. Creating new save..");
			}
			catch (x)
			{
				trace(x);
				trace("Failed to backup. Discarding..");
			}
			return
			{
			};
			#end
		});

		CrashServer.setupInstanceId();

		trace("Loading scores..");
		Highscore.load();

		#if HSCRIPT_ALLOWED
		trace("Hooking up the Iris log functions");
		Iris.warn = function(x, ?pos:haxe.PosInfos)
		{
			Iris.logLevel(WARN, x, pos);
			var newPos:HScriptInfos = cast pos;
			if (newPos.showLine == null)
				newPos.showLine = true;
			var msgInfo:String = (newPos.funcName != null ? '(${newPos.funcName}) - ' : '') + '${newPos.fileName}:';
			#if LUA_ALLOWED
			if (newPos.isLua == true)
			{
				msgInfo += 'HScript:';
				newPos.showLine = false;
			}
			#end
			if (newPos.showLine == true)
			{
				msgInfo += '${newPos.lineNumber}:';
			}
			msgInfo += ' $x';
			if (PlayState.instance != null)
				PlayState.instance.addTextToDebug('WARNING: $msgInfo', FlxColor.YELLOW);
		}
		Iris.error = function(x, ?pos:haxe.PosInfos)
		{
			Iris.logLevel(ERROR, x, pos);
			var newPos:HScriptInfos = cast pos;
			if (newPos.showLine == null)
				newPos.showLine = true;
			var msgInfo:String = (newPos.funcName != null ? '(${newPos.funcName}) - ' : '') + '${newPos.fileName}:';
			#if LUA_ALLOWED
			if (newPos.isLua == true)
			{
				msgInfo += 'HScript:';
				newPos.showLine = false;
			}
			#end
			if (newPos.showLine == true)
			{
				msgInfo += '${newPos.lineNumber}:';
			}
			msgInfo += ' $x';
			if (PlayState.instance != null)
				PlayState.instance.addTextToDebug('ERROR: $msgInfo', FlxColor.RED);
		}
		Iris.fatal = function(x, ?pos:haxe.PosInfos)
		{
			Iris.logLevel(FATAL, x, pos);
			var newPos:HScriptInfos = cast pos;
			if (newPos.showLine == null)
				newPos.showLine = true;
			var msgInfo:String = (newPos.funcName != null ? '(${newPos.funcName}) - ' : '') + '${newPos.fileName}:';
			#if LUA_ALLOWED
			if (newPos.isLua == true)
			{
				msgInfo += 'HScript:';
				newPos.showLine = false;
			}
			#end
			if (newPos.showLine == true)
			{
				msgInfo += '${newPos.lineNumber}:';
			}
			msgInfo += ' $x';
			if (PlayState.instance != null)
				PlayState.instance.addTextToDebug('FATAL: $msgInfo', 0xFFBB0000);
		}
		#end

		#if LUA_ALLOWED
		trace("Hooking up Lua");
		Lua.set_callbacks_function(cpp.Callable.fromStaticFunction(psychlua.CallbackHandler.call));
		#end

		trace("Loading controls");
		Controls.instance = new Controls();
		ClientPrefs.loadDefaultKeys();
		#if ACHIEVEMENTS_ALLOWED Achievements.load(); #end


		trace("Loading game objest...");
		var gameObject = new FlxGame(game.width, game.height, game.initialState, #if (flixel < "5.0.0") game.zoom, #end game.framerate, game.framerate,
			game.skipSplash, game.startFullscreen);
		// FlxG.game._customSoundTray wants just the class, it calls new from
		// create() in there, which gets called when it's added to stage
		// which is why it needs to be added before addChild(game) here
		@:privateAccess
		gameObject._customSoundTray = mikolka.vslice.components.FunkinSoundTray;

		addChild(gameObject);

		trace("Finishing up..");
		debugDisplay = new FunkinDebugDisplay(10, 10, 0xFFFFFF);
		#if mobile
		FlxG.game.addChild(debugDisplay);
		#else
		#if !debug
		// var border = new GameBorder();
		// addChild(border);
		// Lib.current.stage.window.onResize.add(border.updateGameSize);
		#end
		addChild(debugDisplay);
		#end
		Lib.current.stage.align = "tl";
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;

		if (debugDisplay != null)
		{
			debugDisplay.visible = ClientPrefs.data.showFPSOpacity != 0;
			debugDisplay.backgroundOpacity = ClientPrefs.data.showFPSOpacity;
			debugDisplay.isAdvanced = ClientPrefs.data.fpsRework;
		}

		#if (debug)
		flixel.addons.studio.FlxStudio.create();
		#end

		#if html5
		FlxG.autoPause = false;
		FlxG.mouse.visible = false;
		#end

		FlxG.fixedTimestep = false;
		FlxG.game.focusLostFramerate = #if mobile 30 #else 60 #end;
		#if web
		FlxG.keys.preventDefaultKeys.push(TAB);
		#else
		FlxG.keys.preventDefaultKeys = [TAB];
		#end

		#if DISCORD_ALLOWED
		DiscordClient.prepare();
		#end

		#if mobile
		#if android FlxG.android.preventDefaultKeys = [BACK]; #end
		lime.system.System.allowScreenTimeout = ClientPrefs.data.screensaver;
		//Application.current.window.vsync = ClientPrefs.data.vsync;
		#end

		// shader coords fix
		var resizeDebounceTimer:FlxTimer = null;
		function handleGameResized():Void {
			// Reposition the FPS counter relative to FlxGame (accounts for letterboxing)
			if(fpsVar != null) {
				var marginX = 10;
				var marginY = 3;
				#if android
				fpsVar.positionFPS(FlxG.game.x + marginX, FlxG.game.y + marginY, 1.0);
				#else
				fpsVar.positionFPS(marginX, marginY, 1.0);
				#end
			}
			
			// Only reposition the watermark, no scaling.
			positionWatermark();
			
		     if (FlxG.cameras != null) {
			   for (cam in FlxG.cameras.list) {
				if (cam != null && cam.filters != null)
					resetSpriteCache(cam.flashSprite);
			   }
			}

			if (FlxG.game != null)
			resetSpriteCache(FlxG.game);
		}

		FlxG.signals.gameResized.add(function(w, h)
		{
			if (FlxG.cameras != null)
			{
				for (cam in FlxG.cameras.list)
				{
					if (cam != null && cam.filters != null)
						resetSpriteCache(cam.flashSprite);
				}
			}

			if (FlxG.game != null)
				resetSpriteCache(FlxG.game);
		});

		var imagePath = backend.Paths.getPath('images/logo/watermark.png', IMAGE);
		if (sys.FileSystem.exists(imagePath)) {
		    if (watermark != null && watermark.parent != null)
		        removeChild(watermark);
			var bmpData = openfl.display.BitmapData.fromFile(imagePath);
			watermark = new openfl.display.Bitmap(bmpData);
			var scale = 0.85;
			watermark.scaleX = -scale;
			watermark.scaleY = scale;
			watermark.alpha = 0.5;
			addChild(watermark);
			positionWatermark();
			Lib.current.stage.addEventListener(openfl.events.Event.RESIZE, function(_) positionWatermark());
		}
		if (watermark != null) {
		    watermark.visible = ClientPrefs.data.showWatermark;
		}
		
	}

	static function resetSpriteCache(sprite:Sprite):Void
	{
		@:privateAccess {
			sprite.__cacheBitmap = null;
			sprite.__cacheBitmapData = null;
		}
	}

	function positionWatermark():Void {
		if (watermarkSprite != null && watermark != null) {
			var marginX = 10;
			var marginY = 10;
			var stageW = openfl.Lib.current.stage.stageWidth;
			watermarkSprite.x = stageW - watermark.width * Math.abs(watermark.scaleX) - marginX;
			watermarkSprite.y = marginY;
		}
		if (watermark != null && watermark.parent == this) {
			var stageW = Lib.current.stage.stageWidth;
			var stageH = Lib.current.stage.stageHeight;
			watermark.x = stageW - watermark.width * Math.abs(watermark.scaleX) + 110;
			watermark.y = stageH - watermark.height * Math.abs(watermark.scaleY) - 30;
		}
	}
}
