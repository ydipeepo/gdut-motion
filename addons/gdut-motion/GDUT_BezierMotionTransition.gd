class_name GDUT_BezierMotionTransition extends GDUT_PerceivedMotionTransition

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const MIN_X1 := 0.0
const MAX_X1 := 1.0
const DEFAULT_X1 := 0.7

const MIN_Y1 := -1.0
const MAX_Y1 := 2.0
const DEFAULT_Y1 := 0.1

const MIN_X2 := 0.0
const MAX_X2 := 1.0
const DEFAULT_X2 := 0.5

const MIN_Y2 := -1.0
const MAX_Y2 := 2.0
const DEFAULT_Y2 := 0.9

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_value(x: float) -> float:
	var u := _binary_subdivide_x(x)
	return _calc_bezier_y(u)

func get_prime(x: float) -> float:
	var u := _binary_subdivide_x(x)
	var dx := _get_slope_x(u)
	var dy := _get_slope_y(u)
	if absf(dx) <= EPSILON:
		return INF if 0.0 < dy else -INF
	return dy / dx

#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
=======
#
# Based on 'bezier-easing' (@gre) implementation:
# //github.com/gre/bezier-easing/blob/master/src/index.js
#

>>>>>>> Stashed changes
const _SUBDIVISION_MAX_ITERS := 10

var _x: Vector3
var _y: Vector3

<<<<<<< Updated upstream
#
# This bezier curve for transition easing function
# from 'bezier-easing' by Gaëtan Renaudeau (@gre)
#

=======
>>>>>>> Stashed changes
func _calc_bezier_x(t: float) -> float:
	return ((_x.x * t + _x.y) * t + _x.z) * t

func _calc_bezier_y(t: float) -> float:
	return ((_y.x * t + _y.y) * t + _y.z) * t

func _get_slope_x(t: float) -> float:
	return 3.0 * _x.x * t * t + 2.0 * _x.y * t + _x.z

func _get_slope_y(t: float) -> float:
	return 3.0 * _y.x * t * t + 2.0 * _y.y * t + _y.z

func _binary_subdivide_x(x: float) -> float:
	var a := 0.0
	var b := 1.0
	var current_x: float
	var current_t: float
	for i: int in _SUBDIVISION_MAX_ITERS:
		current_t = 0.5 * (a + b)
		current_x = _calc_bezier_x(current_t) - x
		if 0.0 < current_x:
			b = current_t
		else:
			a = current_t
		if absf(current_x) <= EPSILON:
			break
	return current_t

func _init(
	x1: float,
	y1: float,
	x2: float,
	y2: float,
	duration: float,
	initial_position: Variant,
	final_position: Variant,
	process: int,
	completion: Array) -> void:

	super(
		duration,
		initial_position,
		final_position,
		process,
		completion)

	assert(MIN_X1 <= x1 and x1 <= MAX_X1)
	assert(MIN_Y1 <= y1 and y1 <= MAX_Y1)
	assert(MIN_X2 <= x2 and x2 <= MAX_X2)
	assert(MIN_Y2 <= y2 and y2 <= MAX_Y2)

	_x.x = 1.0 - 3.0 * x2 + 3.0 * x1
	_x.y = 3.0 * x2 - 6.0 * x1
	_x.z = 3.0 * x1
	_y.x = 1.0 - 3.0 * y2 + 3.0 * y1
	_y.y = 3.0 * y2 - 6.0 * y1
	_y.z = 3.0 * y1
