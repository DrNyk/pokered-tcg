InGameTrade_CheckForTradeEvo:
	ld a, TRUE
	ld [wForceEvolution], a
	ld a, LINK_STATE_TRADING
	ld [wLinkState], a
	callfar TryEvolvingMon
	xor a ; LINK_STATE_NONE
	ld [wLinkState], a
	jp PlayDefaultMusic
