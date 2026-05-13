extends "../_Spring.gd"

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_cross_t(p0: float, p1: float, v0: float) -> float:
	var A := p0 - p1
	if EPS <= absf(A):
		var B := (v0 + get_omega(0) * get_zeta() * A) / get_omega(2)
		if EPS <= absf(B):
			var r := -A / B
			if absf(r) < 1.0 - EPS:
				var t_cross := atanh(r) / get_omega(2)
				return maxf(0.0, t_cross)
	return MAX

func solve_pv(p0: float, p1: float, v0: float, t: float) -> Vector2:
	var A := p0 - p1
	var B := (v0 + get_omega(0) * get_zeta() * A) / get_omega(2)
	var theta := minf(get_omega(2) * t, _MAX_OMEGA_T)
	var c := cosh(theta)
	var s := sinh(theta)
	var envelope := exp(-get_omega(0) * get_zeta() * t)
	var common := A * c + B * s
	return Vector2(
		envelope * common + p1,
		envelope * (-get_omega(0) * get_zeta() * common + (A * get_omega(2) * s + B * get_omega(2) * c)))

#-------------------------------------------------------------------------------

const _MAX_OMEGA_T := 500.0
