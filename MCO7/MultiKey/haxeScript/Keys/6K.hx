import flixel.FlxG;

import backend.ClientPrefs;

import objects.StrumNote;

function onCreatePost() {
    callOnHScript('updateNoteDatas');
    for (note in unspawnNotes) {
        if (!note.isSustainNote) note.scale.set(0.6, 0.6);
        else note.scale.x = 0.6; //do it this way to avoid breaking sustains
        note.offsetX += 7;
        switch(note.noteData) {
            case 0:
                if (!note.isSustainNote) {
                    note.animation.addByPrefix('Note', 'purple0');
                    note.animation.play('Note');
                }
                
                if (note.extraData.get('canChangeRGB') == null) {
                    /*
                    For Lua: setPropertyFromGroup('unspawnNotes', i, 'extraData.canChangeRGB', false, true)
                    For Haxe: note.extraData.set('canChangeRGB', false);

                    use these to DISABLE note rgb changes
                    */

                    note.extraData.set('canChangeRGB', true);
                    note.rgbShader.r = ClientPrefs.data.arrowRGB[0][0];
                    note.rgbShader.g = ClientPrefs.data.arrowRGB[0][1];
                    note.rgbShader.b = ClientPrefs.data.arrowRGB[0][2];

                    note.noteSplashData.r = ClientPrefs.data.arrowRGB[0][0];
                    note.noteSplashData.g = ClientPrefs.data.arrowRGB[0][1];
                    note.noteSplashData.b = ClientPrefs.data.arrowRGB[0][2];
                }
            case 1:
                if (!note.isSustainNote) {
                    note.animation.addByPrefix('Note', 'blue0');
                    note.animation.play('Note');
                }
                
                if (note.extraData.get('canChangeRGB') == null) {
                    /*
                    For Lua: setPropertyFromGroup('unspawnNotes', i, 'extraData.canChangeRGB', false, true)
                    For Haxe: note.extraData.set('canChangeRGB', false);

                    use these to DISABLE note rgb changes
                    */

                    note.extraData.set('canChangeRGB', true);
                    note.rgbShader.r = ClientPrefs.data.arrowRGB[1][0];
                    note.rgbShader.g = ClientPrefs.data.arrowRGB[1][1];
                    note.rgbShader.b = ClientPrefs.data.arrowRGB[1][2];

                    note.noteSplashData.r = ClientPrefs.data.arrowRGB[1][0];
                    note.noteSplashData.g = ClientPrefs.data.arrowRGB[1][1];
                    note.noteSplashData.b = ClientPrefs.data.arrowRGB[1][2];
                }
            case 2:
                if (!note.isSustainNote) {
                    note.animation.addByPrefix('Note', 'red0');
                    note.animation.play('Note');
                }
                
                if (note.extraData.get('canChangeRGB') == null) {
                    /*
                    For Lua: setPropertyFromGroup('unspawnNotes', i, 'extraData.canChangeRGB', false, true)
                    For Haxe: note.extraData.set('canChangeRGB', false);

                    use these to DISABLE note rgb changes
                    */

                    note.extraData.set('canChangeRGB', true);
                    note.rgbShader.r = 0xFF0033FF;
                    note.rgbShader.g = 0xFFFFFFFF;
                    note.rgbShader.b = 0xFF000066;

                    note.noteSplashData.r = 0xFF0033FF;
                    note.noteSplashData.g = 0xFFFFFFFF;
                    note.noteSplashData.b = 0xFF000066;
                }
            case 3:
                if (!note.isSustainNote) {
                    note.animation.addByPrefix('Note', 'purple0');
                    note.animation.play('Note');
                }
                
                if (note.extraData.get('canChangeRGB') == null) {
                    /*
                    For Lua: setPropertyFromGroup('unspawnNotes', i, 'extraData.canChangeRGB', false, true)
                    For Haxe: note.extraData.set('canChangeRGB', false);

                    use these to DISABLE note rgb changes
                    */

                    note.extraData.set('canChangeRGB', true);
                    note.rgbShader.r = 0xFFFFFF00;
                    note.rgbShader.g = 0xFFFFFFFF;
                    note.rgbShader.b = 0xFF993300;

                    note.noteSplashData.r = 0xFFFFFF00;
                    note.noteSplashData.g = 0xFFFFFFFF;
                    note.noteSplashData.b = 0xFF993300;
                }
            case 4:
                if (!note.isSustainNote) {
                    note.animation.addByPrefix('Note', 'green0');
                    note.animation.play('Note');
                }
                
                if (note.extraData.get('canChangeRGB') == null) {
                    /*
                    For Lua: setPropertyFromGroup('unspawnNotes', i, 'extraData.canChangeRGB', false, true)
                    For Haxe: note.extraData.set('canChangeRGB', false);

                    use these to DISABLE note rgb changes
                    */

                    note.extraData.set('canChangeRGB', true);
                    note.rgbShader.r = ClientPrefs.data.arrowRGB[2][0];
                    note.rgbShader.g = ClientPrefs.data.arrowRGB[2][1];
                    note.rgbShader.b = ClientPrefs.data.arrowRGB[2][2];

                    note.noteSplashData.r = ClientPrefs.data.arrowRGB[2][0];
                    note.noteSplashData.g = ClientPrefs.data.arrowRGB[2][1];
                    note.noteSplashData.b = ClientPrefs.data.arrowRGB[2][2];
                }
            case 5:
                if (!note.isSustainNote) {
                    note.animation.addByPrefix('Note', 'red0');
                    note.animation.play('Note');
                }
                
                if (note.extraData.get('canChangeRGB') == null) {
                    /*
                    For Lua: setPropertyFromGroup('unspawnNotes', i, 'extraData.canChangeRGB', false, true)
                    For Haxe: note.extraData.set('canChangeRGB', false);

                    use these to DISABLE note rgb changes
                    */

                    note.extraData.set('canChangeRGB', true);
                    note.rgbShader.r = ClientPrefs.data.arrowRGB[3][0];
                    note.rgbShader.g = ClientPrefs.data.arrowRGB[3][1];
                    note.rgbShader.b = ClientPrefs.data.arrowRGB[3][2];

                    note.noteSplashData.r = ClientPrefs.data.arrowRGB[3][0];
                    note.noteSplashData.g = ClientPrefs.data.arrowRGB[3][1];
                    note.noteSplashData.b = ClientPrefs.data.arrowRGB[3][2];
                }
        }
        note.updateHitbox();
        note.rgbShader.enabled = !PlayState.SONG.disableNoteRGB;
        note.noteSplashData.enabled = !PlayState.SONG.disableNoteRGB;
    }
}

function generateStaticArrows(player:Int) {
	var strumLineX:Float = ClientPrefs.data.middleScroll ? -322.5 : -1.5;
	var strumLineY:Float = ClientPrefs.data.downScroll ? (FlxG.height - 150) : 50;

	for (i in 0...6)
	{
		var babyArrow:StrumNote = new StrumNote(strumLineX, strumLineY, 0, player);
		babyArrow.downScroll = ClientPrefs.data.downScroll;
        babyArrow.scale.set(0.6, 0.6);

        switch(i) {
            case 0:
                babyArrow.animation.addByPrefix('static', 'arrowLEFT');
                babyArrow.animation.addByPrefix('confirm', 'left confirm', 24, false);
                babyArrow.animation.addByPrefix('pressed', 'left press', 24, false);

                babyArrow.rgbShader.r = ClientPrefs.data.arrowRGB[0][0];
                babyArrow.rgbShader.g = ClientPrefs.data.arrowRGB[0][1];
                babyArrow.rgbShader.b = ClientPrefs.data.arrowRGB[0][2];
            case 1:
                babyArrow.animation.addByPrefix('static', 'arrowDOWN');
                babyArrow.animation.addByPrefix('confirm', 'down confirm', 24, false);
                babyArrow.animation.addByPrefix('pressed', 'down press', 24, false);

                babyArrow.rgbShader.r = ClientPrefs.data.arrowRGB[1][0];
                babyArrow.rgbShader.g = ClientPrefs.data.arrowRGB[1][1];
                babyArrow.rgbShader.b = ClientPrefs.data.arrowRGB[1][2];
            case 2:
                babyArrow.animation.addByPrefix('static', 'arrowRIGHT');
                babyArrow.animation.addByPrefix('confirm', 'right confirm', 24, false);
                babyArrow.animation.addByPrefix('pressed', 'right press', 24, false);

                babyArrow.rgbShader.r = 0xFF0033FF;
                babyArrow.rgbShader.g = 0xFFFFFFFF;
                babyArrow.rgbShader.b = 0xFF000066;
            case 3:
                babyArrow.animation.addByPrefix('static', 'arrowLEFT');
                babyArrow.animation.addByPrefix('confirm', 'left confirm', 24, false);
                babyArrow.animation.addByPrefix('pressed', 'left press', 24, false);

                babyArrow.rgbShader.r = 0xFFFFFF00;
                babyArrow.rgbShader.g = 0xFFFFFFFF;
                babyArrow.rgbShader.b = 0xFF993300;
            case 4:
                babyArrow.animation.addByPrefix('static', 'arrowUP');
                babyArrow.animation.addByPrefix('confirm', 'up confirm', 24, false);
                babyArrow.animation.addByPrefix('pressed', 'up press', 24, false);

                babyArrow.rgbShader.r = ClientPrefs.data.arrowRGB[2][0];
                babyArrow.rgbShader.g = ClientPrefs.data.arrowRGB[2][1];
                babyArrow.rgbShader.b = ClientPrefs.data.arrowRGB[2][2];
            case 5:
                babyArrow.animation.addByPrefix('static', 'arrowRIGHT');
                babyArrow.animation.addByPrefix('confirm', 'right confirm', 24, false);
                babyArrow.animation.addByPrefix('pressed', 'right press', 24, false);

                babyArrow.rgbShader.r = ClientPrefs.data.arrowRGB[3][0];
                babyArrow.rgbShader.g = ClientPrefs.data.arrowRGB[3][1];
                babyArrow.rgbShader.b = ClientPrefs.data.arrowRGB[3][2];
        }
        babyArrow.noteData = i;
        babyArrow.rgbShader.enabled = !PlayState.SONG.disableNoteRGB;
        babyArrow.playAnim('static');
        babyArrow.x -= 25 * i;
		strumLineNotes.add(babyArrow);
        if (player > 0) playerStrums.add(babyArrow);
        else opponentStrums.add(babyArrow);
		babyArrow.playerPosition();

        if (ClientPrefs.data.middleScroll && player == 0) if (i > 2) babyArrow.x += 950; else babyArrow.x += 325;

        callOnHScript('tweenNoteIn', [player, babyArrow]);
	}
    
}

function onCountdownStarted() {
    for (strum in game.strumLineNotes) game.strumLineNotes.remove(strum);
    for (strum in game.playerStrums) game.playerStrums.remove(strum);
    for (strum in game.opponentStrums) game.opponentStrums.remove(strum);
	generateStaticArrows(0);
	generateStaticArrows(1);
}

var singDirections:Array<String> = ['LEFT', 'DOWN', 'UP', 'RIGHT'];

function goodNoteHit(note:Note) {

    var anim:String = 'sing';
    
    switch(note.noteData) {
        case 0:
            anim = anim + singDirections[0];
        case 1:
            anim = anim + singDirections[1];
        case 2:
            anim = anim + singDirections[3];
        case 3:
            anim = anim + singDirections[0];
        case 4:
            anim = anim + singDirections[2];
        case 5:
            anim = anim + singDirections[3];
    }

    boyfriend.playAnim(anim + note.animSuffix, true);
}

function noteMiss(note:Note) {

    var anim:String = 'sing';

    switch(note.noteData) {
        case 0:
            anim = anim + singDirections[0] + 'miss';
        case 1:
            anim = anim + singDirections[1] + 'miss';
        case 2:
            anim = anim + singDirections[3] + 'miss';
        case 3:
            anim = anim + singDirections[0] + 'miss';
        case 4:
            anim = anim + singDirections[2] + 'miss';
        case 5:
            anim = anim + singDirections[3] + 'miss';
    }
    
    boyfriend.playAnim(anim + note.animSuffix, true);
}

function opponentNoteHit(note:Note) {

    var anim:String = 'sing';
    
    switch(note.noteData) {
        case 0:
            anim = anim + singDirections[0];
        case 1:
            anim = anim + singDirections[1];
        case 2:
            anim = anim + singDirections[3];
        case 3:
            anim = anim + singDirections[0];
        case 4:
            anim = anim + singDirections[2];
        case 5:
            anim = anim + singDirections[3];
    }

    dad.playAnim(anim + note.animSuffix, true);
}