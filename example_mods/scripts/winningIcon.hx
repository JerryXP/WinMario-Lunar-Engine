var winners:Array<Bool> = [false, false];

function onCreatePost() {
    if (game.iconP2.frames.frames.length > 2) winners[0] = true;
    if (game.iconP1.frames.frames.length > 2) winners[1] = true;
}

function onUpdatePost(e) {
    if (game.healthBar.percent < 20 && winners[0]) game.iconP2.animation.curAnim.curFrame = 2;
    if (game.healthBar.percent > 80 && winners[1]) game.iconP1.animation.curAnim.curFrame = 2;
}