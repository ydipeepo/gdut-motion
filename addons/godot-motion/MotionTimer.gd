@abstract
class_name MotionTimer

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

var total_ticks: int:
	get = get_total_ticks

var total: float:
	get = get_total

var delta_ticks: int:
	get = get_delta_ticks

var delta: float:
	get = get_delta

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

@abstract
func get_total_ticks() -> int

func get_total() -> float:
	return get_total_ticks() / 1000.0

@abstract
func get_delta_ticks() -> int

func get_delta() -> float:
	return get_delta_ticks() / 1000.0
