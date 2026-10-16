function onCreatePost()
{
	if (ClientPrefs.data.winmarioCustomscore == 'WinMario' && !ClientPrefs.data.downScroll) {
        scoreTxt.y = 660;
    }

    if (ClientPrefs.data.winmarioCustomscore == 'Mic\'d Up' && !ClientPrefs.data.downScroll) {
        scoreTxt.y = 645;
    }
}