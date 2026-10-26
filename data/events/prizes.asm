PrizeDifferentMenuPtrs:
	dw PrizeMenuMon1Entries, PrizeMenuMon1Cost
	dw PrizeMenuMon2Entries, PrizeMenuMon2Cost
	dw PrizeMenuTMsEntries,  PrizeMenuTMsCost
	
PrizeDifferentMenuPtrsChampion:
	dw ChampionMon1Entries, ChampionMon1Cost
	dw ChampionMon2Entries, ChampionMon2Cost
	dw ChampionTMsEntries, ChampionTMsCost

NoThanksText:
	db "NO THANKS@"
	
PrizeMenuMon1Entries:
IF DEF(_RED)
	db ABRA
	db CLEFAIRY
	db NIDORINA
ENDC
IF DEF(_BLUE)
	db ABRA
	db CLEFAIRY
	db NIDORINO
ENDC
IF DEF(_PURPLE)
	db ABRA
	db CLEFAIRY
	db NIDORINO
	db NIDORINA
ENDC
IF DEF(_MAGENTA)
	db ABRA
	db CLEFAIRY
	db NIDORINO
	db NIDORINA
ENDC
	db "@"

PrizeMenuMon1Cost:
IF DEF(_RED)
	bcd2 180
	bcd2 500
	bcd2 1200
ENDC
IF DEF(_BLUE)
	bcd2 120
	bcd2 750
	bcd2 1200
ENDC
IF DEF(_PURPLE)
	bcd2 150
	bcd2 625
	bcd2 1200
	bcd2 1200
ENDC
IF DEF(_MAGENTA)
	bcd2 150
	bcd2 625
	bcd2 1200
	bcd2 1200
ENDC
	db "@"
	


PrizeMenuMon2Entries:
IF DEF(_RED)
	db DRATINI
	db SCYTHER
	db PORYGON
ENDC
IF DEF(_BLUE)
	db PINSIR
	db DRATINI
	db PORYGON
ENDC
IF DEF(_PURPLE)
	db PINSIR
	db SCYTHER
	db DRATINI
	db PORYGON
ENDC
IF DEF(_MAGENTA)
	db PINSIR
	db SCYTHER
	db DRATINI
	db PORYGON
ENDC
	db "@"

PrizeMenuMon2Cost:
IF DEF(_RED)
	bcd2 2800
	bcd2 5500
	bcd2 9999
ENDC
IF DEF(_BLUE)
	bcd2 2500
	bcd2 4600
	bcd2 6500
ENDC
IF DEF(_PURPLE)
	bcd2 2650
	bcd2 2650
	bcd2 5500
	bcd2 6500
ENDC
IF DEF(_MAGENTA)
	bcd2 2650
	bcd2 2650
	bcd2 5500
	bcd2 6500
ENDC
	db "@"

PrizeMenuTMsEntries:
	db TM_DRAGON_RAGE
	db TM_HYPER_BEAM
	db TM_SUBSTITUTE
	db "@"

PrizeMenuTMsCost:
	bcd2 3300
	bcd2 5500
	bcd2 7700
	db "@"
	
ChampionMon1Entries:
IF DEF(_RED)
	db ABRA
	db CLEFAIRY
	db NIDORINA
ENDC
IF DEF(_BLUE)
	db ABRA
	db CLEFAIRY
	db NIDORINO
ENDC
IF DEF(_PURPLE)
	db EEVEE
	db BULBASAUR
	db CHARMANDER
	db SQUIRTLE
	db SNORLAX
	db MEW
ENDC
IF DEF(_MAGENTA)
	db BULBASAUR
	db CHARMANDER
	db SQUIRTLE
	db BULBASAUR
	db CHARMANDER
	db SQUIRTLE
ENDC
	db "@"

ChampionMon1Cost:
IF DEF(_RED)
	bcd2 180
	bcd2 500
	bcd2 1200
ENDC
IF DEF(_BLUE)
	bcd2 120
	bcd2 750
	bcd2 1200
ENDC
IF DEF(_PURPLE)
	bcd2 3000
	bcd2 3000
	bcd2 3000
	bcd2 3000
ENDC
IF DEF(_MAGENTA)
	bcd2 3000
	bcd2 3000
	bcd2 3000
	bcd2 3000
	bcd2 3000
	bcd2 3000
ENDC
	db "@"
	
ChampionMon2Entries:
IF DEF(_RED)
	db DRATINI
	db SCYTHER
	db PORYGON
ENDC
IF DEF(_BLUE)
	db PINSIR
	db DRATINI
	db PORYGON
ENDC
IF DEF(_PURPLE)
	db PINSIR
	db SCYTHER
	db DRATINI
	db PORYGON
ENDC
IF DEF(_MAGENTA)
	db PINSIR
	db SCYTHER
	db EEVEE
	db DRATINI
	db PORYGON
ENDC
	db "@"

ChampionMon2Cost:
IF DEF(_RED)
	bcd2 2800
	bcd2 5500
	bcd2 9999
ENDC
IF DEF(_BLUE)
	bcd2 2500
	bcd2 4600
	bcd2 6500
ENDC
IF DEF(_PURPLE)
	bcd2 2650
	bcd2 2650
	bcd2 5500
	bcd2 6500
ENDC
IF DEF(_MAGENTA)
	bcd2 2650
	bcd2 2650
	bcd2 3000
	bcd2 5500
	bcd2 6500
ENDC
	db "@"
	
ChampionTMsEntries:
	db TM_DRAGON_RAGE
	db TM_HYPER_BEAM
	db TM_SUBSTITUTE
	db HELIX_FOSSIL
	db DOME_FOSSIL
	db OLD_AMBER
	db "@"

ChampionTMsCost:
	bcd2 3300
	bcd2 5500
	bcd2 7700
	bcd2 9900
	bcd2 9900
	bcd2 9900
	db "@"