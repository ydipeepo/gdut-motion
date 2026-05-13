extends "../_Spring.gd"

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_cross_t(p0: float, p1: float, v0: float) -> float:
	var A := p0 - p1
	if EPS <= absf(A):
		var B := (v0 + get_omega(0) * get_zeta() * A) / get_omega(1)
		if EPS <= absf(A) or EPS <= absf(B):
			var phi := atan2(B, A)
			var t_cross := (phi + PI * 0.5) / get_omega(1)
			var period := PI / get_omega(1)
			if t_cross <= 0.0:
				t_cross += period * ceilf(-t_cross / period)
			return maxf(0.0, t_cross)
	return MAX

func solve_pv(p0: float, p1: float, v0: float, t: float) -> Vector2:
	var A := p0 - p1
	var B := (v0 + get_omega(0) * get_zeta() * A) / get_omega(1)
	if EPS <= sqrt(A * A + B * B):
		var theta := get_omega(1) * t
		var c := cos(theta)
		var s := sin(theta)
		var envelope := exp(-get_omega(0) * get_zeta() * t)
		var common := A * c + B * s
		return Vector2(
			envelope * common + p1,
			envelope * (-get_omega(0) * get_zeta() * common + (-A * get_omega(1) * s + B * get_omega(1) * c)))
	return Vector2(p1, 0.0)
