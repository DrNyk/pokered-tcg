CeladonPrizeMenu::
	ld b, COIN_CASE
	call IsItemInBag
	jr nz, .havingCoinCase
	ld hl, RequireCoinCaseText
	jp PrintText
.havingCoinCase
	ld hl, wStatusFlags5
	set BIT_NO_TEXT_DELAY, [hl]
	ld hl, ExchangeCoinsForPrizesText
	call PrintText
; the following are the menu settings
	xor a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	ld a, PAD_A | PAD_B
	ld [wMenuWatchedKeys], a
IF DEF(_RED)
	ld a, $03
ENDC
IF DEF(_BLUE)
	ld a, $03
ENDC
IF DEF(_PURPLE)
	ld a, [wXCoord]
	cp $06
	ld a, [wNumHoFTeams]
	jr nz, .LeftOrMiddleWindow
	; right window
	;ld a, [wNumHoFTeams]
	and a
	ld a, $03 ; this means I'm looking at right window without being champion, so no fossils unlocked
	jr z, .gotmycoord
	ld a, $06 ; this is situation where I am champion so let's show fossils
	jr .gotmycoord
.LeftOrMiddleWindow
	ld a, $04 ; whether I am champion or not, it's always 4 in Purple.
.gotmycoord
ENDC
IF DEF(_MAGENTA)
	ld a, [wXCoord]
	cp $04
	ld a, [wNumHoFTeams]
	jr z, .MiddleWindow
	jr c, .LeftWindow
	; right window
	;ld a, [wNumHoFTeams]
	and a
	ld a, $03 ; this means I'm looking at right window without being champion, so no fossils unlocked
	jr z, .gotmycoord
	ld a, $06 ; this is situation where I am champion so let's show fossils
	jr .gotmycoord
.MiddleWindow
	;ld a, [wNumHofTeams]
	and a
	ld a, $04 ; when I am not yet champion
	jr z, .gotmycoord
	inc a ; I am now champion, total of 5 in this window
	jr .gotmycoord
.LeftWindow
	;ld a, [wNumHoFTeams]
	and a
	ld a, $04 ; when I am not yet champion
	jr z, .gotmycoord
	ld a, $06 ; I am now champion, total of 6 in this window
.gotmycoord
ENDC
	ld b, b
	ld [wMaxMenuItem], a
	ld a, $04 ; this is the Y coord...
	ld [wTopMenuItemY], a
	ld a, $01
	ld [wTopMenuItemX], a
	call PrintPrizePrice
	hlcoord 0, 2
	ld b, 8
	ld c, 17
	call TextBoxBorder
	call GetPrizeMenuId
	call UpdateSprites
	ld hl, WhichPrizeText
	call PrintText
IF DEF(_PURPLE)
	ld hl, hUILayoutFlags
	set BIT_DOUBLE_SPACED_MENU, [hl]
ENDC
IF DEF(_MAGENTA)
	ld hl, hUILayoutFlags
	set BIT_DOUBLE_SPACED_MENU, [hl]
ENDC
	call HandleMenuInput ; menu choice handler
IF DEF(_PURPLE)
	ld hl, hUILayoutFlags
	res BIT_DOUBLE_SPACED_MENU, [hl]
ENDC
IF DEF(_MAGENTA)
	ld hl, hUILayoutFlags
	res BIT_DOUBLE_SPACED_MENU, [hl]
ENDC
	bit B_PAD_B, a
	jr nz, .noChoice
	ld a, [wMaxMenuItem]
	ld b, a
	ld a, [wCurrentMenuItem]
	cp b ; "NO,THANKS" choice
	jr z, .noChoice
	call HandlePrizeChoice
.noChoice
	ld hl, wStatusFlags5
	res BIT_NO_TEXT_DELAY, [hl]
	ret

RequireCoinCaseText:
	text_far _RequireCoinCaseText
	text_waitbutton
	text_end

ExchangeCoinsForPrizesText:
	text_far _ExchangeCoinsForPrizesText
	text_end

WhichPrizeText:
	text_far _WhichPrizeText
	text_end

GetPrizeMenuId:
; determine which one among the three prize texts has been selected using the text ID (stored in [hTextID])
; prize texts' IDs are TEXT_GAMECORNERPRIZEROOM_PRIZE_VENDOR_1-TEXT_GAMECORNERPRIZEROOM_PRIZE_VENDOR_3
; load the three prizes at wPrize1-wPrice3
; load the three prices at wPrize1Price-wPrize3Price
; display the three prizes' names, distinguishing between Pokemon names and item names (specifically TMs)
	ldh a, [hTextID]
	sub TEXT_GAMECORNERPRIZEROOM_PRIZE_VENDOR_1
	ld [wWhichPrizeWindow], a ; prize texts' relative ID (i.e. 0-2)
	add a
	add a
	ld d, 0
	ld e, a
	ld hl, PrizeDifferentMenuPtrs
IF DEF(_PURPLE)
	ld a, [wNumHoFTeams]
	and a
	jr z, .gotpointer
	ld hl, PrizeDifferentMenuPtrsChampion
.gotpointer
ENDC
IF DEF(_MAGENTA)
	ld a, [wNumHoFTeams]
	and a
	jr z, .gotpointer
	ld hl, PrizeDifferentMenuPtrsChampion
.gotpointer
ENDC
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	inc hl
	push hl
	ld hl, wPrize1
	call CopyString
	pop hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wPrize1Price
	ld bc, 12 ; accommodates up to 6 max prizes when I'm a champion. It might grab junk data but not use it, AFAICT
	call CopyData
	ld a, [wWhichPrizeWindow]
	cp 2 ; is TM_menu?
	jr nz, .putMonName
	ld a, [wPrize1]
	ld [wNamedObjectIndex], a
	call GetItemName
	hlcoord 2, 4
	call PlaceString
	ld a, [wPrize2]
	ld [wNamedObjectIndex], a
	call GetItemName
IF DEF(_RED)
	hlcoord 2, 6
ENDC
IF DEF(_BLUE)
	hlcoord 2, 6
ENDC
IF DEF(_PURPLE)
	hlcoord 2, 5
ENDC
IF DEF(_MAGENTA)
	hlcoord 2, 5
ENDC
	call PlaceString
	ld a, [wPrize3]
	ld [wNamedObjectIndex], a
	call GetItemName
IF DEF(_RED)
	hlcoord 2, 8
ENDC
IF DEF(_BLUE)
	hlcoord 2, 8
ENDC
IF DEF(_PURPLE)
	hlcoord 2, 6
ENDC
IF DEF(_MAGENTA)
	hlcoord 2, 6
ENDC
	call PlaceString
IF DEF(_RED)
	jr .putNoThanksText
ENDC
IF DEF(_BLUE)
	jr .putNoThanksText
ENDC
IF DEF(_PURPLE)
	; I am at the right-most window because previous logic split between right and not-right
	hlcoord 2, 7 ; the next item will print here
	ld a, [wNumHoFTeams]
	and a
	jr z, .putNoThanksText_LaunchPoint
	; otherwise, as Champion, I will have 3 additional items to list here
	ld a, [wPrize4]
	ld [wNamedObjectIndex], a
	call GetItemName
	; hlcoord 2, 7 was already defined prior
	call PlaceString
	hlcoord 2, 8 ; next item will print here
	ld a, [wPrize5]
	ld [wNamedObjectIndex], a
	call GetItemName
	call PlaceString
	hlcoord 2, 9
	ld a, [wPrize6]
	ld [wNamedObjectIndex], a
	call GetItemName
	call PlaceString
	hlcoord 2, 10
.putNoThanksText_LaunchPoint
	jr .putNoThanksText
ENDC
IF DEF(_MAGENTA)
	; I am at the right-most window because previous logic split between right and not-right
	hlcoord 2, 7 ; the next item will print here
	ld a, [wNumHoFTeams]
	and a
	jr z, .putNoThanksText_LaunchPoint
	; otherwise, as Champion, I will have 3 additional items to list here
	ld a, [wPrize4]
	ld [wNamedObjectIndex], a
	call GetItemName
	; hlcoord 2, 7 was already defined prior
	call PlaceString
	hlcoord 2, 8 ; next item will print here
	ld a, [wPrize5]
	ld [wNamedObjectIndex], a
	call GetItemName
	call PlaceString
	hlcoord 2, 9
	ld a, [wPrize6]
	ld [wNamedObjectIndex], a
	call GetItemName
	call PlaceString
	hlcoord 2, 10
.putNoThanksText_LaunchPoint
	jr .putNoThanksText
ENDC
	
.putMonName
	ld a, [wPrize1]
	ld [wNamedObjectIndex], a
	call GetMonName
	hlcoord 2, 4
	call PlaceString
	ld a, [wPrize2]
	ld [wNamedObjectIndex], a
	call GetMonName
IF DEF(_RED)
	hlcoord 2, 6
ENDC
IF DEF(_BLUE)
	hlcoord 2, 6
ENDC
IF DEF(_PURPLE)
	hlcoord 2, 5
ENDC
IF DEF(_MAGENTA)
	hlcoord 2, 5
ENDC
	call PlaceString
	ld a, [wPrize3]
	ld [wNamedObjectIndex], a
	call GetMonName
IF DEF(_RED)
	hlcoord 2, 8
ENDC
IF DEF(_BLUE)
	hlcoord 2, 8
ENDC
IF DEF(_PURPLE)
	hlcoord 2, 6
ENDC
IF DEF(_MAGENTA)
	hlcoord 2, 6
ENDC
	call PlaceString
IF DEF(_RED)
	jr .putNoThanksText
ENDC
IF DEF(_BLUE)
	jr .putNoThanksText
ENDC
IF DEF(_PURPLE)
	; I AM at the left or middle window from the previous check that says it's a Mon Window. I have just 4 items each time, whether pre or post-champion
	hlcoord 2, 7 ; the next item will print here
	ld a, [wPrize4]
	ld [wNamedObjectIndex], a
	call GetMonName
	; hlcoord 2, 7 was already defined prior
	call PlaceString
	hlcoord 2, 8 ; next item will print here
	; fall through to .putNoThanksText
ENDC
IF DEF(_MAGENTA)
	; I AM at the left or middle window from the previous check that says it's a Mon Window.
	hlcoord 2, 7 ; the next item will print here
	ld a, [wPrize4]
	ld [wNamedObjectIndex], a
	call GetMonName
	; hlcoord 2, 7 was already defined prior
	call PlaceString
	hlcoord 2, 8 ; next item will print here
	ld a, [wNumHoFTeams]
	and a
	jr z, .putNoThanksText ; prior to becoming champion, I only have 4 prizes at each window.
	ld a, [wPrize5]
	ld [wNamedObjectIndex], a
	call GetMonName
	call PlaceString
	hlcoord 2, 9
	ld a, [wWhichPrizeWindow]
	and a
	; if it's ZERO, that means I'm in the left window which needs 6 total entries
	jr nz, .putNoThanksText
	ld a, [wPrize6]
	ld [wNamedObjectIndex], a
	call GetMonName
	call PlaceString
	hlcoord 2, 10 ; fall through to .putNoThanksText
ENDC
.putNoThanksText
IF DEF(_RED)
	hlcoord 2, 10
ENDC
IF DEF(_BLUE)
	hlcoord 2, 10
ENDC
; IF DEF(_PURPLE) ; purposefully leave this blank, as the jr .putNoThanksText will have hl already loaded
	; hlcoord 2, 12
; ENDC
; IF DEF(_MAGENTA)
	; hlcoord 2, 12
; ENDC
	ld de, NoThanksText
	call PlaceString
; put prices on the right side of the textbox
	ld de, wPrize1Price
IF DEF(_RED)
	hlcoord 14, 5
ENDC
IF DEF(_BLUE)
	hlcoord 14, 5
ENDC
IF DEF(_PURPLE)
	hlcoord 14, 4
ENDC
IF DEF(_MAGENTA)
	hlcoord 14, 4
ENDC
	ld c, 2 | LEADING_ZEROES
	call PrintBCDNumber
	ld de, wPrize2Price
IF DEF(_RED)
	hlcoord 14, 7
ENDC
IF DEF(_BLUE)
	hlcoord 14, 7
ENDC
IF DEF(_PURPLE)
	hlcoord 14, 5
ENDC
IF DEF(_MAGENTA)
	hlcoord 14, 5
ENDC
	ld c, 2 | LEADING_ZEROES
	call PrintBCDNumber
	ld de, wPrize3Price
IF DEF(_RED)
	hlcoord 14, 9
ENDC
IF DEF(_BLUE)
	hlcoord 14, 9
ENDC
IF DEF(_PURPLE)
	hlcoord 14, 6
ENDC
IF DEF(_MAGENTA)
	hlcoord 14, 6
ENDC
	ld c, 2 | LEADING_ZEROES
IF DEF(_RED)
	jp PrintBCDNumber
ENDC
IF DEF(_BLUE)
	jp PrintBCDNumber
ENDC
IF DEF(_PURPLE)
	ld a, [wNumHoFTeams]
	and a
	jr z, .preChampionLogic
	; this is Champion Logic. Middle Window will have 4 items. The Left has 4. The right has 6.
	call PrintBCDNumber ; this is to print wPrize3Price
	ld de, wPrize4Price
	hlcoord 14, 7
	ld c, 2 | LEADING_ZEROES
	ld a, [wWhichPrizeWindow]
	cp 2
	jr nz, .PrintBCDNumber_LaunchPoint ; it's the left or middle window with only 4 prizes, this is last one to print a price for
	call PrintBCDNumber
	ld de, wPrize5Price
	hlcoord 14, 8
	ld c, 2 | LEADING_ZEROES
	call PrintBCDNumber
	ld de, wPrize6Price
	hlcoord 14, 9
	ld c, 2 | LEADING_ZEROES
	jr .PrintBCDNumber_LaunchPoint
.preChampionLogic
	ld a, [wWhichPrizeWindow]
	cp 2
	jr z, .PrintBCDNumber_LaunchPoint ; just print the third one and be done
; .printAFourthItem
	call PrintBCDNumber ; print the third item, as a call instead of a jp
	ld de, wPrize4Price
	hlcoord 14, 7
	ld c, 2 | LEADING_ZEROES
.PrintBCDNumber_LaunchPoint
	jp PrintBCDNumber ; otherwise it'll call to print it
ENDC
IF DEF(_MAGENTA)
	ld a, [wNumHoFTeams]
	and a
	jr z, .preChampionLogic
	; this is Champion Logic. Middle Window will have 5 items. The Left and Right window has 6.
	call PrintBCDNumber ; this is to print wPrize3Price
	ld de, wPrize4Price
	hlcoord 14, 7
	ld c, 2 | LEADING_ZEROES
	call PrintBCDNumber
	ld de, wPrize5Price
	hlcoord 14, 8
	ld c, 2 | LEADING_ZEROES
	ld a, [wWhichPrizeWindow]
	dec a
	jr z, .PrintBCDNumber_LaunchPoint ; if it's the middle window, this is the last one to print
	call PrintBCDNumber
	ld de, wPrize6Price
	hlcoord 14, 9
	ld c, 2 | LEADING_ZEROES
	jr .PrintBCDNumber_LaunchPoint
.preChampionLogic
	ld a, [wWhichPrizeWindow]
	cp 2
	jr z, .PrintBCDNumber_LaunchPoint ; just print the third one and be done
; .printAFourthItem
	call PrintBCDNumber ; print the third item, as a call instead of a jp
	ld de, wPrize4Price
	hlcoord 14, 7
	ld c, 2 | LEADING_ZEROES
.PrintBCDNumber_LaunchPoint
	jp PrintBCDNumber ; otherwise it'll call to print it
ENDC

INCLUDE "data/events/prizes.asm"

PrintPrizePrice:
	hlcoord 11, 0
	ld b, 1
	ld c, 7
	call TextBoxBorder
	call UpdateSprites
	hlcoord 12, 0
	ld de, .CoinString
	call PlaceString
	hlcoord 13, 1
	ld de, .SixSpacesString
	call PlaceString
	hlcoord 13, 1
	ld de, wPlayerCoins
	ld c, 2 | LEADING_ZEROES
	call PrintBCDNumber
	ret

.CoinString:
	db "COIN@"

.SixSpacesString:
	db "      @"

LoadCoinsToSubtract:
	ld a, [wWhichPrize]
	add a
	ld d, 0
	ld e, a
	ld hl, wPrize1Price
	add hl, de ; get selected prize's price
	xor a
	ldh [hUnusedCoinsByte], a
	ld a, [hli]
	ldh [hCoins], a
	ld a, [hl]
	ldh [hCoins + 1], a
	ret

HandlePrizeChoice:
	;ld a, [wCurrentMenuItem] ; redundant, a is already this value
	ld [wWhichPrize], a
	ld d, 0
	ld e, a
	ld hl, wPrize1
	add hl, de
	ld a, [hl]
	ld [wNamedObjectIndex], a
	ld a, [wWhichPrizeWindow]
	cp 2 ; is prize a TM?
	jr nz, .getMonName
	call GetItemName
	jr .givePrize
.getMonName
	call GetMonName
.givePrize
	ld hl, SoYouWantPrizeText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem] ; yes/no answer (Y=0, N=1)
	and a
	jr nz, .printOhFineThen
	call LoadCoinsToSubtract
	call HasEnoughCoins
	jr c, .notEnoughCoins
	ld a, [wWhichPrizeWindow]
	cp 2 ; is prize a TM?
	jr nz, .giveMon
	ld a, [wNamedObjectIndex]
	ld b, a
	ld a, 1
	ld c, a
	call GiveItem
	jr nc, .bagFull
	jr .subtractCoins
.giveMon
	ld a, [wNamedObjectIndex]
	ld [wCurPartySpecies], a
	push af
	call GetPrizeMonLevel
	ld c, a
	pop af
	ld b, a
	call GivePokemon

; If either the party or box was full, wait after displaying message.
	push af
	ld a, [wAddedToParty]
	and a
	call z, WaitForTextScrollButtonPress
	pop af

; If the mon couldn't be given to the player (because both the party and box
; were full), return without subtracting coins.
	ret nc

.subtractCoins
	call LoadCoinsToSubtract
	ld hl, hCoins + 1
	ld de, wPlayerCoins + 1
	ld c, $02 ; how many bytes
	predef SubBCDPredef
	jp PrintPrizePrice
.bagFull
	ld hl, PrizeRoomBagIsFullText
	jp PrintText
.notEnoughCoins
	ld hl, SorryNeedMoreCoinsText
	jp PrintText
.printOhFineThen
	ld hl, OhFineThenText
	jp PrintText

UnknownPrizeData:
; XXX what's this?
	db $00,$01,$00,$01,$00,$01,$00,$00,$01

HereYouGoText: ; unreferenced
	text_far _HereYouGoText
	text_waitbutton
	text_end

SoYouWantPrizeText:
	text_far _SoYouWantPrizeText
	text_end

SorryNeedMoreCoinsText:
	text_far _SorryNeedMoreCoinsText
	text_waitbutton
	text_end

PrizeRoomBagIsFullText:
	text_far _OopsYouDontHaveEnoughRoomText
	text_waitbutton
	text_end

OhFineThenText:
	text_far _OhFineThenText
	text_waitbutton
	text_end

GetPrizeMonLevel:
	ld a, [wCurPartySpecies]
	ld b, a
	ld hl, PrizeMonLevelDictionary
.loop
	ld a, [hli]
	cp b
	jr z, .matchFound
	inc hl
	jr .loop
.matchFound
	ld a, [hl]
	ld [wCurEnemyLevel], a
	ret

INCLUDE "data/events/prize_mon_levels.asm"
