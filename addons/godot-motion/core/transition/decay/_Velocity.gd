extends "../_Decay.gd"

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

@warning_ignore("unused_parameter")
func resolve_target(p0: float, p1: float, v0: float) -> float:
	return p0 + v0 * get_power()
