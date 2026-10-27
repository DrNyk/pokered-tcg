IF DEF(_MAGENTA)
PackOpening:
	ld hl, PackPointers
	ld b, 0
	ld a, [wCurrentMenuItem]
	ld c, a
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call Random
	jp hl

PackPointers:
	dw BaseSetPointer
	dw JungleSetPointer
	dw FossilSetPointer
	
	
BaseSetPointer:
	ld hl, wTempByteValue
	ld [hl], BULBASAUR
	cp 4
	ret c
	ld [hl], CHARMANDER
	cp 8
	ret c
	ld [hl], SQUIRTLE
	cp 12
	ret c
	ld [hl], ABRA
	cp 17
	ret c
	ld [hl], CHANSEY
	cp 18
	ret c
	ld [hl], CLEFAIRY
	cp 27
	ret c
	ld [hl], MAGIKARP
	cp 38
	ret c
	ld [hl], HITMONCHAN
	cp 44
	ret c
	ld [hl], MACHOP
	cp 53
	ret c
	ld [hl], MAGNEMITE
	cp 59
	ret c
	ld [hl], NIDORAN_M
	cp 68
	ret c
	ld [hl], VULPIX
	cp 76
	ret c
	ld [hl], POLIWAG
	cp 83
	ret c
	ld [hl], PIKACHU
	cp 91
	ret c
	ld [hl], BEEDRILL
	cp 97
	ret c
	ld [hl], DIGLETT
	cp 107
	ret c
	ld [hl], ELECTABUZZ
	cp 112
	ret c
	ld [hl], VOLTORB
	cp 120
	ret c
	ld [hl], PIDGEY
	cp 128
	ret c
	ld [hl], GROWLITHE
	cp 136
	ret c
	ld [hl], SEEL
	cp 144
	ret c
	ld [hl], FARFETCHD
	cp 152
	ret c
	ld [hl], GASTLY
	cp 158
	ret c
	ld [hl], JYNX
	cp 163
	ret c
	ld [hl], MAGMAR
	cp 168
	ret c
	ld [hl], PORYGON
	cp 173
	ret c
	ld [hl], RATTATA
	cp 182
	ret c
	ld [hl], BUTTERFREE
	cp 191
	ret c
	ld [hl], DODUO
	cp 199
	ret c
	ld [hl], DROWZEE
	cp 207
	ret c
	ld [hl], KOFFING
	cp 215
	ret c
	ld [hl], ONIX
	cp 224
	ret c
	ld [hl], SANDSHREW
	cp 232
	ret c
	ld [hl], PONYTA
	cp 240
	ret c
	ld [hl], STARYU
	cp 248
	ret c
	ld [hl], TANGELA
	ret
	
JungleSetPointer:
	ld hl, wTempByteValue
	ld [hl], CLEFAIRY
	cp 11
	ret c
	ld [hl], VOLTORB
	cp 22
	ret c
	ld [hl], EEVEE
	cp 27
	ret c
	ld [hl], KANGASKHAN
	cp 32
	ret c
	ld [hl], MR_MIME
	cp 40
	ret c
	ld [hl], NIDORAN_F
	cp 51
	ret c
	ld [hl], PIDGEY
	cp 63
	ret c
	ld [hl], PINSIR
	cp 71
	ret c
	ld [hl], SCYTHER
	cp 79
	ret c
	ld [hl], SNORLAX
	cp 82
	ret c
	ld [hl], VENONAT
	cp 93
	ret c
	ld [hl], BELLSPROUT
	cp 104
	ret c
	ld [hl], ODDISH
	cp 115
	ret c
	ld [hl], JIGGLYPUFF
	cp 126
	ret c
	ld [hl], DODUO
	cp 137
	ret c
	ld [hl], EXEGGCUTE
	cp 148
	ret c
	ld [hl], SPEAROW
	cp 160
	ret c
	ld [hl], LICKITUNG
	cp 167
	ret c
	ld [hl], CUBONE
	cp 177
	ret c
	ld [hl], PARAS
	cp 188
	ret c
	ld [hl], MEOWTH
	cp 199
	ret c
	ld [hl], MANKEY
	cp 210
	ret c
	ld [hl], PONYTA
	cp 221
	ret c
	ld [hl], RHYHORN
	cp 232
	ret c
	ld [hl], GOLDEEN
	cp 243
	ret c
	ld [hl], TAUROS
	cp 247
	ret c
	ld [hl], PIKACHU
	ret

FossilSetPointer:
	ld hl, wTempByteValue
	ld [hl], ZUBAT
	cp 25
	ret c
	ld [hl], TENTACOOL
	cp 50
	ret c
	ld [hl], SLOWPOKE
	cp 65
	ret c
	ld [hl], PSYDUCK
	cp 80
	ret c
	ld [hl], OMANYTE
	cp 83
	ret c
	ld [hl], KRABBY
	cp 98
	ret c
	ld [hl], KABUTO
	cp 101
	ret c
	ld [hl], HORSEA
	cp 110
	ret c
	ld [hl], GRIMER
	cp 125
	ret c
	ld [hl], GEODUDE
	cp 140
	ret c
	ld [hl], EKANS
	cp 160
	ret c
	ld [hl], KOFFING
	cp 175
	ret c
	ld [hl], SANDSHREW
	cp 190
	ret c
	ld [hl], MAGMAR
	cp 200
	ret c
	ld [hl], GASTLY
	cp 210
	ret c
	ld [hl], PIKACHU
	cp 215
	ret c
	ld [hl], MAGNEMITE
	cp 225
	ret c
	ld [hl], LAPRAS
	cp 227
	ret c
	ld [hl], DROWZEE
	cp 237
	ret c
	ld [hl], HITMONLEE
	cp 250
	ret c
	ld [hl], DITTO
	cp 253
	ret c
	ld [hl], AERODACTYL
	ret
ENDC