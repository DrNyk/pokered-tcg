_GameCornerPrizeRoomBaldingGuyText::
	text "I sure do fancy"
	line "that PORYGON!"

	para "But, it's hard to"
	line "win at slots!"
	done
	
IF DEF(_MAGENTA)
_GameCornerPrizeRoomGamblerText::
	text "I could use some"
	line "dough to get that"
	cont "coveted <TM>."
	para "How about helping"
	line "an o' feller out?"
	prompt
ELSE
_GameCornerPrizeRoomGamblerText::
	text "I had a major"
	line "haul today!"
	done
ENDC
