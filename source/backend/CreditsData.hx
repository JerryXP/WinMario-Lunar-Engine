package backend;

using StringTools;

/**
	A single clickable link shown on a credit person's info panel.
**/
typedef CreditLink = {
	/** The text shown for the link (e.g. `Social`); defaults to the URL's domain when blank. **/
	label:String,

	/** The URL opened in the browser when the link is activated. **/
	url:String
};

/**
	One credited contributor: their display name, icon, role text, accent colour and links. Built
	either from the hard-coded engine list (`person`) or from a mod's credits file (`parsePersonObj` /
	`parseModTxt`).
**/
typedef CreditPerson = {
	/** Display name shown in the grid and info panel. **/
	name:String,

	/** Icon image key under `images/` (e.g. `credits/lulu`), or null for the default icon. **/
	?icon:String,

	/** Role/description text; may contain `\n` for line breaks. **/
	?role:String,

	/** Accent colour as a hex string (e.g. `8A6FB0`); tints the background/swatch. **/
	?color:String,

	/** Full-screen background image key shown when this person is selected, or null. **/
	?background:String,

	/** The person's links (zero or more). **/
	links:Array<CreditLink>,

	/** Owning mod folder for asset resolution, or null for engine credits. **/
	?modFolder:String
};

/**
	A named group of credited people (one row in the credits sidebar), e.g. `Special Thanks`.
**/
typedef CreditSection = {
	/** Section title shown in the sidebar/header. **/
	name:String,

	/** The people in this section. **/
	people:Array<CreditPerson>,

	/** Owning mod folder for asset resolution, or null for engine sections. **/
	?modFolder:String,

	/** Section-wide background image key (a person's own `background` overrides it), or null. **/
	?background:String,

	/** Section-wide accent colour as a hex string (a person's own `color` overrides it), or null. **/
	?color:String
};

/**
	Source of truth for the credits screen (`CreditsState`). Provides the hard-coded engine credits and
	merges in per-mod credits read from each enabled mod's `data/credits.json` or `data/credits.txt`.
**/
class CreditsData {
	/**
		Builds the full ordered credits list: the engine sections first, then one or more sections per
		enabled mod (empty mod sections are skipped).
		@return every credit section to display, in order
	**/
	public static function build():Array<CreditSection> {
		var sections:Array<CreditSection> = engineSections();
		#if MODS_ALLOWED
		for (folder in Mods.parseList().enabled) {
			for (s in loadModSections(folder))
				if (s.people.length > 0)
					sections.push(s);
		}
		#end
		return sections;
	}

	/**
		The hard-coded engine credits.
		@return the built-in credit sections
	**/
	static function engineSections():Array<CreditSection> {
		return [
			section('Vs. WinMario', [
				person('WM/LXP', 'win', 'The one who made this Engine',	[
					{
						label: 'YouTube',
						url: 'https://www.youtube.com/@WinMario_YT'
					},
					{
						label: 'Second YT', 
						url: 'https://www.youtube.com/@WinLuigi_YT'
					},
					{
						label: 'Instagram', 
						url: 'https://www.instagram.com/luigixp_yt.jerry'
					},
					{
						label: 'TikTok', 
						url: 'https://www.tiktok.com/@winmario_yt'
					},
					{
						label: 'Discord (User)', 
						url: 'https://discord.com/users/1171661642963107881'
					},
					{
						label: 'Discord (Server)', 
						url: 'https://discord.com/invite/p5kd2sExBN'
					},
					{
						label: 'Twitter/X', 
						url: 'https://x.com/WinMario3000'
					},
					{
						label: 'Blue Sky', 
						url: 'https://bsky.app/profile/winmario.bsky.social'
					}
				],	'934bb3'),
			]),

			section('Support Friends', [
				person("DinoEvan.21",		        "dino",		     "Originally Made Mr. Glitch's Final Form ; Featured ; His Arts/OCs Used",	  "https://www.youtube.com/@Dinoevan.21",	"FF0000"),
				person("Paxton",		        "pinky",		        "Featured ; Her Arts/OCs used",	[
					{
						label: 'YouTube',
						url: 'https://www.youtube.com/@um.anoptx'
					},
					{
						label: 'Instagram', 
						url: 'https://www.instagram.com/ppp.a._j/'
					},
					{
						label: 'TikTok', 
						url: 'https://www.tiktok.com/@um.anoptx'
					},
					{
						label: 'Twitter/X', 
						url: 'https://x.com/umanoptx'
					}
				],	"B0609F"),
			]),
			
			section('Special Thanks', [
				person("TintGox",		 "tintgox",	   "Helped me with Kade Engine Color Timebar",	 "https://www.youtube.com/@tintgox10",		"008080"),
				person("yoshifan66",	"yoshifan66",	"Helped with MultiKey Note Support\n(I know that MCO7's Multi Key support had failed, but hey, I tried.)",		"https://www.youtube.com/@yoshifan66-h",	"00FF00"),
			]),

			section('Songs', [
				person("MoldyGH",		        "",		        "Vs. Dave & Bambi",					       "https://www.youtube.com/@MoldyGangstaHero",	"808080"),
				person("Tsuraran",		        "tsu",		        "Salty's Sunday Night",					       "https://www.youtube.com/@Tsuraran",	"808080"),
				person("YingYang48",		        "",		        "Vs. Hex",					       			"https://www.youtube.com/@YingYang48",	"808080"),
				person("joolie",		        "",		        "Vs. Bambi Strident Crisis",				"https://www.youtube.com/@joolieiscool",	"808080"),
				person("Keymo",		        "",		        "Friday Night Funkin: Pibby Corrupted",					"https://x.com/SmokeDeveloper",	"808080"),
				person("Rareblin",		        "",		        "Vs. Imposter ; Vs. Him",					   "https://www.youtube.com/@Rareblin",	"808080"),
				person("punkett",		        "",		        "Vs. Imposter",					       				"https://www.youtube.com/@punkett",	"808080"),
				person("Rozebud",		        "rozebud",		        "Friday Night Funkin B-Side Remix ; FNF: ENTITY",					"https://www.youtube.com/@Rozebud",	"6000FF"),
				person("JADS",		        "",		        "Shiver",				"https://www.youtube.com/@JADSCastle",							"808080"),
				person("fluffyhairs",		        "",		        "Corruption",					       "https://www.youtube.com/@fluffyhairsmusic",	"808080"),
				person("bb-panzu",			"bb",				"Holiday Mod (p2) ; Date Week",					"https://x.com/bbsub3",				"3E813A"),
				person("Biddle3",		        "",		        "Chaos Nightmare ; FNF B3 Remix",				"https://www.youtube.com/@therealb3",	"808080"),
				person("Penguin 123-452",		        "",	"Confronting Yourself (vocals)",				"https://www.youtube.com/@Penguin123452ac",	"808080"),
				person("Saster",		        "",	          "Confronting Yourself (inst)",				"https://www.youtube.com/c/SasterSub0ru",	"808080"),
				person("Vruzzen",		        "",		        "Vs. Imposter",					       "https://www.youtube.com/@Vruzzen",												"808080"),
				person("Jhaix",		        "",		        "Wednesday's Infidelity",							"https://www.youtube.com/@Jhaix",	"808080"),
				person("Kitty Pop",		        "",		        "FNF Big Brother",				"https://www.youtube.com/@KittyPop",	"808080"),
				person("Demar",		        "",		        "Always Here & Memories (modified)",				"https://www.youtube.com/@Demarcool",	"808080"),
				person("JellyFish!",		        "",		        "Friday Night Funkin Neo",				"https://www.youtube.com/@JellyFish-Music",	"808080"),
				person("Saruky",		        "",		        "Friday Night Funkin (duh :/) ; Corruption",	"https://www.youtube.com/c/Saruky",		"808080"),
				person("EthanTheDoodler",		        "",		     "Vs. Imposter",					"https://x.com/D00dlerEthan",					"808080"),
				person("wildy",		        "",		"literally every fnf mod ever (Bob Onslaught)",			"https://www.youtube.com/@wildy1233",	"808080"),
				person("Savestate Corrupted",	"",		  "VS Carol: Expanded",								"https://www.youtube.com/@savestatecorrupted",	"808080"),
				person("GRYSCL ._.",		        "",		        "Corruption",				"https://www.youtube.com/@GRYSCL",						"808080"),
				person("MAXPROLOVER988",		        "",		        "TWIDDLEFINGER",		"https://x.com/maxprolover988?lang=en",					"808080"),
				person("Kohta Takahashi",		        "",		     "Friday Night Funkin (duh :/)",			"https://twitter.com/kohta09",			"808080"),
				person("Powerhaus",		        "",		     "Super Funkin' Galaxy",			"",			"808080"),
				person("Luminator",		        "",		     "Super Funkin' Galaxy",			"https://www.youtube.com/@Luminator",			"808080"),
				person("Starbreak",		        "",		     "Vs. Void",			"https://www.youtube.com/@StarbreakMusic",			"808080"),
				person("SilvaGunner",		    "",	 "Vs. Whitty: Definitive Edition",			"https://www.youtube.com/@SiIvaGunner",					"808080"),
				person("Hazardous 24",		        "",		        "Vs. QT Mod",				"https://www.youtube.com/@hazard2463",				"808080"),
				person("sock.clip",		        "",		     "Vs. Whitty",				"https://www.instagram.com/sock.clip/",														"808080"),
				person("Taluen",		        "",		     "Vs. Imposter B-Side",				"",														"808080"),
				person("GoddessAwe",		    "",	 	"Wednesday's Infidelity",				"https://www.youtube.com/@awe9037",						"808080"),
				person("Lean",		    "",	 	"Wednesday's Infidelity",				"https://www.youtube.com/@LeanDapper",				"808080"),
				person("Tenzubushi",		        "",		        "Vs. Tabi",				"https://www.youtube.com/@Tenzalt",						"808080"),
				person("KyleGFX",		        "",		     "literally every fnf mod ever (Bob Onslaught)",	"https://www.youtube.com/@KyleGFX",		"808080"),
				person("MarStarBro",		    "",	 				"Vs. Sonic.EXE",			"https://www.youtube.com/c/MarStarBro",					"808080"),
				person("DatDavi",		        "",		     "Corruption",				"https://www.youtube.com/@datdavi",								"808080"),
				person("SimplyCrispy",		        "",		      "Corruption",				"https://gamebanana.com/members/1716639",				"808080"),
				person("CheeseWithCake",		    "",	 	"Velma Meets the Original Velma:\nRemembrance",		"https://gamebanana.com/members/2044033",	"808080"),
				person("myakish.",		        "",		     "Remembrance Final Mix",		"https://www.youtube.com/@myakiYeY",   "808080"),
				person("Digital Hourglass",		        "digi",		     "Pluto's Reprisal (p2)",		"https://www.youtube.com/@DigitalHourglass",   "0000FF"),
			]),

			section('Scripts', [
				person("Uhard999",		        "",		        "Watermark and Health",					  "https://gamebanana.com/members/1872659",	"808080"),
				person("Stilic",		        "",		        "Note Combo",					  "https://gamebanana.com/members/1893262",				"FFFFFF"),
				person("Rodney~ An Imaginative Furball",		    "rodner",		  "Stage Changer",	"https://gamebanana.com/members/1729833",				"b778ff"),
				person("vCherry.kAI.16",		 "",	   "Combo break = gf cry",	 "https://gamebanana.com/members/1921624",							"ab2e51"),
				person("SadSami",		 "",	   "Break Time/Note Timer Script",	 			"https://gamebanana.com/members/3418239",				"808080"),
				person("MCO7",		 "mco7",	   "Psych Engine 1.0 Skin Selector\n, Beta BF Winning Icon",	 		"https://www.youtube.com/@MC0777",		"FF0000"),
				person("Super_Hugo",	 "",		 "Blammed Lights & Philly Glow Recreation",		"https://gamebanana.com/members/2151945",			"8080FF"),
				person("BlixerTheGamebananer",	"",	 "Combo Break Sound Script",			"https://gamebanana.com/members/2179280",			"FF0020"),
				person("RamenDominoes",		        "ramen",		        "Cinematics",					  "https://gamebanana.com/members/2135195",		"CE9600"),
				person("Ghost1787581",		        "",		        "Note Offset Pop-up",					  "https://gamebanana.com/members/1787581",		"808080"),
				person("BloonyFox",		        "bloonyfox",		        "Icon Colored Strumlines & Notes",					  "https://gamebanana.com/members/2751687",		"bf8a49"),
				person("blobbert",		        "",		        "Opponent Note Color (for legacy purposes)",					  "https://gamebanana.com/members/2723067",		"606060"),
				person("DaPootisBirdYT",		        "",		        "Winning Icon",					  "https://gamebanana.com/members/2031145",		"6000C0"),
				person("Gabio",		        "",	   			"ending image",	 							"",											"808080"),
				person("Pf0r",		        "",		        "Another Stage Changer",		"https://gamebanana.com/members/1823815",				"808080"),
				person("JoLteon:D",		        "",	   "Opponent Note Fade",	 "https://gamebanana.com/members/1919640",							"808080"),
				person("BlueColorsin",		    "",	   			"Modchart Bounce (Detected)",	 		"",											"808080"),
				person("Ledonic",		        "ledonic",		    "Events for Win-Eggnog II", "https://gamebanana.com/members/3574043",		"3897FF"),
				person("SonicTheFunker",		        "",	   "Miss Limiter (edit by me)",	 "https://gamebanana.com/members/2377937",								"808080"),
				person("Saltyboii",		 "",	   "Skip Countdown",	 "https://gamebanana.com/members/1948626",									"808080"),
				person("Sebbat",		 "",	   "Lua WaterMark",	 		"https://gamebanana.com/members/1995181",									"808080"),
				person("jarekboho",		 "",	   "Nene Script (Haxe)",	 			"https://gamebanana.com/members/2145650",					"808080"),
			]),

			section('Shaders', [
				person("TheZoroForce240",		        "",		        "RTX Shader",					  "https://gamebanana.com/members/1708748",		"808080"),
				person("Chara Maker",		        "",		        "Erect Shaders (fixed)",					  "https://gamebanana.com/members/4082914",		"7a6341"),
				person("Ledonic",		        "ledonic",		        "Drop Shadow Shader (fixed)",					  "https://gamebanana.com/members/3574043",		"3897FF"),
			]),

			section('Characters', [
				person("ChazbillYT",		        "",		        "BF alt animations",					  "https://gamebanana.com/members/2151108",	"808080"),
				person("B Side Corruption Bf",		        "",	 "glitched corrupt bf (edit by me)",	"https://gamebanana.com/members/2603529",	"808080"),
				person("FrancoFunk",		        "",		        "'angry' gf port",				"https://gamebanana.com/members/2023275",			"808080"),
				person("Ito Saihara",		        "",		        "'angry' gf og",					   "https://gamebanana.com/members/1792555",	"808080"),
				person("TopazowyGolem",		        "",		        "faceless bf",					"https://gamebanana.com/members/2488080",		"808080"),
				person("Obvious_pyro_lol",		        "",		   "corrupt glitch bf 2 (edit by me)",	"https://gamebanana.com/members/1792555",	"808080"),
				person("LeoroyX",		        "",	 "Made Halloween Skins for BF and GF",	"https://gamebanana.com/members/1984189",					"808080"),
				person("Mickle Pickle",		        "",		        "Pico Reskin (edit by me)",		"https://gamebanana.com/members/2023275",		"808080"),
				person("This is fine",		        "",		        "Made Erect BF & GF",				"https://gamebanana.com/members/1800297",	"808080"),
				person("chibisprinklez",		        "",		   "Made GF (playable)",	"https://gamebanana.com/members/2551278",					"808080"),
				person("Lc1230",		        "",		        "Cool BF",				"https://gamebanana.com/members/1839921",						"808080"),
				person("Paulcrew1077",		        "",		        "Hoodie GF",				"https://gamebanana.com/members/1958648",			"808080"),
				person("DylanTails876",		        "",		  "Character Select BF Speaker",			"https://gamebanana.com/members/1920694",		"808080"),
				person("BunBunDoodlez",		        "",		  "DJ BF",			"https://gamebanana.com/members/5172121",		"808080"),
				person("NoLime",		        "",		   "Christmas GF & BF",				"https://gamebanana.com/members/1762727",					"808080"),
				person("FNF Pibby Corrupted",	"",	"Glitched Characters for BF, GF, and Pico\n(this is NOT CANON)",	"https://gamebanana.com/mods/344757",	"808080"),
			]),

			section('Sprites/Assets', [
				person("Kaechii",		        "",		        "Week 1 & Week 9 Sprites",			"https://gamebanana.com/members/1826252",		"808080"),
				person("NoLime",		        "",	 		"Week 5 Sprites (vibin)",			"https://gamebanana.com/members/1762727",				"808080"),
				person("TreyTM",	"",      "Darkened Stage",										"https://gamebanana.com/members/1810603",			"808080"),
				person("obvious_pyro_lol",		"",			"deathmatch stage for psych engine",	"https://gamebanana.com/members/1858522",		"808080"),
				person("Fafnir G.",		"",			"Stage RTX (for Trouble)",						"https://gamebanana.com/members/1940560",		"808080"),
				person("Corruption Mod Recreation",	"",	 	"Lament & Dusk Stage Port",			"https://gamebanana.com/mods/490400",					"808080"),
				person("ChrisLad",	"",	 	"Mid Fight Masses HD Gray Church in Week 14",			"https://gamejolt.com/@ChrisLad",					"808080"),
				person("Vs. Tabi (V1)",	"tabi",      "Scared BF",		"https://gamebanana.com/mods/286388",	"f3c474"),
				person("pixel_ratto",		"",		"Scared BF & GF (pixel)",			"https://gamebanana.com/members/2004377",		"FF8080"),
				person("(._.)",		"",		"Expanded Pixel BF",			"https://gamebanana.com/members/1789351",		"000080"),
				person("OliverGamingAtPaperSchool",	"oliver",      "Noteskin (TABI)",		"https://www.youtube.com/@OliverGamingAtPaperSchool",	"c0c0c0"),
				person("Olivier99",		"",	"Future & Chip Noteskin (DIVIDE BY ZERO)",			"https://gamebanana.com/members/1860941",		"255d70"),
				person("DeliriousPersona",		"",	"Edit the DivideByZero Spritesheet",			"https://gamebanana.com/members/1779588",		"D4AF37"),
				person("RoboPuff",		"",	"RGB Support for DivideByZero Noteskins",			"https://gamebanana.com/members/2212648",		"ff80c0"),
				person("BloomEld",	"",      "Entity Noteskin (edit by me)\nShiny Noteskin RGB Support",		"https://gamebanana.com/members/2951815",	"800040"),
				person("Ghost1906081",	"",      "Original for Shiny Note",		"https://gamebanana.com/members/1906081",							"808080"),
				person("Indie Cross",		"indie-cross",			"Note Splash",						"https://gamejolt.com/games/indiecross/643540",					"000000"),
				person("FNF: ENTITY",		"entity",			"Noteskin",									"https://gamebanana.com/mods/284934",							"FF00FF"),
				person("Milanesa",		"bald",			"Mario's Madness Noteskin (Port)",			"https://gamebanana.com/members/2060195",					"808080"),
				person("Mario's Madness V2",		"mario-madness",			"Mario's Madness Noteskin (OG)",		"https://gamebanana.com/mods/359554",					"400000"),
				person("UrJust2Ez4Me",		"",			"Angry+Scared Custom BF Dialogue (add and edit by me)\nAngry BF",		"https://gamebanana.com/members/1740975",	"808080"),
				person("[ NAME ]",		"",			"Note Splashes (old ver & og forever ver)",		"https://gamebanana.com/members/2541091",	"505050"),
				person("JDVoidFNF",		"",			"Note Splashes (rgb forever ver)",		"https://gamebanana.com/members/4337031",	"FF4040"),
				person("Red-Bun",		"",			"Note Splashes (andromeda, yoshi, leather, & hope ver)",		"https://gamebanana.com/members/1812789",	"808080"),
				person("Andromeda Engine",		"AndromedaEngine",			"Note Splashes (andromeda engine ver)",		"https://github.com/nebulazorua/andromeda-engine-legacy",	"C080FF"),
				person("Forever Engine",		"ForeverEngine",			"Note Splashes (forever engine ver)",		"https://gamejolt.com/games/fnfforeverengine/692242",	"00FF80"),
				person("YoshCrafter Engine",		"YoshiEngine",			"Note Splashes (yoshi engine ver)",		"https://gamebanana.com/mods/352532",	"808080"),
				person("Hope Engine",		"",			"Note Splashes (hope engine ver)\nThere is a Download link but the mod is private :(",		"",	"808080"),
				person("Leather Engine",		"LeatherEngine",			"Note Splashes (leather engine ver)",		"https://gamebanana.com/mods/334945",	"0000FF"),
				person("Super Funkin' Galaxy",		"SuperFunkinGalaxy",			"Use their Soundbox Sounds & Assets",		"https://gamebanana.com/mods/444759",	"000080"),
				person("Rozebud",		"rozebud",			"FPS+ Winning Icons\nFPS+ Title Screen Reference",		"https://gamebanana.com/members/1767623",	"6000FF"),
				person("canUbeU",		"canUbeU",			"Pixel Pico, Senpai, & Spirit Winning Icons",		"https://gamebanana.com/members/4540535",	"808080"),
				person("B-Sides",		"bsides",			"Character Select (game over), Crazy & Cool Pixel Sprite (edit by me)",		"https://gamebanana.com/mods/42724",	"FF00FF"),
				person("YinaNoka",		"",			"Ok Pixel Sprite (edit by me)",		"https://gamebanana.com/members/1942955",	"79d6e0"),
				person("E-shrimp",		"",			"Crap/Awful Pixel Sprite (edit by me)",		"https://gamebanana.com/members/1874765",	"e0ab79"),
				person("te-agmaat032", "agmaat",		"Special Note Mechanics Pack (edit by me)",			"https://gamebanana.com/members/1769584",		"808080"),
				person("Punkinator7",	"Punkinator",	 "Special Note Mechanics Pack (edit by me)",			"https://gamebanana.com/members/1687904",			"ff9600"),
				person("Ciphernetics",	"",	 "Danger Note (edit by me)",			"https://gamebanana.com/members/1866642",			"008040"),
			]),

			section('Soundfont', [
				person("Ranified",		        "",		        "BF UTAU Soundfont Pack",			"https://gamebanana.com/members/2068912",		"808080"),
				person("ByAstroYT",		        "",		        "Pico Long Notes Soundfont Pack",			"https://gamebanana.com/members/2068912",		"808080"),
				person("Mix_Mix007",	"",	 "UTAU GF Sf2 for Corrupted GF, PxJx, and GF",			"https://gamebanana.com/members/1963292",					"808080"),
				person("LoganMcOof",	"",	 "Pico Tuned SF2 for Corrupted Pico",			"https://gamebanana.com/members/1807144",					"808080"),
				person("SamicomOfficial",	"",	 "BF SF2",			"https://gamebanana.com/members/1439763",					"808080"),
				person("TEC Again",	"",	 "Ultimate BF SF2",			"https://gamebanana.com/members/2170285",					"808080"),
				person("TheEighthBit",	"",	 "8Bits Soundfont for Mr. Glitch (only for FL Studio)",			"https://musical-artifacts.com/artifacts?q=TheEighthBit",					"808080"),
				person("FNF DJX", 	"",		"The Origin of The Soundfont for Me and MacOS Wario",			"https://gamebanana.com/mods/412412",	"808080"),
				person("Fujiwara Zach Watterson",		        "",		 "Void BF Soundfont",   "https://www.youtube.com/@ZachFujiwara",	"808080"),
			]),

			section('Other/Misc', [
				person("ChessyCessy",		        "",	 		"CYS Chart (Hard)",			"https://gamebanana.com/members/1817227",					"808080"),
				person("BunnyDeimos",	"",      "Detected Chart (Insane)",		"https://gamebanana.com/members/2045451",								"808080"),
				person("BradBox101",	"",      "Chiller ReChart (Hard & Insane)\n(Insane is made by me)",		"https://gamebanana.com/members/1951984",								"808080"),
				person("Booify",		"",			"High Effort Chart on Final Mix Remembrance",		"https://gamebanana.com/members/1780900",		"808080"),
				person("Antreys",		        "",	 		"helped with booify's Remembrance FM",		"https://gamebanana.com/members/2137542",		"808080"),
				person("Neo",				"",      		"gameOverEnd",					"https://gamebanana.com/mods/44230",						"808080"),
				person("Sonic.EXE Ring of Despair",	"",      "CYS Chart (Insane)",		"https://gamebanana.com/mods/350134",						"808080"),
				person("High Effort Chart on Final Mix Remembrance",	"",	 "Chart for Remebrance Final Mix",			"https://gamebanana.com/mods/430405",	"808080"),
				person("Nintendo",	"nintendo",	 "Mario Sounds and Music. (mostly Galaxy)",			"https://x.com/NintendoAmerica",			"FF0000"),
				person("Sega",	"sega",	 			"Combo Break Custom Sounds & Music",							"https://x.com/SEGA",											"0000FF"),
				person("Microslop",	"microsoft",	 			"Custom Menu Select Sounds\n(fuck ai slop bitch.)",							"https://x.com/Microsoft",									"00FF00"),
				person("The Mockupverse Wiki",	"mockupverse",	 			"Windows Zinc, 14 (old), 16, & 18\nStart-up for Several intros I used.",		"https://mockupverse.fandom.com/wiki/The_Mockupverse_Wiki",		"800000"),
				person("Newer Team",	"newerTeam",	 "Newer SMBWii Music",			"https://newerteam.com",			"C00000"),
			]),

			section('MIDIs & FLPs', [
				person("philip_pines4",		        "",		        "Opheebop",					       "https://onlinesequencer.net/members/68187",	"808080"),
				person("PhuTHGamer",		        "",		        "Week 3, Glitcher, Detected, Hungry (HQ), and Boogie",					       "https://gamebanana.com/members/2453340",	"808080"),
				person("StuffYT",		        "",		        "Cob",					       "https://onlinesequencer.net/members/69897",	"808080"),
				person("LTHS02",		        "",		        "Blue Balled (edit by me)",					       "https://gamebanana.com/members/2086713",	"808080"),
				person("BESTARTY",		        "",		        "Terminal",					       "",	"808080"),
				person("Dibujos Creativos Extra",		        "",		        "Ejected",					       "",	"808080"),
				person("GrimTKH",		        "",		        "Shiver",					       "https://onlinesequencer.net/members/66131",	"808080"),
				person("Control&Chaos",		        "",		        "Chiller",					"https://www.youtube.com/@Control_Chaos",	"808080"),
				person("Plucks_Dany",		        "",		        "Feliz & Hark",			"https://www.youtube.com/@Plucks_D4ny",	"808080"),
				person("Triazyze",		        "",		        "B-Side Eggnog",					       "https://www.youtube.com/@Yze3",	"808080"),
				person("Gman963",		        "",		        "Phantasm",			"https://www.instagram.com/Gman9630/",	"808080"),
				person("Penguin 123-452",		        "",		"Confronting Yourself",					  "https://www.youtube.com/@Penguin123452a",	"808080"),
				person("Smuko",		        "",		        "Danger",			"https://gamebanana.com/members/1775622",	"808080"),
				person("Skye",		        "",		        "Finale",			"https://www.youtube.com/@skyewithane__",	"808080"),
				person("DarthPaulRen",		        "",		        "Sunsets",			"https://www.youtube.com/@darthpaulren",	"808080"),
				person("Demar",		        "",		        "Always Here & Memories (modified)",				"https://www.youtube.com/@Demarcool",	"808080"),
				person("Luminator",		        "",		     "Star Festival",			"https://www.youtube.com/@Luminator",			"808080"),
				person("Fujiwara Zach Watterson",		        "",		 "Weightless, Stardust, My Battle, and Cooling",   "https://www.youtube.com/@ZachFujiwara",	"808080"),
				person("WhoIsTimothy",		        "",		"Blammed (edit by me)",		"https://www.youtube.com/@wtfistimothy",	"808080"),
				person("TurnipWxlfie",		        "",		 "Carefree",   "https://gamebanana.com/members/3558610",	"808080"),
				person("DanthUltima",		        "",		"High Erect",		"https://www.youtube.com/@DanthUltima",	"808080"),
				person("WeedLord The Monika Simp",		        "",		 "Lo-Fight & Godrays",   "https://www.youtube.com/@WeedLordTheMonikaSimp",	"808080"),
				person("FriskyWasTaken",		        "",		        "Double Kill & Stargazer",		"https://www.youtube.com/@friskywastaken",	"808080"),
				person("Lincolnjohn1111",		        "",		 "Dejection & Unknown Suffering",   "https://www.youtube.com/@lincolnjohn1111",	"808080"),
				person("Ghost2811277",		        "",		 "Defeat B-Side",   "https://gamebanana.com/members/2811277",	"808080"),
				person("Nafri",		        "",		        "Angered Him",		"https://www.youtube.com/@Nafri4166",	"808080"),
				person("DerekNotEric",		        "",		 "Whitroll (edit by someone)",   "https://onlinesequencer.net/members/41200",	"808080"),
				person("serenamakescovers",		        "",		 "Trouble & Tormentor",   "https://onlinesequencer.net/members/63884",	"808080"),
				person("veloci",		        "",		 "Onslaught",   "https://gamebanana.com/members/2890077",	"808080"),
				person("Ivory muse1",		        "",		        "You Can't Run",		"https://www.youtube.com/@ivorymuse12",	"808080"),
				person("Flipworksinstuff",		        "",		 "Best Girl",   "https://www.youtube.com/@flipworksinstuff9594",	"808080"),
				person("JanreyGameFNF",		        "",		 "M.I.L.F.",   "https://gamebanana.com/members/2541758",	"808080"),
				person("SPIKE Funkin",		        "",		 "Reactor",   "",	"808080"),
				person("Digital Hourglass",		        "digi",		     "Barrel Roll\n(hint for flp: it's in his Discord Server)",		"https://www.youtube.com/@DigitalHourglass",   "0000FF"),
				person("Savestate Corrupted",		        "",		 "Cinnamon",   "https://gamebanana.com/members/1914394",	"808080"),
				person("Katorrox",		        "",		 "Glitcher Remix",   "https://www.youtube.com/@Katorroxx_",	"808080"),
				person("EthanTheDoodler",		        "",		 "Sabotage",   "https://x.com/D00dlerEthan",	"808080"),
				person("ZerWhit",		        "",		 "Meltdown",   "https://gamebanana.com/members/2191699",	"808080"),
				person("ElverGalarga",		        "",		 "Oversight",   "https://onlinesequencer.net/members/106490",	"808080"),
				person("Psion3",		        "",		 "Salty's Love",   "https://gamebanana.com/members/3531946",	"808080"),
				person("ACMD",		        "",		 "Twiddlefinger",   "https://gamebanana.com/members/2069195",	"808080")
			]),

			section('Code', [
				person("MrpoloOfficial",		        "polo",		        "Intro & Outro Video States (edit by me)",			"https://gamebanana.com/members/2307558",	"663333"),
				person("DarDevv",		        "",		        "Bios State (edit by me)",			"https://gamebanana.com/members/2014882",	"808080"),
				person("Lenin Anonimo",		        "len",		        "For Using Several of their Code",			"https://gamebanana.com/members/3509758",	"03FC88"),
				person("Lucas-Sanches",		        "lucas",		        "For using the code for Converters State\n(& Legacy Converters State)",			"https://gamebanana.com/members/2088040",	"FF8000"),
				person("Timeless",		  "timeless",		      "The Note Event Animation in Title State when you enter the game.",			"https://gamebanana.com/members/5828656",	"200040"),
				person("TBar09",		  "tbar",		      "For hxWindowColorMode Libary",			"https://github.com/TBar09",	"0077CC"),
				person("SquidBowl",		    "tinkatonk",		"GalleryState (edit by me)",			"https://gamebanana.com/members/2041479",	"804000"),
			]),

			section('P-Slice Engine Team', [
				person('Mikolka9144',	'mikolka',	'The lead for the mod',	'https://gamebanana.com/members/3329541',	'2ebcfa'),
			]),

			section('P-Slice Contributors', [
				person('Derpy The Hedgeone',	'derpy',			'Made a lot of PRs to the repo',	'https://github.com/DerpyTheHedgeone',	'd86b00'),
				person('Mykarm',	'mykarm',	'Made the new icon and promational art for P-Slice',		'https://x.com/cronviersmeat/status/1849059676467417311?s=46&t=4dcTT7PAMkRJ8zYd4LgTow',	'29170a'),
				person('Fazecarl',	'fazecarl',		'Made the new logo for P-Slice',		'https://gamebanana.com/members/2121406',	'29170a'),
			]),

			section('Psych Engine Team', [
				person('Shadow Mario', 'shadowmario', 'Main Programmer and Head of Psych Engine', 'https://ko-fi.com/shadowmario', '444444'),
				person('Riveren', 'riveren', 'Main Artist/Animator of Psych Engine', 'https://x.com/riverennn', '14967B'),
			]),

			section('Former Psych Engine Members', [
				person('bb-panzu', 'bb', 'Ex-Programmer of Psych Engine', 'https://x.com/bbsub3', '3E813A'),
			]),

			section('Engine Contributors', [
				person('crowplexus', 'crowplexus', 'Linux Support, HScript Iris, Input System v3, and Other PRs', 'https://twitter.com/IamMorwen', 'CFCFCF'),
				person('Kamizeta', 'kamizeta', "Creator of Pessy, Psych Engine's mascot.", 'https://www.instagram.com/cewweey/', 'D21C11'),
				person('MaxNeton', 'maxneton', 'Loading Screen Easter Egg Artist/Animator.', 'https://bsky.app/profile/maxneton.bsky.social', '3C2E4E'),
				person('Keoiki', 'keoiki', 'Note Splash Animations and Latin Alphabet', 'https://x.com/Keoiki_', 'D2D2D2'),
				person('SqirraRNG', 'sqirra', "Crash Handler and Base code for\nChart Editor's Waveform", 'https://x.com/gedehari', 'E1843A'),
				person('EliteMasterEric', 'mastereric', 'Runtime Shaders support and Other PRs', 'https://x.com/EliteMasterEric', 'FFBD40'),
				person('MAJigsaw77', 'majigsaw', 'Android extensions, hxluajit, and the\n.MP4 Video Loader Library (hxvlc)', 'https://x.com/MAJigsaw77', '5F5F5F'),
				person('iFlicky', 'flicky', 'Composer of Psync and Tea Time\nAnd some sound effects', 'https://x.com/flicky_i', '9E29CF'),
				person('KadeDev', 'kade', 'Fixed some issues on Chart Editor and Other PRs', 'https://x.com/kade0912', '64A250'),
				person('superpowers04', 'superpowers04', 'LUA JIT Fork', 'https://x.com/superpowers04', 'B957ED'),
				person('CheemsAndFriends', 'cheems', 'Creator of FlxAnimate', 'https://x.com/CheemsnFriendos', 'E1E1E1'),
			]),

			section("Funkin' Crew", [
				person('ninjamuffin99', 'ninjamuffin99', "Programmer of Friday Night Funkin'", 'https://x.com/ninja_muffin99', 'CF2D2D'),
				person('PhantomArcade', 'phantomarcade', "Animator of Friday Night Funkin'", 'https://x.com/PhantomArcade3K', 'FADC45'),
				person('evilsk8r', 'evilsk8r', "Artist of Friday Night Funkin'", 'https://x.com/evilsk8r', '5ABD4B'),
				person('kawaisprite', 'kawaisprite', "Composer of Friday Night Funkin'", 'https://x.com/kawaisprite', '378FC7'),
			]),
		];
	}

	/**
		Builds an engine `CreditSection` (no owning mod).
		@param name the section title
		@param people the section's members
		@param color optional section-wide accent colour (hex string)
		@return the section
	**/
	static inline function section(name:String, people:Array<CreditPerson>, ?color:String):CreditSection {
		return {
			name: name,
			people: people,
			modFolder: null,
			background: null,
			color: color
		};
	}

	/**
		Builds a `CreditPerson`.
		@param name the display name
		@param icon icon image key (bare names are resolved under `credits/`), or `''`/null for none
		@param role the role/description text (`\n` allowed)
		@param link either a single URL `String` (auto-labelled from its domain) or an
			   `Array<CreditLink>` for multiple links (each `{label, url}`; a blank label falls back to
			   the URL's domain). Every existing single-URL call keeps working unchanged.
		@param color the accent colour as a hex string
		@param modFolder owning mod folder for asset resolution, or null for engine credits
		@return the person
	**/
	static function person(name:String, icon:String, role:String, link:Dynamic, color:String, ?modFolder:String):CreditPerson {
		var links:Array<CreditLink> = [];
		if (Std.isOfType(link, String)) {
			var url:String = cast link;
			if (url.length > 4)
				links.push({label: linkLabel(url), url: url});
		} else if (Std.isOfType(link, Array)) {
			var arr:Array<CreditLink> = cast link;
			for (l in arr)
				if (l != null && l.url != null && l.url.length > 0)
					links.push({label: (l.label != null && l.label.length > 0) ? l.label : linkLabel(l.url), url: l.url});
		}
		return {
			name: name,
			icon: normalizeAsset(icon),
			role: role,
			color: color,
			background: null,
			links: links,
			modFolder: modFolder
		};
	}

	#if MODS_ALLOWED
	/**
		Loads a mod's credit sections, preferring its `data/credits.json` (language-specific variant
		first) and falling back to a legacy `data/credits.txt`.
		@param folder the mod folder name
		@return the mod's sections, or an empty array when it ships no credits file
	**/
	static function loadModSections(folder:String):Array<CreditSection> {
		var modName:String = folder;
		var pack:Dynamic = Mods.getPack(folder);
		if (pack != null && Reflect.field(pack, 'name') != null)
			modName = Reflect.field(pack, 'name');

		var jsonPath:String = firstExisting([
			#if TRANSLATIONS_ALLOWED Paths.mods(folder + '/data/credits-${ClientPrefs.data.language}.json'), #end
			Paths.mods(folder + '/data/credits.json')
		]);

		if (jsonPath != null)
			return parseModJson(jsonPath, folder, modName);

		var txtPath:String = firstExisting([
			#if TRANSLATIONS_ALLOWED Paths.mods(folder + '/data/credits-${ClientPrefs.data.language}.txt'), #end
			Paths.mods(folder + '/data/credits.txt')
		]);

		if (txtPath != null)
			return [parseModTxt(txtPath, folder, modName)];

		return [];
	}

	/**
		Parses a mod's `credits.json`. Accepts either a top-level `sections` array or a single bare
		section object. Malformed JSON is logged and treated as no credits.
		@param path the file path
		@param folder the owning mod folder
		@param modName the section name to fall back to (the mod's pack name)
		@return the parsed sections, or an empty array on failure
	**/
	static function parseModJson(path:String, folder:String, modName:String):Array<CreditSection> {
		try {
			var data:Dynamic = CoolUtil.parseJson(File.getContent(path));
			if (data == null)
				return [];

			var rawSections:Array<Dynamic> = Reflect.field(data, 'sections');
			if (rawSections != null) {
				var out:Array<CreditSection> = [];
				for (s in rawSections)
					out.push(parseSectionObj(s, folder, modName));
				return out;
			}
			return [parseSectionObj(data, folder, modName)];
		} catch (e:Dynamic) {
			trace('CreditsData: failed to parse $path -- $e');
			return [];
		}
	}

	/**
		Parses one section object from mod JSON, reading its name from `section` or `name`.
		@param obj the raw JSON section object
		@param folder the owning mod folder
		@param fallbackName the name to use when the object names neither `section` nor `name`
		@return the parsed section
	**/
	static function parseSectionObj(obj:Dynamic, folder:String, fallbackName:String):CreditSection {
		var name:String = strField(obj, 'section');
		if (name == null)
			name = strField(obj, 'name');
		if (name == null)
			name = fallbackName;

		var people:Array<CreditPerson> = [];
		var rawPeople:Array<Dynamic> = Reflect.field(obj, 'people');
		if (rawPeople != null)
			for (p in rawPeople)
				people.push(parsePersonObj(p, folder));

		return {
			name: name,
			people: people,
			modFolder: folder,
			background: normalizeAsset(strField(obj, 'background')),
			color: strField(obj, 'color')
		};
	}

	/**
		Parses one person object from mod JSON. Links come from a `links` array (`{label, url}`); when
		absent, a single `link` URL is used as a fallback.
		@param p the raw JSON person object
		@param folder the owning mod folder
		@return the parsed person
	**/
	static function parsePersonObj(p:Dynamic, folder:String):CreditPerson {
		var links:Array<CreditLink> = [];
		var rawLinks:Array<Dynamic> = Reflect.field(p, 'links');
		if (rawLinks != null) {
			for (l in rawLinks) {
				var url:String = strField(l, 'url');
				if (url != null && url.length > 0) {
					var label:String = strField(l, 'label');
					links.push({label: label != null ? label : linkLabel(url), url: url});
				}
			}
		} else {
			var single:String = strField(p, 'link');
			if (single != null && single.length > 4)
				links.push({label: linkLabel(single), url: single});
		}

		return {
			name: strField(p, 'name'),
			icon: normalizeAsset(strField(p, 'icon')),
			role: strField(p, 'role'),
			color: strField(p, 'color'),
			background: normalizeAsset(strField(p, 'background')),
			links: links,
			modFolder: folder
		};
	}

	/**
		Parses a legacy `credits.txt` into a single section. Each non-blank line is one person with
		`::`-separated fields (`name::icon::role::link::color`); literal `\n` in a field becomes a line
		break.
		@param path the file path
		@param folder the owning mod folder
		@param modName the section name (the mod's pack name)
		@return the parsed section
	**/
	static function parseModTxt(path:String, folder:String, modName:String):CreditSection {
		var people:Array<CreditPerson> = [];
		for (line in File.getContent(path).split('\n')) {
			if (line.trim().length == 0)
				continue;

			var arr:Array<String> = line.replace('\\n', '\n').split('::');
			if (arr[0] == null || arr[0].trim().length == 0)
				continue;

			people.push(person(arr[0], arr.length > 1 ? arr[1] : null, arr.length > 2 ? arr[2] : null, arr.length > 3 ? arr[3] : null,
				arr.length > 4 ? arr[4] : null, folder));
		}
		return {
			name: modName,
			people: people,
			modFolder: folder,
			background: null,
			color: null
		};
	}
	#end

	/**
		@param paths candidate file paths, in priority order
		@return the first path that exists on disk, or null if none do
	**/
	static function firstExisting(paths:Array<String>):String {
		#if sys
		for (p in paths)
			if (p != null && FileSystem.exists(p))
				return p;
		#end
		return null;
	}

	/**
		Reads a field off a dynamic JSON object as a string.
		@param obj the object
		@param field the field name
		@return the field stringified, or null when absent
	**/
	static inline function strField(obj:Dynamic, field:String):String {
		var v:Dynamic = Reflect.field(obj, field);
		return (v != null) ? Std.string(v) : null;
	}

	/**
		Normalizes an icon/background asset key: a bare name is resolved under `credits/`, a name that
		already contains a `/` is left as-is.
		@param name the raw asset name
		@return the normalized key, or null when empty
	**/
	static function normalizeAsset(name:String):String {
		if (name == null || name.length == 0)
			return null;
		return (name.indexOf('/') < 0) ? 'credits/' + name : name;
	}

	/**
		Derives a short link label from a URL: its domain, with the scheme and a leading `www.` stripped.
		@param url the URL
		@return the domain (or the original URL if no domain could be extracted)
	**/
	static function linkLabel(url:String):String {
		var s:String = url;
		var p:Int = s.indexOf('://');
		if (p >= 0)
			s = s.substr(p + 3);
		if (s.startsWith('www.'))
			s = s.substr(4);

		var slash:Int = s.indexOf('/');
		if (slash >= 0)
			s = s.substr(0, slash);
		return s.length > 0 ? s : url;
	}
}
