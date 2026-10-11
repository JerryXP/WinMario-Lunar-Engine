import flixel.FlxG;

import backend.ClientPrefs;

import objects.StrumNote;

function onCreatePost() {
    callOnHScript('updateNoteDatas');
    for (note in unspawnNotes) {
        var name:String = note.animation.curAnim.name;
        note.reloadNote(callOnHScript('getMultiTexture', [note.texture]));
        note.updateHitbox();
        switch(note.noteData) {
            case 0:
                if (!note.isSustainNote) {
                    note.animation.addByPrefix('Note', 'left 1');
                    note.animation.play('Note');
                } else {
                    if (StringTools.endsWith(name, 'end')) {
		                note.animation.addByPrefix('holdend', 'hold end 1', 24, true);
                        note.animation.play("holdend");
                    } else {
		                note.animation.addByPrefix('hold', 'hold 1', 24, true);
                        note.animation.play("hold");
                    }
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
                    note.animation.addByPrefix('Note', 'down 1');
                    note.animation.play('Note');
                } else {
                    if (StringTools.endsWith(name, 'end')) {
		                note.animation.addByPrefix('holdend', 'hold end 1', 24, true);
                        note.animation.play("holdend");
                    } else {
		                note.animation.addByPrefix('hold', 'hold 1', 24, true);
                        note.animation.play("hold");
                    }
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
                    note.animation.addByPrefix('Note', 'middle 1');
                    note.animation.play('Note');
                } else {
                    if (StringTools.endsWith(name, 'end')) {
		                note.animation.addByPrefix('holdend', 'hold end 1', 24, true);
                        note.animation.play("holdend");
                    } else {
		                note.animation.addByPrefix('hold', 'hold 1', 24, true);
                        note.animation.play("hold");
                    }
                }
                
                if (note.extraData.get('canChangeRGB') == null) {
                    /*
                    For Lua: setPropertyFromGroup('unspawnNotes', i, 'extraData.canChangeRGB', false, true)
                    For Haxe: note.extraData.set('canChangeRGB', false);

                    use these to DISABLE note rgb changes
                    */

                    note.extraData.set('canChangeRGB', true);
                    note.rgbShader.r = 0xFFCCCCCC;
                    note.rgbShader.g = 0xFFFFFFFF;
                    note.rgbShader.b = 0xFF3E3E3E;

                    note.noteSplashData.r = 0xFFCCCCCC;
                    note.noteSplashData.g = 0xFFFFFFFF;
                    note.noteSplashData.b = 0xFF3E3E3E;
                }
            case 3:
                if (!note.isSustainNote) {
                    note.animation.addByPrefix('Note', 'up 1');
                    note.animation.play('Note');
                } else {
                    if (StringTools.endsWith(name, 'end')) {
		                note.animation.addByPrefix('holdend', 'hold end 1', 24, true);
                        note.animation.play("holdend");
                    } else {
		                note.animation.addByPrefix('hold', 'hold 1', 24, true);
                        note.animation.play("hold");
                    }
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
            case 4:
                if (!note.isSustainNote) {
                    note.animation.addByPrefix('Note', 'right 1');
                    note.animation.play('Note');
                } else {
                    if (StringTools.endsWith(name, 'end')) {
		                note.animation.addByPrefix('holdend', 'hold end 1', 24, true);
                        note.animation.play("holdend");
                    } else {
		                note.animation.addByPrefix('hold', 'hold 1', 24, true);
                        note.animation.play("hold");
                    }
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
        note.rgbShader.enabled = !PlayState.SONG.disableNoteRGB;
        note.noteSplashData.enabled = !PlayState.SONG.disableNoteRGB;
    }
}

function generateStaticArrows(player:Int) {
	var strumLineX:Float = ClientPrefs.data.middleScroll ? -328 : -10;
	var strumLineY:Float = ClientPrefs.data.downScroll ? (FlxG.height - 150) : 50;

	for (i in 0...5)
	{
		var babyArrow:StrumNote = new StrumNote(strumLineX, strumLineY, 0, player);
		babyArrow.downScroll = ClientPrefs.data.downScroll;
        babyArrow.texture = callOnHScript('getMultiTexture', [babyArrow.texture]);

        switch(i) {
            case 0:
                babyArrow.animation.addByPrefix('static', 'arrowLEFT 1');
                babyArrow.animation.addByPrefix('confirm', 'left confirm 1', 24, false);
                babyArrow.animation.addByPrefix('pressed', 'left press 1', 24, false);

                babyArrow.rgbShader.r = ClientPrefs.data.arrowRGB[0][0];
                babyArrow.rgbShader.g = ClientPrefs.data.arrowRGB[0][1];
                babyArrow.rgbShader.b = ClientPrefs.data.arrowRGB[0][2];
            case 1:
                babyArrow.animation.addByPrefix('static', 'arrowDOWN 1');
                babyArrow.animation.addByPrefix('confirm', 'down confirm 1', 24, false);
                babyArrow.animation.addByPrefix('pressed', 'down press 1', 24, false);

                babyArrow.rgbShader.r = ClientPrefs.data.arrowRGB[1][0];
                babyArrow.rgbShader.g = ClientPrefs.data.arrowRGB[1][1];
                babyArrow.rgbShader.b = ClientPrefs.data.arrowRGB[1][2];
            case 2:
                babyArrow.animation.addByPrefix('static', 'arrowSPACE 1');
                babyArrow.animation.addByPrefix('confirm', 'middle confirm 1', 24, false);
                babyArrow.animation.addByPrefix('pressed', 'middle press 1', 24, false);

                babyArrow.rgbShader.r = 0xFFCCCCCC;
                babyArrow.rgbShader.g = 0xFFFFFFFF;
                babyArrow.rgbShader.b = 0xFF3E3E3E;
            case 3:
                babyArrow.animation.addByPrefix('static', 'arrowUP 1');
                babyArrow.animation.addByPrefix('confirm', 'up confirm 1', 24, false);
                babyArrow.animation.addByPrefix('pressed', 'up press 1', 24, false);

                babyArrow.rgbShader.r = ClientPrefs.data.arrowRGB[2][0];
                babyArrow.rgbShader.g = ClientPrefs.data.arrowRGB[2][1];
                babyArrow.rgbShader.b = ClientPrefs.data.arrowRGB[2][2];
            case 4:
                babyArrow.animation.addByPrefix('static', 'arrowRIGHT 1');
                babyArrow.animation.addByPrefix('confirm', 'right confirm 1', 24, false);
                babyArrow.animation.addByPrefix('pressed', 'right press 1', 24, false);

                babyArrow.rgbShader.r = ClientPrefs.data.arrowRGB[3][0];
                babyArrow.rgbShader.g = ClientPrefs.data.arrowRGB[3][1];
                babyArrow.rgbShader.b = ClientPrefs.data.arrowRGB[3][2];
        }
        babyArrow.noteData = i;
        babyArrow.rgbShader.enabled = !PlayState.SONG.disableNoteRGB;
        babyArrow.playAnim('static');
		strumLineNotes.add(babyArrow);
        if (player > 0) playerStrums.add(babyArrow);
        else opponentStrums.add(babyArrow);
		babyArrow.playerPosition();

        if (ClientPrefs.data.middleScroll && player == 0) if (i > 2) babyArrow.x += 900; else babyArrow.x += 295;

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
            anim = anim + singDirections[2];
        case 3:
            anim = anim + singDirections[2];
        case 4:
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
            anim = anim + singDirections[2] + 'miss';
        case 3:
            anim = anim + singDirections[2] + 'miss';
        case 4:
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
            anim = anim + singDirections[2];
        case 3:
            anim = anim + singDirections[2];
        case 4:
            anim = anim + singDirections[3];
    }

    dad.playAnim(anim + note.animSuffix, true);
}