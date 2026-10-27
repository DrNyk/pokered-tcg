GameCornerPrizeRoom_Script:
	jp EnableAutoTextBoxDrawing

GameCornerPrizeRoom_TextPointers:
	def_text_pointers
	dw_const GameCornerPrizeRoomBaldingGuyText,  TEXT_GAMECORNERPRIZEROOM_BALDING_GUY
	dw_const GameCornerPrizeRoomGamblerText,     TEXT_GAMECORNERPRIZEROOM_GAMBLER
	dw_const GameCornerPRizeRoomPrizeVendorText, TEXT_GAMECORNERPRIZEROOM_PRIZE_VENDOR_1
	dw_const GameCornerPRizeRoomPrizeVendorText, TEXT_GAMECORNERPRIZEROOM_PRIZE_VENDOR_2
	dw_const GameCornerPRizeRoomPrizeVendorText, TEXT_GAMECORNERPRIZEROOM_PRIZE_VENDOR_3
	EXPORT TEXT_GAMECORNERPRIZEROOM_PRIZE_VENDOR_1 ; used by engine/events/prize_menu.asm

GameCornerPrizeRoomBaldingGuyText:
	text_far _GameCornerPrizeRoomBaldingGuyText
	text_end

IF DEF(_MAGENTA)
GameCornerPrizeRoomGamblerText:
	text_asm
	CheckEvent EVENT_CELADON_GAMBLER
	ld hl, .WannaBuyAPackLong
	call z, PrintText
	SetEvent EVENT_CELADON_GAMBLER
	ld hl, .WannaBuyAPackShort
	call PrintText
	ld hl, wStatusFlags5
	set BIT_NO_TEXT_DELAY, [hl]
	ld a, MONEY_BOX
	ld [wTextBoxID], a
	call DisplayTextBoxID
	hlcoord 11, 3
	ld b, 7 ; 9 rows tall
	ld c, 7 ; 9 columns wide
	call TextBoxBorder
	call UpdateSprites
	ld a, 4
	ld [wTopMenuItemY], a
	dec a ; shortcut to 4 ; or do I want it to stay 3, because of it being 0-indexed...
	ld [wMaxMenuItem], a
	ld a, 12
	ld [wTopMenuItemX], a
	xor a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	ld [wMenuWatchMovingOutOfBounds], a
	ld hl, hMoney
	ld [hli], a
	inc hl
	ld [hld], a
	ld [hl], $15 ; fake "Decimal" hex
	ld de, .Packs
	hlcoord 13, 4
	call PlaceString
	call HandleMenuInput
	ld hl, .choseCancel
	bit B_PAD_B, a
	jr nz, .PrintText
	ld a, [wCurrentMenuItem]
	cp 3
	jr z, .PrintText
	call HasEnoughMoney
	ld hl, .NotEnoughMoney
	jr c, .PrintText
	ld a, [wCurrentMenuItem] ; I don't know if the HasEnoughMoney butchers a... probably.
	call PackOpening
	ld b, [hl] ; the species
	ld c, 15 ; level
	call GivePokemon
	jr nc, .done
	ld hl, wPriceTemp
	xor a
	ld [hli], a
	inc hl
	ld [hld], a
	ld a, $15 ; fake "Decimal" hex
	ld [hli], a
	ld de, wPlayerMoney + 2
	ld c, $3
	predef SubBCDPredef
	ld a, MONEY_BOX
	ld [wTextBoxID], a
	call DisplayTextBoxID
	jr .done
.PrintText
	call PrintText
.done
	ld hl, wStatusFlags5
	res BIT_NO_TEXT_DELAY, [hl]
	jp TextScriptEnd
	
.WannaBuyAPackShort
	text_far _BuyAPack
	text_end
.WannaBuyAPackLong
	text_far _GameCornerPrizeRoomGamblerText
	text_end
.choseCancel
	text_far _PackDeclined
	text_end
.NotEnoughMoney
	text_far _PackTooPricey
	text_end
.Packs
	db "BASE"
	next "JUNGLE"
	next "FOSSIL"
	next "CANCEL@"

INCLUDE "engine/pokemon/BoosterPackDraw.asm"
ELSE
GameCornerPrizeRoomGamblerText:
	text_far _GameCornerPrizeRoomGamblerText
	text_end
ENDC

GameCornerPRizeRoomPrizeVendorText:
	script_prize_vendor
