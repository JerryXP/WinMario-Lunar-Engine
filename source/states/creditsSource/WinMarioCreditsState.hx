package states.creditsSource;

import mikolka.funkin.custom.mobile.MobileScaleMode;
import objects.AttachedSprite;

class WinMarioCreditsState extends MusicBeatState
{
	var curSelected:Int = -1;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];
	private var creditsStuff:Array<Array<String>> = [];

	var bg:FlxSprite;
	var descText:FlxText;
	var intendedColor:FlxColor;
	var descBox:AttachedSprite;

	var offsetThing:Float = -75;

	override function create()
	{
		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		persistentUpdate = true;
		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		add(bg);
		
		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		var defaultList:Array<Array<String>> = [ //Name - Icon name - Description - Link - BG Color.
			["Lunar Engine"],
			["WM/LXP",		        "win",		        "The one who made this Engine",					       "https://linktr.ee/WinMarioXP3000",	"8000FF"],
			[""],
			["Support Friends"],
			["TintGox",		 "tintgox",	   "Helped me with Kade Engine Color Timebar",	 "https://www.youtube.com/@tintgox10",		"008080"],
			["yoshifan66",		        "yoshifan66",		        "Helped with MultiKey Note Support\n(I know that MCO7's Multi Key support had failed, but hey, I tried.)",		"https://www.youtube.com/@yoshifan66-h",	"00FF00"],
			[""],
			#if (LUA_ALLOWED || HSCRIPT_ALLOWED)
			["Scripts"],
			["Uhard999",		        "missing_icon",		        "Watermark and Health",					  "https://gamebanana.com/members/1872659",	"808080"],
			#if HSCRIPT_ALLOWED
			["DaPootisBirdYT",		        "missing_icon",		        "Winning Icon",					  "https://gamebanana.com/members/2031145",		"808080"],
			#end
			["Stilic",		        "missing_icon",		        "Note Combo",					  "https://gamebanana.com/members/1893262",				"808080"],
			["Rodney~ An Imaginative Furball",		    "missing_icon",		  "Stage Changer",	"https://gamebanana.com/members/1729833",				"808080"],
			["vCherry.kAI.16",		 "missing_icon",	   "Combo break = gf cry",	 "https://gamebanana.com/members/1921624",							"808080"],
			["SadSami",		 "missing_icon",	   "Break Time/Note Timer Script",	 			"https://gamebanana.com/members/3418239",				"808080"],
			["MCO7",		 "missing_icon",	   "Psych Engine 1.0 Skin Selector\n, Beta BF Winning Icon",	 		"https://www.youtube.com/@MC0777",		"808080"],
			["Super_Hugo",	 "missing_icon",		 "Blammed Lights & Philly Glow Recreation",		"https://gamebanana.com/members/2151945",			"808080"],
			["BlixerTheGamebananer",	"missing_icon",	 "Combo Break Sound Script",			"https://gamebanana.com/members/2179280",			"FF0000"],
			["RamenDominoes",		        "missing_icon",		        "Cinematics",					  "https://gamebanana.com/members/2135195",		"808080"],
			["Ghost1787581",		        "missing_icon",		        "Note Offset Pop-up",					  "https://gamebanana.com/members/1787581",		"808080"],
			["BloonyFox",		        "bloonyfox",		        "Icon Colored Strumlines & Notes",					  "https://gamebanana.com/members/2751687",		"808080"],
			["blobbert",		        "missing_icon",		        "Opponent Note Color (for legacy purposes)",					  "https://gamebanana.com/members/2723067",		"808080"],
			[""],
			["Shaders"],
			["TheZoroForce240",		        "missing_icon",		        "RTX Shader",					  "https://gamebanana.com/members/1708748",		"808080"],
			["Chara Maker",		        "missing_icon",		        "Erect Shaders (fixed)",					  "https://gamebanana.com/members/4082914",		"808080"],
			["Ledonic",		        "missing_icon",		        "Drop Shadow Shader (fixed)",					  "https://gamebanana.com/members/3574043",		"808080"],
			[""],
			#end
			["Sprites/Assets"],
			["Vs. Tabi (V1)",	"missing_icon",      "Scared BF",		"https://gamebanana.com/mods/286388",	"808080"],
			["pixel_ratto",		"missing_icon",		"Scared BF & GF (pixel)",			"https://gamebanana.com/members/2004377",		"808080"],
			["(._.)",		"missing_icon",		"Expanded Pixel BF",			"https://gamebanana.com/members/1789351",		"808080"],
			["OliverGamingAtPaperSchool",	"missing_icon",      "Noteskin (TABI)",		"https://www.youtube.com/@OliverGamingAtPaperSchool",	"808080"],
			["Olivier99",		"missing_icon",	"Future & Chip Noteskin (DIVIDE BY ZERO)",			"https://gamebanana.com/members/1860941",		"808080"],
			["DeliriousPersona",		"missing_icon",	"Edit the DivideByZero Spritesheet",			"https://gamebanana.com/members/1779588",		"808080"],
			["RoboPuff",		"missing_icon",	"RGB Support for DivideByZero Noteskins",			"https://gamebanana.com/members/2212648",		"808080"],
			["BloomEld",	"missing_icon",      "Entity Noteskin (edit by me)\nShiny Noteskin RGB Support",		"https://gamebanana.com/members/2951815",	"808080"],
			["Ghost1906081",	"missing_icon",      "Original for Shiny Note",		"https://gamebanana.com/members/1906081",							"808080"],
			["Indie Cross",		"missing_icon",			"Note Splash",						"https://gamejolt.com/games/indiecross/643540",					"808080"],
			["FNF: ENTITY",		"missing_icon",			"Noteskin",									"https://gamebanana.com/mods/284934",							"808080"],
			["Milanesa",		"bald",			"Mario's Madness (Port)",			"https://gamebanana.com/members/2060195",					"808080"],
			["Mario's Madness V2",		"missing_icon",			"Mario's Madness Noteskin (OG)",		"https://gamebanana.com/mods/359554",					"808080"],
			["UrJust2Ez4Me",		"missing_icon",			"Angry+Scared Custom BF Dialogue (add and edit by me)\nAngry BF",		"https://gamebanana.com/members/1740975",	"808080"],
			["[ NAME ]",		"missing_icon",			"Note Splashes (old ver & og forever ver)",		"https://gamebanana.com/members/2541091",	"808080"],
			["JDVoidFNF",		"missing_icon",			"Note Splashes (rgb forever ver)",		"https://gamebanana.com/members/4337031",	"808080"],
			["Red-Bun",		"missing_icon",			"Note Splashes (andromeda, yoshi, leather, & hope ver)",		"https://gamebanana.com/members/1812789",	"808080"],
			["Andromeda Engine",		"missing_icon",			"Note Splashes (andromeda engine ver)",		"https://github.com/nebulazorua/andromeda-engine-legacy",	"808080"],
			["Forever Engine",		"missing_icon",			"Note Splashes (forever engine ver)",		"https://gamejolt.com/games/fnfforeverengine/692242",	"808080"],
			["YoshCrafter Engine",		"missing_icon",			"Note Splashes (yoshi engine ver)",		"https://gamebanana.com/mods/352532",	"808080"],
			["Hope Engine",		"missing_icon",			"Note Splashes (hope engine ver)\nThere is a Download link but the mod is private :(",		"",	"808080"],
			["Leather Engine",		"missing_icon",			"Note Splashes (leather engine ver)",		"https://gamebanana.com/mods/334945",	"808080"],
			["Super Funkin' Galaxy",		"missing_icon",			"Use their Soundbox Sounds & Assets",		"https://gamebanana.com/mods/444759",	"000080"],
			["Rozebud",		"missing_icon",			"FPS+ Winning Icons\nFPS+ Title Screen Reference",		"https://gamebanana.com/members/1767623",	"808080"],
			["canUbeU",		"missing_icon",			"Pixel Pico, Senpai, & Spirit Winning Icons",		"https://gamebanana.com/members/4540535",	"808080"],
			["B-Sides",		"missing_icon",			"Character Select (game over), Crazy & Cool Pixel Sprite (edit by me)",		"https://gamebanana.com/mods/42724",	"808080"],
			["YinaNoka",		"missing_icon",			"Ok Pixel Sprite (edit by me)",		"https://gamebanana.com/members/1942955",	"808080"],
			["E-shrimp",		"missing_icon",			"Crap/Awful Pixel Sprite (edit by me)",		"https://gamebanana.com/members/1874765",	"808080"],
			["FaithfulBunny0",		"missing_icon",			"Made a Alt Animations for Pico",		"https://gamebanana.com/members/3873890",	"808080"],
			["Gox491",		"missing_icon",			"Made a Alt Animations for BF Xmas",		"https://gamebanana.com/members/3873890",	"808080"],
			#if (LUA_ALLOWED)
			["te-agmaat032", "missing_icon",		"Special Note Mechanics Pack (edit by me)",			"https://gamebanana.com/members/1769584",		"808080"],
			["Punkinator7",	"missing_icon",	 "Special Note Mechanics Pack (edit by me)",			"https://gamebanana.com/members/1687904",			"808080"],
			["Ciphernetics",	"missing_icon",	 "Danger Note (edit by me)",			"https://gamebanana.com/members/1866642",			"808080"],
			#end
			["DylanTails876",		        "missing_icon",		  "Character Select BF Speaker",			"https://gamebanana.com/members/1920694",		"808080"],
			["This is fine",		        "missing_icon",		        "Made Erect BF (use to replace boring GF that y'all like to lust)",				"https://gamebanana.com/members/1800297",	"808080"],
			[""],
			["Other/Misc"],
			["Nintendo",	"missing_icon",	 "Mario Sounds and Music. (mostly Galaxy)",			"https://x.com/NintendoAmerica",			"FF0000"],
			["Sega",	"missing_icon",	 			"Combo Break Custom Sounds & Music",							"https://x.com/SEGA",											"0000FF"],
			["Microslop",	"missing_icon",	 			"Custom Menu Select Sounds\n(fuck ai slop bitch.)",							"https://x.com/Microsoft",									"00FF00"],
			["The Mockupverse Wiki",	"missing_icon",	 			"Windows Zinc, 14 (old), 16, & 18\nStart-up for Several intros I used.",		"https://mockupverse.fandom.com/wiki/The_Mockupverse_Wiki",		"00FF00"],
			["Newer Team",	"missing_icon",	 "Newer SMBWii Music",			"https://newerteam.com",			"FF0000"],
			[""],
			["Code"],
			["MrpoloOfficial",		        "missing_icon",		        "Intro & Outro Video States (edit by me)",			"https://gamebanana.com/members/2307558",	"808080"],
			["Lenin Anonimo",		        "missing_icon",		        "For Using Several of their Code",			"https://gamebanana.com/members/3509758",	"6000C0"],
			#if desktop
			["Lucas-Sanches",		        "missing_icon",		        "For using the code for Converters State\n(& Legacy Converters State)",			"https://gamebanana.com/members/2088040",	"6000C0"],
			["SquidBowl",		        "tinkatonk",		        "GalleryState (edit by me)",			"https://gamebanana.com/members/2041479",	"804000"],
			#end
		];
		
		for(i in defaultList)
			creditsStuff.push(i);
	
		for (i => credit in creditsStuff)
		{
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(FlxG.width / 2, 300, credit[0], !isSelectable);
			optionText.isMenuItem = true;
			optionText.targetY = i;
			optionText.changeX = false;
			optionText.snapToPosition();
			grpOptions.add(optionText);

			if(isSelectable)
			{
				var str:String = 'credits/missing_icon';
				if(credit[1] != null && credit[1].length > 0)
				{
					var fileName = 'credits/' + credit[1];
					if (Paths.fileExists('images/$fileName.png', IMAGE)) str = fileName;
					else if (Paths.fileExists('images/$fileName-pixel.png', IMAGE)) str = fileName + '-pixel';
				}

				var icon:AttachedSprite = new AttachedSprite(str);
				if(str.endsWith('-pixel')) icon.antialiasing = false;
				icon.xAdd = optionText.width + 10;
				icon.sprTracker = optionText;
	
				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				add(icon);

				if(curSelected == -1) curSelected = i;
			}
			else optionText.alignment = CENTERED;
		}
		
		descBox = new AttachedSprite();
		descBox.makeGraphic(1, 1, FlxColor.BLACK);
		descBox.xAdd = -10;
		descBox.yAdd = -10;
		descBox.alphaMult = 0.6;
		descBox.alpha = 0.6;
		add(descBox);

		var txtWidthOffset:Float = Math.max(MobileScaleMode.gameCutoutSize.x / 2,50);

		descText = new FlxText(txtWidthOffset, FlxG.height + offsetThing - 25, FlxG.width-(txtWidthOffset*2), "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER/*, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK*/);
		descText.scrollFactor.set();
		//descText.borderSize = 2.4;
		descBox.sprTracker = descText;
		add(descText);

		bg.color = CoolUtil.colorFromString(creditsStuff[curSelected][4]);
		intendedColor = bg.color;
		changeSelection();
		#if TOUCH_CONTROLS_ALLOWED
		addTouchPad('UP_DOWN', 'A_B');
		#end
		super.create();
	}

	var quitting:Bool = false;
	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if(!quitting)
		{
			if(creditsStuff.length > 1)
			{
				var shiftMult:Int = 1;
				if(FlxG.keys.pressed.SHIFT) shiftMult = 3;

				var upP = controls.UI_UP_P;
				var downP = controls.UI_DOWN_P;

				if (upP)
				{
					changeSelection(-shiftMult);
					holdTime = 0;
				}
				if (downP)
				{
					changeSelection(shiftMult);
					holdTime = 0;
				}

				if(controls.UI_DOWN || controls.UI_UP)
				{
					var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
					holdTime += elapsed;
					var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

					if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
					{
						changeSelection((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
					}
				}
			}

			if(controls.ACCEPT && (creditsStuff[curSelected][3] == null || creditsStuff[curSelected][3].length > 4)) {
				CoolUtil.browserLoad(creditsStuff[curSelected][3]);
			}
			if (controls.BACK)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new options.CreditsChoice());
				quitting = true;
			}
		}
		
		for (item in grpOptions.members)
		{
			if(!item.bold)
			{
				var lerpVal:Float = Math.exp(-elapsed * 12);
				if(item.targetY == 0)
				{
					var lastX:Float = item.x;
					item.screenCenter(X);
					item.x = FlxMath.lerp(item.x - 70, lastX, lerpVal);
				}
				else
				{
					item.x = FlxMath.lerp(200 + -40 * Math.abs(item.targetY), item.x, lerpVal);
				}
			}
		}
		super.update(elapsed);
	}

	var moveTween:FlxTween = null;
	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do
		{
			curSelected = FlxMath.wrap(curSelected + change, 0, creditsStuff.length - 1);
		}
		while(unselectableCheck(curSelected));

		var newColor:FlxColor = CoolUtil.colorFromString(creditsStuff[curSelected][4]);
		//trace('The BG color is: $newColor');
		if(newColor != intendedColor)
		{
			intendedColor = newColor;
			FlxTween.cancelTweensOf(bg);
			FlxTween.color(bg, 1, bg.color, intendedColor);
		}

		for (num => item in grpOptions.members)
		{
			item.targetY = num - curSelected;
			if(!unselectableCheck(num)) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
				}
			}
		}

		descText.text = creditsStuff[curSelected][2];
		if(descText.text.trim().length > 0)
		{
			descText.visible = descBox.visible = true;
			descText.y = FlxG.height - descText.height + offsetThing - 60;
	
			if(moveTween != null) moveTween.cancel();
			moveTween = FlxTween.tween(descText, {y : descText.y + 75}, 0.25, {ease: FlxEase.sineOut});
	
			descBox.setGraphicSize(Std.int(descText.width + 20), Std.int(descText.height + 25));
			descBox.updateHitbox();
			
		}
		else descText.visible = descBox.visible = false;
	}

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}
