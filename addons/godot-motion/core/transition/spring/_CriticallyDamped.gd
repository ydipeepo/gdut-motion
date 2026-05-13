extends "../_Spring.gd"

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_cross_t(p0: float, p1: float, v0: float) -> float:
	var A := p0 - p1
	if EPS <= absf(A):
		var B := v0 + get_omega(0) * A
		if EPS <= absf(B):
			var t := -A / B
			if 0.0 < t:
				var t_cross := t
				return maxf(0.0, t_cross)
	return MAX

func solve_pv(p0: float, p1: float, v0: float, t: float) -> Vector2:
	var A := p0 - p1
	var envelope := exp(-get_omega(0) * get_zeta() * t)
	var common := A + (v0 + get_omega(0) * A) * t
	return Vector2(
		envelope * common + p1,
		envelope * (-get_omega(0) * get_zeta() * common + (v0 + get_omega(0) * A)))
