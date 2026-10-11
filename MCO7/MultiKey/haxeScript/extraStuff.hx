import tjson.TJSON;
import flixel.util.FlxSort;
import backend.Difficulty;
import backend.MusicBeatState;
import backend.Song;
import objects.Note;

var keyBinds:Array<Array<String>> = [];
var keyCount:Int = 0;

var scriptPath:String;
var multiKey:Bool = true;

function onCreate() {

    var name:String = getChartString();
    var json:Dynamic = TJSON.parse(Paths.getTextFromFile(name));

    if (json.song != null && json.song.keyCount != null) keyCount = json.song.keyCount;
    else if (json.keyCount != null) keyCount = json.keyCount;
    else {
        multiKey = false;
        return Function_Stop;
    }

    switch(keyCount) {
        case 1:
            scriptPath = 'haxeScript/Keys/1K.hx';
        case 2:
            scriptPath = 'haxeScript/Keys/2K.hx';
        case 3:
            scriptPath = 'haxeScript/Keys/3K.hx';
        case 5:
            scriptPath = 'haxeScript/Keys/5K.hx';
        case 6:
            scriptPath = 'haxeScript/Keys/6K.hx';
        case 7:
            scriptPath = 'haxeScript/Keys/7K.hx';
        case 8:
            scriptPath = 'haxeScript/Keys/8K.hx';
        case 9:
            scriptPath = 'haxeScript/Keys/9K.hx';
        default:
            if (keyCount != 4) {
                game.addTextToDebug("No valid keycount found!", 0xFFFF0000);
            }
            multiKey = false;
            return Function_Stop;
    }

    if (!Paths.fileExists(scriptPath)) {
        game.addTextToDebug("Script " + scriptPath + " could not be found! Disabling.", 0xFFFF0000);
        multiKey = false;
        return Function_Stop;
    }
    loadKeyBinds();
    game.startHScriptsNamed(scriptPath);
}

function onUpdate(elapsed:Float) {
    if (multiKey) {
        var controls:Array<Array<Array<Bool>>> = [];
        var botPlay:Bool = game.cpuControlled; //call it here for people in charting mode

        for (i in 0...keyCount) {
            controls[i] = [];
            for (key in 0...keyBinds[i].length) {
                controls[i].push([keyboardJustPressed(StringTools.trim(keyBinds[i][key].toUpperCase())), keyboardPressed(StringTools.trim(keyBinds[i][key].toUpperCase()))]);
            }

            var shouldStatic:Bool = true;
            for (check in 0...controls[i].length) {

                var curKey:Array<Bool> = controls[i][check];

                if (curKey[0] && !botPlay) {
                    figureOutHit(i);
                    shouldStatic = false;
                } else if (curKey[1] && !botPlay) {
                    for (note in notes.members) {
                        if (note == null) continue;

                        if (note.mustPress && note.noteData == i && note.isSustainNote && note.canBeHit && !note.wasGoodHit)
                        {
                            game.goodNoteHit(note);
                        }
                    }
                    shouldStatic = false;
                }
            }

            if (shouldStatic && !botPlay) playerStrums.members[i].playAnim("static");
        }
    }
}

function onCreatePost() {
    if (multiKey) {
        for (note in unspawnNotes) {
            if (note.isSustainNote) note.noteSplashData.disabled = true;
        }
    }
}

function onKeyPressPre(key:Int) if (multiKey) return Function_Stop;

function onKeyReleasePre(key:Int) if (multiKey) return Function_Stop;

function onGhostTap(key:Int) {
    if (multiKey) {
        playerStrums.members[key].playAnim('pressed');
        playerStrums.members[key].resetAnim = 0;
    }
}

function opponentNoteHit(note:Note) {
    if (multiKey) {
        opponentStrums.members[note.noteData].playAnim('confirm', true);
        opponentStrums.members[note.noteData].resetAnim = Conductor.stepCrochet * 1.25 / 1000 / game.playbackRate;
        if (note.isSustainNote) {
            note.clipToStrumNote(opponentStrums.members[note.noteData]);
            note.wasGoodHit = true;
        } else invalidateNote(note);

        dad.holdTimer = 0;
    }
}

var skipArrowStartTween:Bool = false;

function onCountdownStarted() {
    if (skipCountdown) skipArrowStartTween = true;
}


//CUSTOM FUNCTIONS
///////////////////////////////////////////////////////////////////


function getChartString():String {
    if (Difficulty.getString(false) == 'normal') {
        return 'data/' + Song.loadedSongName + '/' + Song.loadedSongName + '.json';
    } else {
        return 'data/' + Song.loadedSongName + '/' + Song.loadedSongName + '-' + Difficulty.getString().toLowerCase() + '.json';
    }
}

function loadKeyBinds() {
    var text:String = Paths.getTextFromFile('Keybinds ' + keyCount + 'K.txt');
    
    if (text != null && text != '') {
        var fakeArray:Array<String> = text.split('||');
        for (i in 0...keyCount) keyBinds.push(fakeArray[i].toUpperCase().split(','));
    } else if (text == null || text == '' || keyBinds.length < keyCount) {
        game.addTextToDebug("No valid multikey keybinds found! Enabling BotPlay.", 0xFFFF0000);
        game.cpuControlled = true;
        for (i in 0...keyCount) keyBinds[i] = ['null'];
    }

    switch(keyCount) {
        case 1:
            if (keyBinds == null || keyBinds.length < keyCount) keyBinds = [['SPACE', 'null']];
        case 2:
            if (keyBinds == null || keyBinds.length < keyCount) keyBinds = [['A', 'LEFT'], ['D', 'RIGHT']];
        case 3:
            if (keyBinds == null || keyBinds.length < keyCount) keyBinds = [['A', 'LEFT'], ['S', 'DOWN'], ['D', 'RIGHT']];
        case 5:
            if (keyBinds == null || keyBinds.length < keyCount) keyBinds = [['A', 'LEFT'], ['S', 'DOWN'], ['SPACE', 'null'], 
                ['W', 'UP'], ['D', 'RIGHT']];
        case 6:
            if (keyBinds == null || keyBinds.length < keyCount) keyBinds = [['A', 'LEFT'], ['S', 'DOWN'], ['D', 'RIGHT'], 
                ['J', 'null'], ['K', 'null'], ['L', 'null']];
        case 7:
            if (keyBinds == null || keyBinds.length < keyCount) keyBinds = [['A', 'LEFT'], ['S', 'DOWN'], ['D', 'RIGHT'], ['SPACE', 'null'], 
                ['J', 'null'], ['K', 'null'], ['L', 'null']];
        case 8:
            if (keyBinds == null || keyBinds.length < keyCount) keyBinds = [['A', 'LEFT'], ['S', 'DOWN'], ['D', 'RIGHT'], ['F', 'null'],
                ['H', 'null'], ['J', 'null'], ['K', 'null'], ['L', 'null']];
        case 9:
            if (keyBinds == null || keyBinds.length < keyCount) keyBinds = [['A', 'LEFT'], ['S', 'DOWN'], ['D', 'RIGHT'], ['F', 'null'], ['SPACE', 'null'], 
                ['H', 'null'], ['J', 'null'], ['K', 'null'], ['L', 'null']];
    }
}

function tweenNoteIn(player:Int, strum:StrumNote) {
    var targetAlpha:Float = 1;
	if (player < 1)
	{
		if (!ClientPrefs.data.opponentStrums)
			targetAlpha = 0;
		else if (ClientPrefs.data.middleScroll)
			targetAlpha = 0.35;
	}

	if (!game.isStoryMode && !skipArrowStartTween)
	{
		strum.alpha = 0;
		FlxTween.tween(strum, {alpha: targetAlpha}, 1, {ease: FlxEase.circOut,	startDelay: 0.5 + (0.2 * strum.noteData)});
	}
	else
	{
		strum.alpha = targetAlpha;
	}
}


function figureOutHit(key:Int) {
    // obtain notes that the player can hit
	var plrInputNotes:Array<Note> = notes.members.filter(function(n:Note):Bool {
		var canHit:Bool = n != null && !strumsBlocked[n.noteData] && n.canBeHit && n.mustPress && !n.tooLate && !n.wasGoodHit && !n.blockHit;
		return canHit && !n.isSustainNote && n.noteData == key;
	});
	plrInputNotes.sort(sortHitNotes);

	if (plrInputNotes.length != 0) { // slightly faster than doing `> 0` lol
		var funnyNote:Note = plrInputNotes[0]; // front note

		if (plrInputNotes.length > 1) {
			var doubleNote:Note = plrInputNotes[1];
			if (doubleNote.noteData == funnyNote.noteData) {
				// if the note has a 0ms distance (is on top of the current note), kill it
				if (Math.abs(doubleNote.strumTime - funnyNote.strumTime) < 1.0)
					invalidateNote(doubleNote);
				else if (doubleNote.strumTime < funnyNote.strumTime)
				{
					// replace the note if its ahead of time (or at least ensure "doubleNote" is ahead)
					funnyNote = doubleNote;
				}
			}
		}
		game.goodNoteHit(funnyNote);
    } else {
		if (ClientPrefs.data.ghostTapping)
			onGhostTap(key);
		else
			game.noteMissPress(key);
    }
}

function sortHitNotes(a:Note, b:Note):Int
{
	if (a.lowPriority && !b.lowPriority)
		return 1;
	else if (!a.lowPriority && b.lowPriority)
		return -1;

	return FlxSort.byValues(FlxSort.ASCENDING, a.strumTime, b.strumTime);
}

function invalidateNote(note:Note):Void {
	note.kill();
	notes.remove(note, true);
	note.destroy();
}

function updateNoteDatas() {
    for (note in unspawnNotes) {

        if (note.noteType == 'Hurt Note') note.extraData.set('canChangeRGB', false);

        if (note.extraData.get("realData") != null) note.noteData = Std.parseInt(note.extraData.get("realData"));

        if (note.noteData > keyCount - 1) note.noteData = 0;
    }
}

function getMultiTexture(texture:String):String {
    if (Paths.fileExists('images/noteSkins/NOTE_assets' + Note.getNoteSkinPostfix() + '-multi.png', 'IMAGE') && (texture == '' || texture == null)) return 'noteSkins/NOTE_assets' + Note.getNoteSkinPostfix() + '-multi';
    else if (Paths.fileExists('images/' + texture + '-multi.png', 'IMAGE')) return texture + '-multi';
    else return 'noteSkins/NOTE_assets-multi'; //idk how youd fuck up this bad but just in case!
}