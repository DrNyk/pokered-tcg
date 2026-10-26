VictoryRoad1FWildMons:
	def_grass_wildmons 15 ; encounter rate
	db 24, MACHOP
	db 26, GEODUDE
	db 22, ZUBAT
	db 36, ONIX
IF DEF(_RED)
	db 39, ONIX
	db 42, ONIX
ENDC
IF DEF(_BLUE)
	db 39, ONIX
	db 42, ONIX
ENDC
IF DEF(_PURPLE)
	db 39, HITMONCHAN
	db 42, HITMONLEE
ENDC
IF DEF(_MAGENTA)
	db 39, HITMONCHAN
	db 42, HITMONLEE
ENDC
	db 41, GRAVELER
	db 41, GOLBAT
	db 42, MACHOKE
	db 43, MAROWAK
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
