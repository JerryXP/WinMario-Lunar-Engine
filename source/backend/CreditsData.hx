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
			section('Lunar Engine', [
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
				],	'8000FF'),
			]),
			
			section('Special Thanks', [
				person("TintGox",		 "tintgox",	   "Helped me with Kade Engine Color Timebar",	 "https://www.youtube.com/@tintgox10",		"008080"),
				person("yoshifan66",	"yoshifan66",	"Helped with MultiKey Note Support\n(I know that MCO7's Multi Key support had failed, but hey, I tried.)",		"https://www.youtube.com/@yoshifan66-h",	"00FF00"),
			]),

			section('Scripts', [
				person("Uhard999",		        "",		        "Watermark and Health",					  "https://gamebanana.com/members/1872659",	"808080"),
				person("Stilic",		        "",		        "Note Combo",					  "https://gamebanana.com/members/1893262",				"808080"),
				person("Rodney~ An Imaginative Furball",		    "",		  "Stage Changer",	"https://gamebanana.com/members/1729833",				"808080"),
				person("vCherry.kAI.16",		 "",	   "Combo break = gf cry",	 "https://gamebanana.com/members/1921624",							"808080"),
				person("SadSami",		 "",	   "Break Time/Note Timer Script",	 			"https://gamebanana.com/members/3418239",				"808080"),
				person("MCO7",		 "",	   "Psych Engine 1.0 Skin Selector\n, Beta BF Winning Icon",	 		"https://www.youtube.com/@MC0777",		"808080"),
				person("Super_Hugo",	 "",		 "Blammed Lights & Philly Glow Recreation",		"https://gamebanana.com/members/2151945",			"808080"),
				person("BlixerTheGamebananer",	"",	 "Combo Break Sound Script",			"https://gamebanana.com/members/2179280",			"FF0000"),
				person("RamenDominoes",		        "",		        "Cinematics",					  "https://gamebanana.com/members/2135195",		"808080"),
				person("Ghost1787581",		        "",		        "Note Offset Pop-up",					  "https://gamebanana.com/members/1787581",		"808080"),
				person("BloonyFox",		        "bloonyfox",		        "Icon Colored Strumlines & Notes",					  "https://gamebanana.com/members/2751687",		"808080"),
				person("blobbert",		        "",		        "Opponent Note Color (for legacy purposes)",					  "https://gamebanana.com/members/2723067",		"808080"),
				person("DaPootisBirdYT",		        "",		        "Winning Icon",					  "https://gamebanana.com/members/2031145",		"808080"),
			]),

			section('Shaders', [
				person("TheZoroForce240",		        "",		        "RTX Shader",					  "https://gamebanana.com/members/1708748",		"808080"),
				person("Chara Maker",		        "",		        "Erect Shaders (fixed)",					  "https://gamebanana.com/members/4082914",		"808080"),
				person("Ledonic",		        "",		        "Drop Shadow Shader (fixed)",					  "https://gamebanana.com/members/3574043",		"808080"),
			]),

			section('Sprites/Assets', [
				person("Vs. Tabi (V1)",	"",      "Scared BF",		"https://gamebanana.com/mods/286388",	"808080"),
				person("pixel_ratto",		"",		"Scared BF & GF (pixel)",			"https://gamebanana.com/members/2004377",		"808080"),
				person("(._.)",		"",		"Expanded Pixel BF",			"https://gamebanana.com/members/1789351",		"808080"),
				person("OliverGamingAtPaperSchool",	"",      "Noteskin (TABI)",		"https://www.youtube.com/@OliverGamingAtPaperSchool",	"808080"),
				person("Olivier99",		"",	"Future & Chip Noteskin (DIVIDE BY ZERO)",			"https://gamebanana.com/members/1860941",		"808080"),
				person("DeliriousPersona",		"",	"Edit the DivideByZero Spritesheet",			"https://gamebanana.com/members/1779588",		"808080"),
				person("RoboPuff",		"",	"RGB Support for DivideByZero Noteskins",			"https://gamebanana.com/members/2212648",		"808080"),
				person("BloomEld",	"",      "Entity Noteskin (edit by me)\nShiny Noteskin RGB Support",		"https://gamebanana.com/members/2951815",	"808080"),
				person("Ghost1906081",	"",      "Original for Shiny Note",		"https://gamebanana.com/members/1906081",							"808080"),
				person("Indie Cross",		"",			"Note Splash",						"https://gamejolt.com/games/indiecross/643540",					"808080"),
				person("FNF: ENTITY",		"",			"Noteskin",									"https://gamebanana.com/mods/284934",							"808080"),
				person("Milanesa",		"bald",			"Mario's Madness (Port)",			"https://gamebanana.com/members/2060195",					"808080"),
				person("Mario's Madness V2",		"",			"Mario's Madness Noteskin (OG)",		"https://gamebanana.com/mods/359554",					"808080"),
				person("UrJust2Ez4Me",		"",			"Angry+Scared Custom BF Dialogue (add and edit by me)\nAngry BF",		"https://gamebanana.com/members/1740975",	"808080"),
				person("[ NAME ]",		"",			"Note Splashes (old ver & og forever ver)",		"https://gamebanana.com/members/2541091",	"808080"),
				person("JDVoidFNF",		"",			"Note Splashes (rgb forever ver)",		"https://gamebanana.com/members/4337031",	"808080"),
				person("Red-Bun",		"",			"Note Splashes (andromeda, yoshi, leather, & hope ver)",		"https://gamebanana.com/members/1812789",	"808080"),
				person("Andromeda Engine",		"",			"Note Splashes (andromeda engine ver)",		"https://github.com/nebulazorua/andromeda-engine-legacy",	"808080"),
				person("Forever Engine",		"",			"Note Splashes (forever engine ver)",		"https://gamejolt.com/games/fnfforeverengine/692242",	"808080"),
				person("YoshCrafter Engine",		"",			"Note Splashes (yoshi engine ver)",		"https://gamebanana.com/mods/352532",	"808080"),
				person("Hope Engine",		"",			"Note Splashes (hope engine ver)\nThere is a Download link but the mod is private :(",		"",	"808080"),
				person("Leather Engine",		"",			"Note Splashes (leather engine ver)",		"https://gamebanana.com/mods/334945",	"808080"),
				person("Super Funkin' Galaxy",		"",			"Use their Soundbox Sounds & Assets",		"https://gamebanana.com/mods/444759",	"000080"),
				person("Rozebud",		"",			"FPS+ Winning Icons\nFPS+ Title Screen Reference",		"https://gamebanana.com/members/1767623",	"808080"),
				person("canUbeU",		"",			"Pixel Pico, Senpai, & Spirit Winning Icons",		"https://gamebanana.com/members/4540535",	"808080"),
				person("B-Sides",		"",			"Character Select (game over), Crazy & Cool Pixel Sprite (edit by me)",		"https://gamebanana.com/mods/42724",	"808080"),
				person("YinaNoka",		"",			"Ok Pixel Sprite (edit by me)",		"https://gamebanana.com/members/1942955",	"808080"),
				person("E-shrimp",		"",			"Crap/Awful Pixel Sprite (edit by me)",		"https://gamebanana.com/members/1874765",	"808080"),
				person("FaithfulBunny0",		"",			"Made a Alt Animations for Pico",		"https://gamebanana.com/members/3873890",	"808080"),
				person("Gox491",		"",			"Made a Alt Animations for BF Xmas",		"https://gamebanana.com/members/3873890",	"808080"),
				person("te-agmaat032", "",		"Special Note Mechanics Pack (edit by me)",			"https://gamebanana.com/members/1769584",		"808080"),
				person("Punkinator7",	"",	 "Special Note Mechanics Pack (edit by me)",			"https://gamebanana.com/members/1687904",			"808080"),
				person("Ciphernetics",	"",	 "Danger Note (edit by me)",			"https://gamebanana.com/members/1866642",			"808080"),
				person("DylanTails876",		        "",		  "Character Select BF Speaker",			"https://gamebanana.com/members/1920694",		"808080"),
				person("This is fine",		        "",		        "Made Erect BF (use to replace boring GF that y'all like to lust)",				"https://gamebanana.com/members/1800297",	"808080"),
			]),

			section('Other/Misc', [
				person("Nintendo",	"",	 "Mario Sounds and Music. (mostly Galaxy)",			"https://x.com/NintendoAmerica",			"FF0000"),
				person("Sega",	"",	 			"Combo Break Custom Sounds & Music",							"https://x.com/SEGA",											"0000FF"),
				person("Microslop",	"",	 			"Custom Menu Select Sounds\n(fuck ai slop bitch.)",							"https://x.com/Microsoft",									"00FF00"),
				person("The Mockupverse Wiki",	"",	 			"Windows Zinc, 14 (old), 16, & 18\nStart-up for Several intros I used.",		"https://mockupverse.fandom.com/wiki/The_Mockupverse_Wiki",		"800000"),
				person("Newer Team",	"",	 "Newer SMBWii Music",			"https://newerteam.com",			"C00000"),
			]),

			section('Code', [
				person("MrpoloOfficial",		        "",		        "Intro & Outro Video States (edit by me)",			"https://gamebanana.com/members/2307558",	"808080"),
				person("Lenin Anonimo",		        "",		        "For Using Several of their Code",			"https://gamebanana.com/members/3509758",	"6000C0"),
				person("Lucas-Sanches",		        "",		        "For using the code for Converters State\n(& Legacy Converters State)",			"https://gamebanana.com/members/2088040",	"FFFF00"),
				person("Timeless",		  "timeless",		      "The Note Event Animation in Title State when you enter the game.",			"https://gamebanana.com/members/5828656",	"804000"),
				person("TBar09",		  "",		      "For hxWindowColorMode Libary",			"https://github.com/TBar09",	"003062"),
				person("SquidBowl",		    "tinkatonk",		"GalleryState (edit by me)",			"https://gamebanana.com/members/2041479",	"2ebcfa"),
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
