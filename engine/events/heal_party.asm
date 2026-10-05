HealParty:
; restore HP and status
	ld hl, wPartySpecies
	ld de, wPartyMon1HP
.healmon
	ld a, [hli]
	cp $ff ; see wPartySpecies has 7 bytes for storing our party, and $ff is the 7th-byte terminator
	jr z, .done
	push hl
	
	ld hl, MON_STATUS - MON_HP ; bumps from wPartyMonNHP -> wPartyMonNStatus
	add hl, de
	xor a
	ld [hl], a ; wipes the status
	
	; right now de remains wPartyMonNHP
	; so the goal is to get hl up to wPartyMonNHPMax. It's at wPartyMonNStatus
	ld hl, MON_MAXHP - MON_HP
	add hl, de
	; hl is at wPartyMonNHPMax
	; de is at wPartyMonNHP
	ld a, [hli] ; gets value of wPartyMonNHPMax and makes hl wPartyMonNHPMax + 1
	ld [de], a
	inc de ; bumps this to wPartyMonNHP + 1
	ld a, [hl]
	ld [de], a
	dec de ; reset de back to wPartyMonNHP
	ld hl, PARTYMON_STRUCT_LENGTH
	add hl, de
	ld d, h
	ld e, l
	pop hl
	ld a, [wTempByteValue] ; this is set to 1 if player wants just their lead to be healed, and set to zero for the whole team to be healed
	and a
	jr z, .healmon
	
.done
	xor a
	ld [wWhichPokemon], a
	;ld [wUsingPPUp], a ; same thing as wTempByteValue. There was in the old PP system a function called "RestoreBonusPP" that would use this as a flag to identify if all PP_Ups should be restored, or just increment the current PP by one application of a PP Up. That is, it differed between freshly applying PP Up item from your bag and healing at a Pokemon Center (or using Ether/Elixir??).
	; we don't want to overwrite it in the TCG version implementing a heal All vs Lead soloist feature.
	ret