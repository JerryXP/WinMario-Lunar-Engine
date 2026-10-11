import flixel.FlxG;

import backend.ClientPrefs;

import objects.StrumNote;

function onCreatePost() {
    callOnHScript('updateNoteDatas');
    for (note in unspawnNotes) {
        var name:String = note.animation.curAnim.name;
        note.reloadNote(callOnHScript('getMultiTexture', [note.texture]));
        note.updateHitbox();
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
        
        note.rgbShader.enabled = !PlayState.SONG.disableNoteRGB;
        note.noteSplashData.enabled = !PlayState.SONG.disableNoteRGB;
    }

}

function generateStaticArrows(player:Int) {
	var strumLineX:Float = ClientPrefs.data.middleScroll ? 50 : 125;
	var strumLineY:Float = ClientPrefs.data.downScroll ? (FlxG.height - 150) : 50;

	var babyArrow:StrumNote = new StrumNote(strumLineX, strumLineY, 0, player);
	babyArrow.downScroll = ClientPrefs.data.downScroll;
    babyArrow.texture = callOnHScript('getMultiTexture', [babyArrow.texture]);
    babyArrow.updateHitbox();
    babyArrow.animation.addByPrefix('static', 'arrowSPACE 1');
    babyArrow.animation.addByPrefix('confirm', 'middle confirm 1', 24, false);
    babyArrow.animation.addByPrefix('pressed', 'middle press 1', 24, false);
    babyArrow.rgbShader.r = 0xFFCCCCCC;
    babyArrow.rgbShader.g = 0xFFFFFFFF;
    babyArrow.rgbShader.b = 0xFF3E3E3E;
    babyArrow.noteData = 0;
    babyArrow.rgbShader.enabled = !PlayState.SONG.disableNoteRGB;
    babyArrow.playAnim('static');

	strumLineNotes.add(babyArrow);
    if (player > 0) {
        if (!ClientPrefs.data.middleScroll) babyArrow.x += 175;
        playerStrums.add(babyArrow);
    }
    else {
        if (ClientPrefs.data.middleScroll) babyArrow.x += 325;
        opponentStrums.add(babyArrow);
    }
	babyArrow.playerPosition();

    callOnHScript('tweenNoteIn', [player, babyArrow]);
}

function onCountdownStarted() {
    for (strum in game.strumLineNotes) game.strumLineNotes.remove(strum);
    for (strum in game.playerStrums) game.playerStrums.remove(strum);
    for (strum in game.opponentStrums) game.opponentStrums.remove(strum);
	generateStaticArrows(0);
	generateStaticArrows(1);
}

var singDirections:Array<String> = ['LEFT', 'DOWN', 'UP', 'RIGHT'];

function goodNoteHit(note:Note) boyfriend.playAnim('sing' + singDirections[2] + note.animSuffix, true);

function noteMiss(note:Note) boyfriend.playAnim('sing' + singDirections[2] + 'miss' + note.animSuffix, true);

function opponentNoteHit(note:Note) dad.playAnim('sing' + singDirections[2] + note.animSuffix, true);