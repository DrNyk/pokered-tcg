VictoryRoad2FWildMons:
	def_grass_wildmons 10 ; encounter rate
	db 22, MACHOP
	db 24, GEODUDE
	db 26, ZUBAT
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
	db 39, HITMONLEE
	db 42, HITMONCHAN
ENDC
IF DEF(_MAGENTA)
	db 39, HITMONLEE
	db 42, HITMONCHAN
ENDC
	db 41, MACHOKE
	db 40, GOLBAT
	db 40, MAROWAK
	db 43, GRAVELER
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
